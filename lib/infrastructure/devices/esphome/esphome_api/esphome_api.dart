import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cbj_hub/infrastructure/gen/aioesphomeapi/protoc_as_dart/aioesphomeapi/api.pbserver.dart';
import 'package:cbj_hub/utils.dart';

class EspHomeApi {
  EspHomeApi(this.fSocket);

  factory EspHomeApi.createWithAddress(String addressOfServer) {
    final Future<Socket> socket = Socket.connect(addressOfServer, 6053);

    return EspHomeApi(socket);
  }

  Future<Socket> fSocket;
  String? devicePass;

  Future<void> listenToResponses() async {
    final Socket socket = await fSocket;

    socket.listen(
      // handle data from the server
      (Uint8List data) {
        final int responseType = data[2];

        /// ConnectResponse
        if (responseType == 4) {
          print('responseType is ConnectResponse');
          print('ConnectResponse data: ${utf8.decode(data.sublist(3))}');
          print('Data: $data');
          if (data.length > 3) {
            print('Password is wrong');
            devicePass = null;
          } else {
            print('Correct password');
          }
          print('');
        }

        /// HelloResponse
        else if (responseType == 2) {
          print('responseType is HelloResponse');
          final HelloResponse? helloResponseData = bytesToHelloResponse(data);
          print('HelloResponse data: ${helloResponseData?.serverInfo}');
          print('');
        }

        /// DeviceInfoResponse
        else if (responseType == 10) {
          print('responseType is DeviceInfoResponse');
          // print('DeviceInfoResponse data: ${utf8.decode(data.sublist(3))}');
          print('DeviceInfoResponse data: $data');
          print('');
        }

        /// PingRequest
        else if (responseType == 7) {
          print('responseType is PingResponse');
          print('PingResponse data: ${utf8.decode(data.sublist(3))}');
          print('');
        }

        /// PingResponse
        else if (responseType == 8) {
          print('responseType is PingResponse');
          print('PingResponse data: ${utf8.decode(data.sublist(3))}');
          print('');
        }

        /// ListEntitiesSwitchResponse
        else if (responseType == 17) {
          print('responseType is ListEntitiesSwitchResponse');
          String dataPayload = '';

          try {
            dataPayload = data.length > 3 ? utf8.decode(data.sublist(3)) : '';

            print('ListEntitiesSwitchResponse data payload:'
                ' $dataPayload');
          } catch (e) {
            print('ListEntitiesSwitchResponse data bytes:'
                ' $data');
          }
          print('');
        }

        /// ListEntitiesDoneResponse
        else if (responseType == 19) {
          print('responseType is ListEntitiesDoneResponse');
          print(
              'ListEntitiesDoneResponse data: ${utf8.decode(data.sublist(3))}');
          print('');
        }

        /// PingResponse
        else if (responseType == 26) {
          print('responseType is SwitchStateResponse');
          print('SwitchStateResponse data: $data}');
          // print('SwitchStateResponse data: ${utf8.decode(data.sublist(3))}');
          print('');
        } else {
          print('responseType is else');
          print('Listen to data $data');
          print('');
        }
        // print('Hello data2: ${utf8.decode(data)}');
        // serverResponse = String.fromCharCodes(data);
        // print('Server: $serverResponse');
      },

      // handle errors
      onError: (error) {
        logger.e(error);
        socket.destroy();
      },

      // handle server ending connection
      onDone: () {
        print('Server left.');
        socket.destroy();
      },
    );
  }

  Future<void> sendConnect(String devicePassTransfer) async {
    devicePass = devicePassTransfer;
    // connect to the socket server
    final Socket socket = await fSocket;

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
    await (await fSocket).close();
  }

  ///  Turn smart device on
  Future<void> helloRequestToEsp() async {
    // connect to the socket server
    final Socket socket = await fSocket;
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

  ///  Turn smart device on
  Future<void> connectRequestToEsp(
      String addressToServer, String password) async {
    // connect to the socket server
    final socket = await fSocket;

    final ConnectRequest connectRequest = ConnectRequest(password: password);

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

  ///  Turn smart device on
  Future<void> ping() async {
    // connect to the socket server
    final socket = await fSocket;
    print('Connected request to: '
        '${socket.remoteAddress.address}:${socket.remotePort}');

    final PingRequest helloRequest = PingRequest();

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

  ///  Turn smart device on
  Future<void> deviceInfoRequestToEsp() async {
    // connect to the socket server
    final socket = await fSocket;
    print('Connected request to:'
        ' ${socket.remoteAddress.address}:${socket.remotePort}');

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

  ///  Turn smart device on
  Future<void> subscribeStatesRequest() async {
    // connect to the socket server
    final socket = await fSocket;
    print('Connected request to:'
        ' ${socket.remoteAddress.address}:${socket.remotePort}');

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

  ///  Turn smart device on
  Future<void> switchCommandRequest(int deviceKey, bool changeTostate) async {
    if (devicePass == null) {
      print('Please call sendConnect, password is missing');
      return;
    }
    // connect to the socket server
    final socket = await fSocket;
    print('Connected request to:'
        ' ${socket.remoteAddress.address}:${socket.remotePort}');

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

    print(myHexKeyList);

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

    print('switchCommandRequest message: $message');

//  * The message object encoded as a ProtoBuf message
    socket.add(message);
    await Future.delayed(const Duration(milliseconds: 1000));
  }

  ///  Turn smart device on
  Future<void> listEntitiesRequest() async {
    if (devicePass == null) {
      print('Please call sendConnect, password is missing');
      return;
    }
    // connect to the socket server
    final socket = await fSocket;
    print('Connected request to:'
        ' ${socket.remoteAddress.address}:${socket.remotePort}');

    final ListEntitiesRequest switchCommandRequest = ListEntitiesRequest();

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

    print('ListEntitiesRequest message: $message');

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
    for (final int b in responseBytes) {
      // print('This is my $b');
    }
    return helloResponse;
  }
}
