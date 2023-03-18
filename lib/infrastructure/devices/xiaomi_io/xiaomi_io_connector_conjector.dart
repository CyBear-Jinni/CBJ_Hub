import 'dart:async';

// import 'dart:io';

import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/infrastructure/devices/xiaomi_io/xiaomi_io_gpx3021gl/xiaomi_io_gpx3021gl_entity.dart';
import 'package:cbj_hub/infrastructure/generic_devices/abstract_device/abstract_company_connector_conjector.dart';
import 'package:cbj_hub/utils.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
// import 'package:mi_iot_token/mi_iot_token.dart';
// import 'package:miio/miio.dart';
import 'package:network_tools/network_tools.dart';

@singleton
class XiaomiIoConnectorConjector implements AbstractCompanyConnectorConjector {
  static Map<String, DeviceEntityAbstract> companyDevices = {};

  // Discover from miio package does not work on Linux, but it is better than
  // filtering devices by host names like we do now
  Future<void> discoverNewDevices({
    required ActiveHost activeHost,
  }) async {
    // try {
    //   if ((activeHost.address).endsWith('.1')) {
    //     // Currently we exclude discovered routers
    //     return;
    //   }
    //   // final InternetAddress internetAddress = InternetAddress('192.168.31.255');
    //   final InternetAddress internetAddress =
    //       InternetAddress(activeHost.address);
    //
    //   final Auth auth = Auth();
    //   final Api api = Api('cn'); // your country code
    //   final dynamic user = await auth.login(
    //     ,
    //     ,
    //   ); // your id or name and password
    //
    //   final dynamic data = await api.getDeviceList(
    //     user['userId'],
    //     user['ssecurity'],
    //     user['token'],
    //     'cn',
    //   ); // your two-letter codes
    //
    //   print(data);
    //
    //   final MiIOPacket miIoPacket = await MiIO.instance.hello(internetAddress);
    //   MiIO.instance.send(
    //     activeHost.internetAddress,
    //     miIoPacket,
    //     token: user["token"] as List<int>?,
    //   );
    //
    //   // await for (final tup.Tuple2<InternetAddress, MiIOPacket> miDevice
    //   //     in MiIO.instance.discover(internetAddress)) {
    //   //   logger.v('miDevice devices $miDevice');
    //   //   // MiIO.inst ance.send(address, packet);
    //   // }
    //
    //   // final InternetAddress internetAddress = InternetAddress('192.168.31.247');
    //   //
    //   // MiIOPacket miIoPacket = await MiIO.instance.hello(internetAddress);
    //   // MiIOPacket ab = await MiIO.instance.send(internetAddress, miIoPacket);
    //   // logger.v('This is mi packets $miIoPacket');
    // } on MiIOError catch (e) {
    //   logger.e(
    //     'Command failed with error from xiaomi device:\n'
    //     'code: ${e.code}\n'
    //     'message: ${e.message}',
    //   );
    // } on Exception catch (e) {
    //   logger.e('Xiaomi command failed with exception:\n$e');
    // } catch (e) {
    //   logger.v('All else');
    // }
  }

  Future<Either<CoreFailure, Unit>> create(DeviceEntityAbstract xiaomiIo) {
    // TODO: implement create
    throw UnimplementedError();
  }

  Future<Either<CoreFailure, Unit>> delete(DeviceEntityAbstract xiaomiIo) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  Future<void> initiateHubConnection() {
    // TODO: implement initiateHubConnection
    throw UnimplementedError();
  }

  Future<void> manageHubRequestsForDevice(
    DeviceEntityAbstract xiaomiDE,
  ) async {
    final DeviceEntityAbstract? device = companyDevices[xiaomiDE.getDeviceId()];

    if (device is XiaomiIoGpx4021GlEntity) {
      device.executeDeviceAction(newEntity: xiaomiDE);
    } else {
      logger.w('XiaomiIo device type does not exist');
    }
  }

  Future<Either<CoreFailure, Unit>> updateDatabase({
    required String pathOfField,
    required Map<String, dynamic> fieldsToUpdate,
    String? forceUpdateLocation,
  }) async {
    // TODO: implement updateDatabase
    throw UnimplementedError();
  }
}
