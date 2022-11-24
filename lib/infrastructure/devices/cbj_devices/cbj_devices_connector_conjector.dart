import 'dart:async';

import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/infrastructure/devices/cbj_devices/cbj_devices_helpers.dart';
import 'package:cbj_hub/infrastructure/devices/cbj_devices/cbj_smart_device/cbj_smart_device_entity.dart';
import 'package:cbj_hub/infrastructure/devices/cbj_devices/cbj_smart_device_client/cbj_smart_device_client.dart';
import 'package:cbj_hub/infrastructure/devices/companies_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_smart_device_server/protoc_as_dart/cbj_smart_device_server.pbgrpc.dart';
import 'package:cbj_hub/infrastructure/generic_devices/abstract_device/abstract_company_connector_conjector.dart';
import 'package:cbj_hub/utils.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:network_tools/network_tools.dart';

@singleton
class CbjDevicesConnectorConjector
    implements AbstractCompanyConnectorConjector {
  static Map<String, DeviceEntityAbstract> companyDevices = {};

  Future<void> addNewDeviceByHostInfo({
    required ActiveHost activeHost,
  }) async {
    final List<CoreUniqueId?> tempCoreUniqueId = [];

    for (final DeviceEntityAbstract savedDevice in companyDevices.values) {
      if ((savedDevice is CbjSmartComputerEntity) &&
          await activeHost.hostName ==
              savedDevice.vendorUniqueId.getOrCrash()) {
        return;
      } else if (await activeHost.hostName ==
          savedDevice.vendorUniqueId.getOrCrash()) {
        logger.w(
          'Cbj device type supported but implementation is missing here',
        );
      }
    }

    final List<CbjSmartDeviceInfo?> componentsInDevice =
        await getAllComponentsOfDevice(activeHost);
    final List<DeviceEntityAbstract> devicesList =
        CbjDevicesHelpers.addDiscoverdDevice(
      componentsInDevice: componentsInDevice,
      deviceAddress: activeHost.address,
    );
    if (devicesList.isEmpty) {
      return;
    }

    for (final DeviceEntityAbstract entityAsDevice in devicesList) {
      final DeviceEntityAbstract deviceToAdd =
          CompaniesConnectorConjector.addDiscoverdDeviceToHub(entityAsDevice);

      final MapEntry<String, DeviceEntityAbstract> deviceAsEntry =
          MapEntry(deviceToAdd.uniqueId.getOrCrash(), deviceToAdd);

      companyDevices.addEntries([deviceAsEntry]);

      logger.v(
        'New Cbj Smart Device name:${entityAsDevice.defaultName.getOrCrash()}',
      );
    }
  }

  //
  // Future<Either<CoreFailure, Unit>> create(DeviceEntityAbstract cbjDevices) {
  //   // TODO: implement create
  //   throw UnimplementedError();
  // }
  //
  // Future<Either<CoreFailure, Unit>> delete(DeviceEntityAbstract cbjDevices) {
  //   // TODO: implement delete
  //   throw UnimplementedError();
  // }
  //
  // Future<void> initiateHubConnection() {
  //   // TODO: implement initiateHubConnection
  //   throw UnimplementedError();
  // }
  //
  Future<void> manageHubRequestsForDevice(
    DeviceEntityAbstract cbjDevicesDE,
  ) async {
    final DeviceEntityAbstract? device =
        companyDevices[cbjDevicesDE.getDeviceId()];

    // if (device == null) {
    //   setTheSameDeviceFromAllDevices(cbjDevicesDE);
    //   device =
    //   companyDevices[cbjDevicesDE.getDeviceId()];
    // }

    if (device != null && (device is CbjSmartComputerEntity)) {
      device.executeDeviceAction(newEntity: cbjDevicesDE);
    } else {
      logger.w('CbjDevices device type ${device.runtimeType} does not exist');
    }
  }
  //
  // // Future<void> setTheSameDeviceFromAllDevices(
  // //   DeviceEntityAbstract cbjDevicesDE,
  // // ) async {
  // //   final String deviceVendorUniqueId = cbjDevicesDE.vendorUniqueId.getOrCrash();
  // //   for(a)
  // // }

  Future<Either<CoreFailure, Unit>> updateDatabase({
    required String pathOfField,
    required Map<String, dynamic> fieldsToUpdate,
    String? forceUpdateLocation,
  }) async {
    // TODO: implement updateDatabase
    throw UnimplementedError();
  }

  Future<List<CbjSmartDeviceInfo?>> getAllComponentsOfDevice(
    ActiveHost activeHost,
  ) async {
    final String deviceIp = activeHost.address;
    final List<CbjSmartDeviceInfo?> devicesInfo =
        await CbjSmartDeviceClient.getCbjSmartDeviceHostDevicesInfo(activeHost);
    return devicesInfo;
  }
}
