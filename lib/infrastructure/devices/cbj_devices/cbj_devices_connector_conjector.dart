import 'dart:async';

import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/generic_smart_computer_device/generic_smart_computer_entity.dart';
import 'package:cbj_hub/infrastructure/devices/cbj_devices/cbj_devices_helpers.dart';
import 'package:cbj_hub/infrastructure/devices/cbj_devices/cbj_smart_device/cbj_smart_device_entity.dart';
import 'package:cbj_hub/infrastructure/devices/cbj_devices/cbj_smart_device_client/cbj_smart_device_client.dart';
import 'package:cbj_hub/infrastructure/devices/companies_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_smart_device_server/protoc_as_dart/cbj_smart_device_server.pbgrpc.dart';
import 'package:cbj_hub/infrastructure/generic_devices/abstract_device/abstract_company_connector_conjector.dart';
import 'package:cbj_hub/utils.dart';
import 'package:injectable/injectable.dart';
import 'package:network_tools/network_tools.dart';

@singleton
class CbjDevicesConnectorConjector
    implements AbstractCompanyConnectorConjector {
  @override
  Map<String, DeviceEntityAbstract> companyDevices = {};

  Future<void> addNewDeviceByHostInfo({
    required ActiveHost activeHost,
  }) async {
    for (final DeviceEntityAbstract savedDevice in companyDevices.values) {
      if ((savedDevice is CbjSmartComputerEntity) &&
          await activeHost.hostName ==
              savedDevice.entityUniqueId.getOrCrash()) {
        return;
      } else if (await activeHost.hostName ==
          savedDevice.entityUniqueId.getOrCrash()) {
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
        'New Cbj Smart Device name:${entityAsDevice.cbjEntityName.getOrCrash()}',
      );
    }
  }

  @override
  Future<void> manageHubRequestsForDevice(
    DeviceEntityAbstract cbjDevicesDE,
  ) async {
    final DeviceEntityAbstract? device =
        companyDevices[cbjDevicesDE.entityUniqueId.getOrCrash()];

    // if (device == null) {
    //   setTheSameDeviceFromAllDevices(cbjDevicesDE);
    //   device =
    //   companyDevices[cbjDevicesDE.entityUniqueId.getOrCrash();
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
  // //   final String deviceEntityUniqueId = cbjDevicesDE.entityUniqueId.getOrCrash();
  // //   for(a)
  // // }

  Future<List<CbjSmartDeviceInfo?>> getAllComponentsOfDevice(
    ActiveHost activeHost,
  ) async {
    activeHost.address;
    final List<CbjSmartDeviceInfo?> devicesInfo =
        await CbjSmartDeviceClient.getCbjSmartDeviceHostDevicesInfo(activeHost);
    return devicesInfo;
  }

  @override
  Future<void> setUpDeviceFromDb(DeviceEntityAbstract deviceEntity) async {
    DeviceEntityAbstract? nonGenericDevice;

    if (deviceEntity is GenericSmartComputerDE) {
      nonGenericDevice = CbjSmartComputerEntity.fromGeneric(deviceEntity);
    }

    if (nonGenericDevice == null) {
      logger.w('Switcher device could not get loaded from the server');
      return;
    }

    companyDevices.addEntries([
      MapEntry(nonGenericDevice.entityUniqueId.getOrCrash(), nonGenericDevice),
    ]);
  }
}
