import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:crclib/crclib.dart';
import 'package:cbj_hub/utils.dart';

class SwitcherApiObject {
  SwitcherApiObject({
    required this.deviceType,
    required this.deviceId,
    required this.switcherIp,
    required this.switcherName,
    required this.powerConsumption,
    required this.macAddress,
    this.deviceState = SwitcherDeviceState.cantGetState,
    this.deviceDirection = SwitcherDeviceDirection.cantGetState,
    this.devicePass = '00000000',
    this.phoneId = '0000',
    this.statusSocket,
    this.log,
    this.port = SWITCHER_TCP_PORT,
    this.lastShutdownRemainingSecondsValue,
    this.remainingTimeForExecution,
  });

  factory SwitcherApiObject.createWithBytes(Datagram datagram) {
    final Uint8List data = datagram.data;

    final List<String> messageBuffer = intListToHex(data);

    final List<String> hexSeparatedLetters = [];

    for (final String hexValue in messageBuffer) {
      hexValue.runes.forEach((element) {
        hexSeparatedLetters.add(String.fromCharCode(element));
      });
    }

    if (!isSwitcherMessage(data, hexSeparatedLetters) &&
        !isSwitcherMessageNew(data, hexSeparatedLetters)) {
      print('Not a switcher message arrived to here');
    }

    final SwitcherDevicesTypes sDeviceType = getDeviceType(messageBuffer);
    final String deviceId = extractDeviceId(hexSeparatedLetters);
    // final String switcherIp = extractIpAddr(hexSeparatedLetters);
    final String switcherIp = datagram.address.address;
    final String switcherMac = extractMac(hexSeparatedLetters);
    final String powerConsumption =
        extractPowerConsumption(hexSeparatedLetters);

    final String switcherName = extractDeviceName(data);

    final String getRemaining =
        extractRemainingTimeForExecution(hexSeparatedLetters);
    final String lastShutdownRemainingSecondsValue =
        extractShutdownRemainingSeconds(hexSeparatedLetters);

    if (sDeviceType == SwitcherDevicesTypes.switcherRunner ||
        sDeviceType == SwitcherDevicesTypes.switcherRunnerMini) {
      if (!isSwitcherMessageNew(data, hexSeparatedLetters)) {
        print('Not new switcher device!');
      }

      final SwitcherDeviceDirection switcherDeviceDirection =
          extractSwitchDirection(hexSeparatedLetters);

      return SwitcherApiObject(
        deviceType: sDeviceType,
        deviceId: deviceId,
        switcherIp: switcherIp,
        deviceDirection: switcherDeviceDirection,
        switcherName: switcherName,
        macAddress: switcherMac,
        powerConsumption: powerConsumption,
        port: SWITCHER_TCP_PORT2,
      );
    }

    if (!isSwitcherMessage(data, hexSeparatedLetters)) {
      print('Not old switcher device!');
    }

    final SwitcherDeviceState switcherDeviceState =
        extractSwitchState(hexSeparatedLetters);

    return SwitcherApiObject(
      deviceType: sDeviceType,
      deviceId: deviceId,
      switcherIp: switcherIp,
      deviceState: switcherDeviceState,
      switcherName: switcherName,
      macAddress: switcherMac,
      lastShutdownRemainingSecondsValue: lastShutdownRemainingSecondsValue,
      powerConsumption: powerConsumption,
      remainingTimeForExecution: getRemaining,
      port: SWITCHER_TCP_PORT,
    );
  }

  String deviceId;
  String switcherIp;
  SwitcherDevicesTypes deviceType;
  SwitcherDeviceState deviceState;
  SwitcherDeviceDirection deviceDirection;
  int port;
  String switcherName;
  String phoneId;
  String powerConsumption;
  String devicePass;
  String macAddress;
  String? remainingTimeForExecution;
  String? log;
  String? statusSocket;
  String? lastShutdownRemainingSecondsValue;

  Socket? _socket;

  String? pSession;

  static const SWITCHER_TCP_PORT = 9957;
  static const SWITCHER_TCP_PORT2 = 10000;

  static const pSessionValue = '00000000';
  static const pKey = '00000000000000000000000000000000';

  static const statusEvent = 'status';
  static const readyEvent = 'ready';
  static const errorEvent = 'error';
  static const stateChangedEvent = 'state';

  static const switcherUdpIp = '0.0.0.0';
  static const switcherUdpPort = 20002;

  static const offValue = '0';
  static const onValue = '1';

  static bool isSwitcherMessage(
      Uint8List data, List<String> hexSeparatedLetters) {
    // Verify the broadcast message had originated from a switcher device.
    return hexSeparatedLetters.sublist(0, 4).join() == 'fef0' &&
        data.length == 165;
  }

  static bool isSwitcherMessageNew(
      Uint8List data, List<String> hexSeparatedLetters) {
    // Verify the broadcast message had originated from a switcher device.
    return hexSeparatedLetters.sublist(0, 4).join() == 'fef0' &&
        data.length == 159;
  }

  static SwitcherDevicesTypes getDeviceType(List<String> messageBuffer) {
    SwitcherDevicesTypes sDevicesTypes = SwitcherDevicesTypes.notRecognized;

    final String hexModel = messageBuffer.sublist(75, 76)[0].toString();

    if (hexModel == '0f') {
      sDevicesTypes = SwitcherDevicesTypes.switcherMini;
    } else if (hexModel == 'a8') {
      sDevicesTypes = SwitcherDevicesTypes.switcherPowerPlug;
    } else if (hexModel == '0b') {
      sDevicesTypes = SwitcherDevicesTypes.switcherTouch;
    } else if (hexModel == 'a7') {
      sDevicesTypes = SwitcherDevicesTypes.switcherV2Esp;
    } else if (hexModel == 'a1') {
      sDevicesTypes = SwitcherDevicesTypes.switcherV2qualcomm;
    } else if (hexModel == '17') {
      sDevicesTypes = SwitcherDevicesTypes.switcherV4;
    } else if (hexModel == '01') {
      sDevicesTypes = SwitcherDevicesTypes.switcherRunner;
    } else if (hexModel == '02') {
      sDevicesTypes = SwitcherDevicesTypes.switcherRunnerMini;
    } else {
      print('New device type? hexModel:$hexModel');
    }

    return sDevicesTypes;
  }

  Future<void> turnOn({int duration = 0}) async {
    final String offCommand = '${onValue}00${_timerValue(duration)}';

    await _runPowerCommand(offCommand);
  }

  Future<void> turnOff() async {
    const String offCommand = '${offValue}0000000000';
    await _runPowerCommand(offCommand);
  }

  Future<void> _runPowerCommand(String commandType) async {
    pSession = await _login();
    if (pSession == 'B') {
      print('Switcher error');
      return;
    }
    var data =
        'fef05d0002320102${pSession!}340001000000000000000000${_getTimeStamp()}'
        '00000000000000000000f0fe${deviceId}00${phoneId}0000$devicePass'
        '000000000000000000000000000000000000000000000000000000000106000'
        '$commandType';

    data = await _crcSignFullPacketComKey(data, pKey);

    _socket = await getSocket();
    _socket!.add(hexStringToDecimalList(data));
    await _socket?.close();
    _socket = null;
    // Uint8List dataFromDevice = await socket.first;
    // print(dataFromDevice);
  }

  /// Sets the position of the blinds, 0 is down 100 is up
  Future<void> setPosition({int pos = 0}) async {
    if (deviceType != SwitcherDevicesTypes.switcherRunner &&
        deviceType != SwitcherDevicesTypes.switcherRunnerMini) {
      print('Set position support only blinds');
      return;
    }

    final String positionCommand = _getHexPos(pos: pos);
    _runPositionCommand(positionCommand);
  }

  String _getHexPos({int pos = 0}) {
    String posAsHex = intListToHex([pos]).join();
    if (posAsHex.length < 2) {
      posAsHex = '0$posAsHex';
    }
    return posAsHex;
  }

  Future<void> _runPositionCommand(String positionCommand) async {
    final int pos = int.parse(positionCommand, radix: 16);
    pSession = await _login2();
    if (pSession == 'B') {
      print('Switcher error');
      return;
    }
    var data =
        'fef0580003050102${pSession!}290401000000000000000000${_getTimeStamp()}'
        '00000000000000000000f0fe${deviceId}00${phoneId}0000$devicePass'
        '00000000000000000000000000000000000000000000000000000037010100'
        '$positionCommand';

    data = await _crcSignFullPacketComKey(data, pKey);

    _socket = await getSocket();
    _socket!.add(hexStringToDecimalList(data));
    await _socket?.close();
    _socket = null;

    // Uint8List dataFromDevice = await socket.first;
    // print(dataFromDevice);
  }

  /// Used for sending actions to the device
  void sendState({required SwitcherDeviceState command, int minutes = 0}) {
    _getFullState();
  }

  /// Used for sending the get state packet to the device.
  /// Returns a tuple of hex timestamp,
  /// session id and an instance of SwitcherStateResponse
  Future<String> _getFullState() async {
    return _login();
  }

  /// Used for sending the login packet to the device.
  Future<String> _login() async {
    try {
      String data = 'fef052000232a100${pSessionValue}340001000000000000000000'
          '${_getTimeStamp()}00000000000000000000f0fe1c00${phoneId}0000'
          '$devicePass'
          '00000000000000000000000000000000000000000000000000000000';

      data = await _crcSignFullPacketComKey(data, pKey);
      _socket = await getSocket();
      if (_socket == null) {
        throw 'Error';
      }

      _socket!.add(hexStringToDecimalList(data));

      final Uint8List firstData = await _socket!.first;
      final String resultSession =
          substrLikeInJavaScript(intListToHex(firstData).join(), 16, 8);

      return resultSession;
    } catch (error) {
      log = 'login failed due to an error $error';
      logger.e(log);
      pSession = 'B';
    }
    return pSession!;
  }

  /// Used for sending the login packet to switcher runner.
  Future<String> _login2() async {
    // if (pSession != null) return pSession!;

    try {
      String data = 'fef030000305a600${pSessionValue}ff0301000000$phoneId'
          '00000000${_getTimeStamp()}00000000000000000000f0fe${deviceId}00';

      data = await _crcSignFullPacketComKey(data, pKey);
      _socket = await getSocket();
      if (_socket == null) {
        throw 'Error';
      }

      _socket!.add(hexStringToDecimalList(data));

      final Uint8List firstData = await _socket!.first;

      final String resultSession =
          substrLikeInJavaScript(intListToHex(firstData).join(), 16, 8);

      return resultSession;
    } catch (error) {
      log = 'login2 failed due to an error $error';
      logger.e(log);
      pSession = 'B';
    }
    return pSession!;
  }

  static Future<String> _crcSignFullPacketComKey(
      String pData, String pKey) async {
    String pDataTemp = pData;
    final List<int> bufferHex = hexStringToDecimalList(pDataTemp);

    String crc = intListToHex(packBigEndian(
            int.parse(Crc16XmodemWith0x1021().convert(bufferHex).toString())))
        .join();

    pDataTemp = pDataTemp +
        substrLikeInJavaScript(crc, 6, 2) +
        substrLikeInJavaScript(crc, 4, 2);

    crc = substrLikeInJavaScript(crc, 6, 2) +
        substrLikeInJavaScript(crc, 4, 2) +
        getUtf8Encoded(pKey);

    crc = intListToHex(packBigEndian(int.parse(Crc16XmodemWith0x1021()
            .convert(hexStringToDecimalList(crc))
            .toString())))
        .join();

    return pDataTemp +
        substrLikeInJavaScript(crc, 6, 2) +
        substrLikeInJavaScript(crc, 4, 2);
  }

  static String _getTimeStamp() {
    final int timeInSeconds = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    final List<int> timeInBytes = packLittleEndian(timeInSeconds);

    return intListToHex(timeInBytes).join();
  }

  /// Same as Buffer.from(value, 'hex') in JavaScript
  static List<int> hexStringToDecimalList(String hex) {
    final List<int> decimalIntList = [];
    String twoNumbers = '';

    for (int i = 0; i < hex.length; i++) {
      if (twoNumbers == '') {
        twoNumbers = twoNumbers + hex[i];
        continue;
      } else {
        twoNumbers = twoNumbers + hex[i];
        decimalIntList.add(int.parse(twoNumbers, radix: 16));
        twoNumbers = '';
      }
    }
    return decimalIntList;
  }

  /// Convert number to unsigned integer as little-endian sequence of bytes
  /// Same as struct.pack('<I', value) in JavaScript
  static List<int> packLittleEndian(int valueToConvert) {
    final ByteData sendValueBytes = ByteData(8);

    try {
      sendValueBytes.setUint64(0, valueToConvert, Endian.little);
    } on UnsupportedError {
      sendValueBytes.setUint32(0, valueToConvert, Endian.little);
    }

    final Uint8List timeInBytes = sendValueBytes.buffer.asUint8List();
    return timeInBytes.sublist(0, timeInBytes.length - 4);
  }

  /// Convert number to unsigned integer as big-endian sequence of bytes
  /// Same as struct.pack('>I', value) in JavaScript
  static List<int> packBigEndian(int valueToConvert) {
    final ByteData sendValueBytes = ByteData(8);

    try {
      sendValueBytes.setUint64(0, valueToConvert);
    } on UnsupportedError {
      sendValueBytes.setUint32(0, valueToConvert);
    }

    final Uint8List timeInBytes = sendValueBytes.buffer.asUint8List();
    return timeInBytes.sublist(4);
  }

  /// Convert list of bytes/integers into their hex 16 value with padding 2 of 0
  /// Same as .toString('hex'); in JavaScript
  static List<String> intListToHex(List<int> bytes) {
    final List<String> messageBuffer = [];

    for (final int unit8 in bytes) {
      messageBuffer.add(unit8.toRadixString(16).padLeft(2, '0'));
    }
    return messageBuffer;
  }

  /// Generate hexadecimal representation of the current timestamp.
  /// Return: Hexadecimal representation of the current
  /// unix time retrieved by ``time.time``.
  String currentTimestampToHexadecimal() {
    final String currentTimeSinceEpoch =
        DateTime.now().millisecondsSinceEpoch.toString();
    final String currentTimeRounded =
        currentTimeSinceEpoch.substring(0, currentTimeSinceEpoch.length - 3);

    final int currentTimeInt = int.parse(currentTimeRounded);

    return currentTimeInt.toRadixString(16).padLeft(2, '0');
  }

  /// Extract the IP address from the broadcast message.
  static String extractIpAddr(List<String> hexSeparatedLetters) {
    final String ipAddrSection =
        substrLikeInJavaScript(hexSeparatedLetters.join(), 152, 8);

    final int ipAddrInt = int.parse(
        substrLikeInJavaScript(ipAddrSection, 0, 2) +
            substrLikeInJavaScript(ipAddrSection, 2, 2) +
            substrLikeInJavaScript(ipAddrSection, 4, 2) +
            substrLikeInJavaScript(ipAddrSection, 6, 2),
        radix: 16);
    return ipAddrInt.toString();
  }

  static String extractPowerConsumption(List<String> hexSeparatedLetters) {
    final List<String> hexPowerConsumption =
        hexSeparatedLetters.sublist(270, 278);
    return hexPowerConsumption.join();
  }

  /// Extract the time remains for the current execution.
  static String extractRemainingTimeForExecution(
      List<String> hexSeparatedLetters) {
    final List<String> hexPowerConsumption =
        hexSeparatedLetters.sublist(294, 302);
    try {
      final int sum = int.parse(hexPowerConsumption.sublist(6, 8).join()) +
          int.parse(hexPowerConsumption.sublist(4, 6).join()) +
          int.parse(hexPowerConsumption.sublist(2, 4).join()) +
          int.parse(hexPowerConsumption.sublist(0, 2).join());
      return sum.toString();
    } catch (e) {
      return hexPowerConsumption.join();
    }
  }

  /// Substring like in JavaScript
  /// If first index is bigger than second index than it will cut until the
  /// first and will get the second index number of characters from there
  static String substrLikeInJavaScript(
      String text, int firstIndex, int secondIndex) {
    String tempText = text;
    if (firstIndex > secondIndex) {
      tempText = tempText.substring(firstIndex);
      tempText = tempText.substring(0, secondIndex);
    } else {
      tempText = tempText.substring(firstIndex, secondIndex);
    }
    return tempText;
  }

  static String extractMac(List<String> hexSeparatedLetters) {
    final String macNoColon =
        hexSeparatedLetters.sublist(160, 172).join().toUpperCase();
    final String macAddress = '${macNoColon.substring(0, 2)}:'
        '${macNoColon.substring(2, 4)}:${macNoColon.substring(4, 6)}:'
        '${macNoColon.substring(6, 8)}:${macNoColon.substring(8, 10)}:'
        '${macNoColon.substring(10, 12)}';

    return macAddress;
  }

  static String extractDeviceName(List<int> data) {
    return utf8.decode(data.sublist(42, 74));
  }

  /// Same as Buffer.from(value) in javascript
  /// Not to be confused with Buffer.from(value, 'hex')
  static String getUtf8Encoded(String list) {
    final List<int> encoded = utf8.encode(list);

    return intListToHex(encoded).join();
  }

  static String extractShutdownRemainingSeconds(
      List<String> hexSeparatedLetters) {
    // final String hexAutoShutdownVal =
    //     hexSeparatedLetters.sublist(310, 318).join();
    final String timeLeftSeconds =
        substrLikeInJavaScript(hexSeparatedLetters.join(), 294, 8);

    return int.parse(
            substrLikeInJavaScript(timeLeftSeconds, 6, 8) +
                substrLikeInJavaScript(timeLeftSeconds, 4, 6) +
                substrLikeInJavaScript(timeLeftSeconds, 2, 4) +
                substrLikeInJavaScript(timeLeftSeconds, 0, 2),
            radix: 16)
        .toString();
  }

  static String extractDeviceId(List<String> hexSeparatedLetters) {
    return hexSeparatedLetters.sublist(36, 42).join();
  }

  static SwitcherDeviceState extractSwitchState(
      List<String> hexSeparatedLetters) {
    SwitcherDeviceState switcherDeviceState = SwitcherDeviceState.cantGetState;

    final String hexModel =
        substrLikeInJavaScript(hexSeparatedLetters.join(), 266, 4);

    if (hexModel == '0100') {
      switcherDeviceState = SwitcherDeviceState.on;
    } else if (hexModel == '0000') {
      switcherDeviceState = SwitcherDeviceState.off;
    } else {
      print('Switcher state is not recognized: $hexModel');
    }
    return switcherDeviceState;
  }

  static SwitcherDeviceDirection extractSwitchDirection(
      List<String> hexSeparatedLetters) {
    SwitcherDeviceDirection switcherDeviceState =
        SwitcherDeviceDirection.cantGetState;

    final String hexModel =
        substrLikeInJavaScript(hexSeparatedLetters.join(), 274, 4);

    if (hexModel == '0000') {
      switcherDeviceState = SwitcherDeviceDirection.stop;
    } else if (hexModel == '0100') {
      switcherDeviceState = SwitcherDeviceDirection.up;
    } else if (hexModel == '0001') {
      switcherDeviceState = SwitcherDeviceDirection.down;
    } else {
      print('Switcher direction is not recognized: $hexModel');
    }
    return switcherDeviceState;
  }

  Future<Socket> getSocket() async {
    if (_socket != null) {
      return _socket!;
    }

    try {
      final Socket socket = await _connect(switcherIp, port);
      return socket;
    } catch (e) {
      _socket = null;
      logger.e('Error connecting to socket for switcher device: $e');
      rethrow;
    }
  }

  Future<Socket> _connect(String ip, int port) async {
    return Socket.connect(ip, port);
  }

  String _timerValue(int minutes) {
    if (minutes == 0) {
      // when duration set to zero, Switcher sends regular on command
      return '00000000';
    }
    final seconds = minutes * 60;
    return intListToHex(packLittleEndian(seconds)).join();
  }
}

class Crc16XmodemWith0x1021 extends ParametricCrc {
  Crc16XmodemWith0x1021()
      : super(16, 0x1021, 0x1021, 0x0000,
            inputReflected: false, outputReflected: false);
}

enum SwitcherDeviceDirection {
  cantGetState,
  stop, // '0000'
  up, // '0100'
  down, // '0001'
}

/// Enum class representing the device's state.
enum SwitcherDeviceState {
  cantGetState,
  on, // '0100'
  off, // '0000'
}

/// Enum for relaying the type of the switcher devices.
enum SwitcherDevicesTypes {
  notRecognized,
  switcherMini, // MINI = "Switcher Mini", "0f", DeviceCategory.WATER_HEATER
  switcherPowerPlug, // POWER_PLUG = "Switcher Power Plug", "a8", DeviceCategory.POWER_PLUG
  switcherTouch, // TOUCH = "Switcher Touch", "0b", DeviceCategory.WATER_HEATER
  switcherV2Esp, // V2_ESP = "Switcher V2 (esp)", "a7", DeviceCategory.WATER_HEATER
  switcherV2qualcomm, // V2_QCA = "Switcher V2 (qualcomm)", "a1", DeviceCategory.WATER_HEATER
  switcherV4, // V4 = "Switcher V4", "17", DeviceCategory.WATER_HEATER
  switcherRunner, // runner = "Switcher Runner", "01", DeviceCategory.Blinds
  switcherRunnerMini, // runner_mini = "Switcher Runner Mini", "02", DeviceCategory.Blinds
}
