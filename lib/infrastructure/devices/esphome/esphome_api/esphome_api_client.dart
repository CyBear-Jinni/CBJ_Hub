import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cbj_hub/infrastructure/devices/esphome/esphome_api/esphome_objects_as_dart_objects.dart';
import 'package:cbj_hub/infrastructure/gen/aioesphomeapi/protoc_as_dart/aioesphomeapi/api.pbserver.dart';
import 'package:cbj_hub/utils.dart';

/// Client to interact with ESPHome device
/// TODO: All the code here need rewrite, manage to turn device on/off
/// TODO: Source: https://github.com/esphome/aioesphomeapi
class EspHomeApiClient {
  EspHomeApiClient({
    this.devicePort = 6053,
    this.devicePass,
  });

  Socket? _fSocket;
  String? devicePass;
  String? addressOfServer;
  late String deviceMdns;
  int devicePort;

  /// Responses stream from the device.
  /// Some responses come in chunks, this will help us with that.
  /// Each response will be converted to dart object and get passed away in
  /// the stream for the current listening function to decide if it part of their
  /// request and stop listening.
  /// Some request will just keep coming like ping request and button press.
  StreamController deviceResponseStream = StreamController();

  /// aioesphomeapi:
  /// fName = _connect_socket_connect
  /// Step 2 in connect process: connect the socket.
  Future<Socket> getSocket() async {
    if (_fSocket != null && _fSocket!.isBroadcast) {
      return _fSocket!;
    }
    addressOfServer ??= await getIpFromMdns('$deviceMdns.local');
    // TODO: Test if it is possible to connect to socket using the deviceMdns
    // TODO: instead of the address, suppose to be more consistent.

    return _fSocket = await Socket.connect(addressOfServer, devicePort);
  }

  Future<void> listenToResponses() async {
    final Socket socket = await getSocket();

    socket.listen(
      // handle data from the server
      (Uint8List data) {
        final int responseType = data[2];

        /// HelloRequest
        if (responseType == 1) {
          logger.v('responseType is HelloRequest');
        }

        /// HelloResponse
        else if (responseType == 2) {
          logger.v('responseType is HelloResponse');
          final HelloResponse? helloResponseData = bytesToHelloResponse(data);
          if (helloResponseData != null) {
            deviceResponseStream.add(
              EspHomeHelloResponseObject(
                apiVersionMajor: helloResponseData.apiVersionMajor,
                apiVersionMinor: helloResponseData.apiVersionMinor,
                serverInfo: helloResponseData.serverInfo,
              ),
            );
          }
          logger.v('HelloResponse data: ${helloResponseData?.serverInfo}');
          logger.v('');
        }

        /// ConnectRequest
        else if (responseType == 3) {
          logger.v('responseType is ConnectRequest');
        }

        /// ConnectResponse
        else if (responseType == 4) {
          logger.v('responseType is ConnectResponse');
          logger.v(
            'ConnectResponse data: ${utf8.decode(data.sublist(3), allowMalformed: true)}',
          );
          logger.v('Data: $data');
          if (data.length > 3) {
            logger.v('Password is wrong');
            devicePass = null;
          } else {
            logger.v('Correct password');
          }
          logger.v('');
        }

        /// DisconnectRequest
        else if (responseType == 5) {
          logger.v('responseType is DisconnectRequest');
        }

        /// DisconnectResponse
        else if (responseType == 6) {
          logger.v('responseType is DisconnectResponse');
        }

        /// PingRequest
        else if (responseType == 7) {
          logger.v('responseType is PingRequest');
          logger.v('PingRequest data: ${utf8.decode(data.sublist(3))}');
          logger.v('');
        }

        /// PingResponse
        else if (responseType == 8) {
          logger.v('responseType is PingResponse');
          logger.v('PingResponse data: ${utf8.decode(data.sublist(3))}');
          logger.v('');
        }

        /// DeviceInfoRequest
        else if (responseType == 9) {
          logger.v('responseType is DeviceInfoRequest');
        }

        /// DeviceInfoResponse
        else if (responseType == 10) {
          logger.v('responseType is DeviceInfoResponse');
          logger.v('DeviceInfoResponse data: $data');
          logger.v('');
        }

        /// ListEntitiesRequest
        else if (responseType == 11) {
          logger.v('responseType is ListEntitiesRequest');
        }

        /// ListEntitiesBinarySensorResponse
        else if (responseType == 12) {
          logger.v('responseType is ListEntitiesBinarySensorResponse');
        }

        /// ListEntitiesCoverResponse
        else if (responseType == 13) {
          logger.v('responseType is ListEntitiesCoverResponse');
        }

        /// ListEntitiesFanResponse
        else if (responseType == 14) {
          logger.v('responseType is ListEntitiesFanResponse');
        }

        /// ListEntitiesLightResponse
        else if (responseType == 15) {
          logger.v('responseType is ListEntitiesLightResponse');
        }

        /// ListEntitiesSensorResponse
        else if (responseType == 16) {
          logger.v('responseType is ListEntitiesSensorResponse');
        }

        /// ListEntitiesSwitchResponse
        else if (responseType == 17) {
          logger.v('responseType is ListEntitiesSwitchResponse');
          String dataPayload = '';

          try {
            dataPayload = data.length > 3 ? utf8.decode(data.sublist(3)) : '';

            logger.v(
              'ListEntitiesSwitchResponse data payload:'
              ' $dataPayload',
            );
          } catch (e) {
            logger.v(
              'ListEntitiesSwitchResponse data bytes:'
              ' $data',
            );
          }
          logger.v('');
        }

        /// ListEntitiesTextSensorResponse
        else if (responseType == 18) {
          logger.v('responseType is ListEntitiesTextSensorResponse');
        }

        /// dsaDoneResponse
        else if (responseType == 19) {
          logger.v('responseType is ListEntitiesDoneResponse');
          logger.v(
            'ListEntitiesDoneResponse data: ${utf8.decode(data.sublist(3))}',
          );
          logger.v('');
        }

        /// SubscribeStatesRequest
        else if (responseType == 20) {
          logger.v('responseType is SubscribeStatesRequest');
        }

        /// BinarySensorStateResponse
        else if (responseType == 21) {
          logger.v('responseType is BinarySensorStateResponse');
        }

        /// CoverStateResponse
        else if (responseType == 22) {
          logger.v('responseType is CoverStateResponse');
        }

        /// FanStateResponse
        else if (responseType == 23) {
          logger.v('responseType is FanStateResponse');
        }

        /// LightStateResponse
        else if (responseType == 24) {
          logger.v('responseType is LightStateResponse');
        }

        /// SensorStateResponse
        else if (responseType == 25) {
          logger.v('responseType is SensorStateResponse');
        }

        /// SwitchStateResponse
        else if (responseType == 26) {
          logger.v('responseType is SwitchStateResponse');
          logger.v('SwitchStateResponse data: $data}');
          logger.v('');
        }

        /// TextSensorStateResponse
        else if (responseType == 27) {
          logger.v('responseType is TextSensorStateResponse');
        }

        /// SubscribeLogsRequest
        else if (responseType == 28) {
          logger.v('responseType is SubscribeLogsRequest');
        }

        /// SubscribeLogsResponse
        else if (responseType == 29) {
          logger.v('responseType is SubscribeLogsResponse');
        }

        /// CoverCommandRequest
        else if (responseType == 30) {
          logger.v('responseType is CoverCommandRequest');
        }

        /// FanCommandRequest
        else if (responseType == 31) {
          logger.v('responseType is FanCommandRequest');
        }

        /// LightCommandRequest
        else if (responseType == 32) {
          logger.v('responseType is LightCommandRequest');
        }

        /// SwitchCommandRequest
        else if (responseType == 33) {
          logger.v('responseType is SwitchCommandRequest');
        }

        /// SubscribeHomeassistantServicesRequest
        else if (responseType == 34) {
          logger.v('responseType is SubscribeHomeassistantServicesRequest');
        }

        /// HomeassistantServiceResponse
        else if (responseType == 35) {
          logger.v('responseType is HomeassistantServiceResponse');
        }

        /// GetTimeRequest
        else if (responseType == 36) {
          logger.v('responseType is GetTimeRequest');
        }

        /// GetTimeResponse
        else if (responseType == 37) {
          logger.v('responseType is GetTimeResponse');
        }

        /// SubscribeHomeAssistantStatesRequest
        else if (responseType == 38) {
          logger.v('responseType is SubscribeHomeAssistantStatesRequest');
        }

        /// SubscribeHomeAssistantStateResponse
        else if (responseType == 39) {
          logger.v('responseType is SubscribeHomeAssistantStateResponse');
        }

        /// HomeAssistantStateResponse
        else if (responseType == 40) {
          logger.v('responseType is HomeAssistantStateResponse');
        }

        /// ListEntitiesServicesResponse
        else if (responseType == 41) {
          logger.v('responseType is ListEntitiesServicesResponse');
        }

        /// ExecuteServiceRequest
        else if (responseType == 42) {
          logger.v('responseType is ExecuteServiceRequest');
        }

        /// ListEntitiesCameraResponse
        else if (responseType == 43) {
          logger.v('responseType is ListEntitiesCameraResponse');
        }

        /// CameraImageResponse
        else if (responseType == 44) {
          logger.v('responseType is CameraImageResponse');
        }

        /// CameraImageRequest
        else if (responseType == 45) {
          logger.v('responseType is CameraImageRequest');
        }

        /// ListEntitiesClimateResponse
        else if (responseType == 46) {
          logger.v('responseType is ListEntitiesClimateResponse');
        }

        /// ClimateStateResponse
        else if (responseType == 47) {
          logger.v('responseType is ClimateStateResponse');
        }

        /// ClimateCommandRequest
        else if (responseType == 48) {
          logger.v('responseType is ClimateCommandRequest');
        }

        /// ListEntitiesNumberResponse
        else if (responseType == 49) {
          logger.v('responseType is ListEntitiesNumberResponse');
        }

        /// NumberStateResponse
        else if (responseType == 50) {
          logger.v('responseType is NumberStateResponse');
        }

        /// NumberCommandRequest
        else if (responseType == 51) {
          logger.v('responseType is NumberCommandRequest');
        }

        /// ListEntitiesSelectResponse
        else if (responseType == 52) {
          logger.v('responseType is ListEntitiesSelectResponse');
        }

        /// SelectStateResponse
        else if (responseType == 53) {
          logger.v('responseType is SelectStateResponse');
        }

        /// SelectCommandRequest
        else if (responseType == 54) {
          logger.v('responseType is SelectCommandRequest');
        } else {
          logger.v('responseType is else');
          logger.v('Listen to data $data');
          logger.v('');
        }
      },

      // handle errors
      onError: (error) {
        logger.e(error);
        socket.destroy();
      },

      // handle server ending connection
      onDone: () {
        logger.v('Server left.');
        socket.destroy();
      },
    );
  }

  Future<void> sendConnect() async {
    final Socket socket = await getSocket();

    await _helloRequestToEsp();

    final ConnectRequest connectRequest =
        ConnectRequest(password: '\n\n$devicePass');

    const int numOfByteBeforeData = 3;

    final List<int> list = utf8.encode(connectRequest.password);

    final int totalSizeToTransfer = numOfByteBeforeData + list.length;

    final Uint8List message = Uint8List(totalSizeToTransfer);

    final ByteData byteData = ByteData.view(message.buffer);

    /// First, a message in this protocol has a specific format:

    /// A zero byte.
    byteData.setUint8(0, 0x00);

    /// VarInt denoting the size of the message object.
    /// (type is not part of this)
    byteData.setUint8(1, list.length);

    ///  * VarInt denoting the type of message.
    byteData.setUint8(2, 3);

//  * The message object encoded as a ProtoBuf message

    for (int i = numOfByteBeforeData;
        i < list.length + numOfByteBeforeData;
        i++) {
      byteData.setUint8(i, list[i - numOfByteBeforeData]);
    }

    socket.add(message);
  }

  Future<void> disconnect() async {
    await (await getSocket()).close();
  }

  /// aioesphomeapi:
  /// fName = _connect_hello
  /// Step 4 in connect process: send hello and get api version.
  Future<void> _helloRequestToEsp() async {
    // connect to the socket server
    final Socket socket = await getSocket();

    const String clientName = 'aioesphomeapi';

    final HelloRequest helloRequest =
        HelloRequest(clientInfo: '\n\r$clientName');

    const int numOfByteBeforeData = 3;

    final List<int> clientInfoAsIntList = utf8.encode(helloRequest.clientInfo);

    final int totalSizeToTransfer =
        numOfByteBeforeData + clientInfoAsIntList.length;

    final Uint8List message = Uint8List(totalSizeToTransfer);

    final ByteData byteData = ByteData.view(message.buffer);

    /// First, a message in this protocol has a specific format:

    /// A zero byte.
    byteData.setUint8(0, 0x00);

    /// VarInt denoting the size of the message object.
    /// (type is not part of this)
    byteData.setUint8(1, clientInfoAsIntList.length);

    ///  * VarInt denoting the type of message.
    byteData.setUint8(2, 1);

//  * The message object encoded as a ProtoBuf message

    for (int i = numOfByteBeforeData;
        i < clientInfoAsIntList.length + numOfByteBeforeData;
        i++) {
      byteData.setUint8(i, clientInfoAsIntList[i - numOfByteBeforeData]);
    }

    socket.add(message);
  }

  Future<void> connectRequestToEsp() async {
    // connect to the socket server
    final socket = await getSocket();

    final ConnectRequest connectRequest = ConnectRequest(password: devicePass);

    final List<int> passwordAsIntList = utf8.encode(connectRequest.password);

    const int numOfBytesBeforeData = 3;

    // final List<int> list = utf8.encode(helloRequest.password);

    final int totalSizeToTransfer =
        numOfBytesBeforeData + passwordAsIntList.length;

    final Uint8List message = Uint8List(totalSizeToTransfer);

    final ByteData byteData = ByteData.view(message.buffer);

    /// First, a message in this protocol has a specific format:

    /// A zero byte.
    byteData.setUint8(0, 0x00);

    /// VarInt denoting the size of the message object.
    /// (type is not part of this)
    byteData.setUint8(1, connectRequest.password.length);

    ///  * VarInt denoting the type of message.
    byteData.setUint8(2, 3);

//  * The message object encoded as a ProtoBuf message
//
    for (int i = numOfBytesBeforeData;
        i < connectRequest.password.length + numOfBytesBeforeData;
        i++) {
      byteData.setUint8(i, passwordAsIntList[i - numOfBytesBeforeData]);
    }

    socket.add(message);
  }

  /// aioesphomeapi:
  /// fName = _connect_start_ping
  /// Step 5 in connect process: start the ping loop.
  Future<void> ping() async {
    // connect to the socket server
    final socket = await getSocket();
    logger.v(
      'Connected request to: '
      '${socket.remoteAddress.address}:${socket.remotePort}',
    );

    final PingRequest pingRequest = PingRequest();

    const int numOfByteBeforeData = 3;

    const int totalSizeToTransfer = numOfByteBeforeData;

    final Uint8List message = Uint8List(totalSizeToTransfer);

    final ByteData byteData = ByteData.view(message.buffer);

    /// First, a message in this protocol has a specific format:

    /// A zero byte.
    byteData.setUint8(0, 0x00);

    /// VarInt denoting the size of the message object.
    /// (type is not part of this)
    byteData.setUint8(1, 0);

    ///  * VarInt denoting the type of message.
    byteData.setUint8(2, 7);

//  * The message object encoded as a ProtoBuf message

    socket.add(message);
  }

  Future<void> deviceInfoRequestToEsp() async {
    // connect to the socket server
    final socket = await getSocket();
    logger.v(
      'Connected request to:'
      ' ${socket.remoteAddress.address}:${socket.remotePort}',
    );

    final DeviceInfoRequest deviceInfoRequest = DeviceInfoRequest();

    const int numOfByteBeforeData = 3;

    // final List<int> list = utf8.encode(helloRequest.toString());

    const int totalSizeToTransfer = numOfByteBeforeData;

    final Uint8List message = Uint8List(totalSizeToTransfer);

    final ByteData byteData = ByteData.view(message.buffer);

    /// First, a message in this protocol has a specific format:

    /// A zero byte.
    byteData.setUint8(0, 0x00);

    /// VarInt denoting the size of the message object.
    /// (type is not part of this)
    byteData.setUint8(1, 0);

    ///  * VarInt denoting the type of message.
    byteData.setUint8(2, 9);

    socket.add(message);
  }

  Future<void> subscribeStatesRequest() async {
    // connect to the socket server
    final socket = await getSocket();
    logger.v(
      'Connected request to:'
      ' ${socket.remoteAddress.address}:${socket.remotePort}',
    );

    final SubscribeStatesRequest subscribeStateReq = SubscribeStatesRequest();

    const int numOfByteBeforeData = 3;

    // final List<int> list = utf8.encode(helloRequest.toString());

    const int totalSizeToTransfer = numOfByteBeforeData;

    final Uint8List message = Uint8List(totalSizeToTransfer);

    final ByteData byteData = ByteData.view(message.buffer);

    /// First, a message in this protocol has a specific format:

    /// A zero byte.
    byteData.setUint8(0, 0x00);

    /// VarInt denoting the size of the message object.
    /// (type is not part of this)
    byteData.setUint8(1, 0);

    ///  * VarInt denoting the type of message.
    byteData.setUint8(2, 20);

    socket.add(message);
  }

  Future<void> switchCommandRequest(int deviceKey, bool changeTostate) async {
    if (devicePass == null) {
      logger.v('Please call sendConnect, password is missing');
      return;
    }
    // connect to the socket server
    final socket = await getSocket();
    logger.v(
      'Connected request to:'
      ' ${socket.remoteAddress.address}:${socket.remotePort}',
    );

    final SwitchCommandRequest switchCommandRequest =
        SwitchCommandRequest(key: deviceKey, state: changeTostate);

    final String myHexKey =
        switchCommandRequest.key.toRadixString(16).padLeft(4, '0');

    List<int> myHexKeyList = [];

    for (int i = 0; i < myHexKey.length; i += 2) {
      myHexKeyList.add(int.parse('0x${myHexKey.substring(i, i + 2)}'));
    }

    myHexKeyList = List.from(myHexKeyList.reversed);
    myHexKeyList.insert(0, 13);

    if (changeTostate == true) {
      myHexKeyList.add(16);
      myHexKeyList.add(1);
    }

    const int numOfByteBeforeData = 3;

    final int totalSizeToTransfer = numOfByteBeforeData + myHexKeyList.length;

    final Uint8List message = Uint8List(totalSizeToTransfer);

    final ByteData byteData = ByteData.view(message.buffer);

    logger.v(myHexKeyList);

    /// A zero byte.
    byteData.setUint8(0, 0x00);

    /// VarInt denoting the size of the message object.
    /// (type is not part of this)
    byteData.setUint8(1, myHexKeyList.length);

    ///  * VarInt denoting the type of message.
    byteData.setUint8(2, 33);

    for (int a = numOfByteBeforeData;
        a < myHexKeyList.length + numOfByteBeforeData;
        a++) {
      byteData.setUint8(a, myHexKeyList[a - numOfByteBeforeData]);
    }

    logger.v('switchCommandRequest message: $message');

//  * The message object encoded as a ProtoBuf message
    socket.add(message);
    await Future.delayed(const Duration(milliseconds: 1000));
  }

  Future<void> listEntitiesRequest() async {
    if (devicePass == null) {
      logger.v('Please call sendConnect, password is missing');
      return;
    }
    // connect to the socket server
    final socket = await getSocket();
    logger.v(
      'Connected request to:'
      ' ${socket.remoteAddress.address}:${socket.remotePort}',
    );

    final ListEntitiesRequest listEntitiesRequest = ListEntitiesRequest();

    const int numOfByteBeforeData = 3;

    const int totalSizeToTransfer = numOfByteBeforeData;

    final Uint8List message = Uint8List(totalSizeToTransfer);

    final ByteData byteData = ByteData.view(message.buffer);

    /// A zero byte.
    byteData.setUint8(0, 0x00);

    /// VarInt denoting the size of the message object.
    /// (type is not part of this)
    byteData.setUint8(1, 0);

    ///  * VarInt denoting the type of message.
    byteData.setUint8(2, 11);

    logger.v('ListEntitiesRequest message: $message');

//  * The message object encoded as a ProtoBuf message
    socket.add(message);
  }

  static HelloResponse? bytesToHelloResponse(List<int> bytes) {
    // Check if request is hello response
    if (bytes[2] != 2) {
      return null;
    }

    final HelloResponse helloResponse = HelloResponse();

    final List<int> responseBytes = bytes.sublist(3);
    helloResponse.serverInfo = utf8.decode(responseBytes);

    return helloResponse;
  }

  /// aioesphomeapi:
  /// fName = _connect_init_frame_helper
  /// Step 3 in connect process: initialize the frame helper and init read loop.
  Future<void> connectInitFrameHelper() async {
    final Socket socket = await getSocket();

    await listenToResponses();
  }

  /// Gets mDNS name and return the IP of that device
  /// aioesphomeapi:
  /// fName = _connect_resolve_host
  /// Step 1 in connect process: resolve the address.
  static Future<String?> getIpFromMdns(String deviceMdnsName) async {
    try {
      final List<InternetAddress> deviceIpList =
          await InternetAddress.lookup(deviceMdnsName);
      if (deviceIpList.isNotEmpty) {
        return deviceIpList[0].address;
      }
    } catch (e) {
      logger.e(
        'Crash when searching the IP for device with mDNS\n$e',
      );
    }

    return null;
  }
}
