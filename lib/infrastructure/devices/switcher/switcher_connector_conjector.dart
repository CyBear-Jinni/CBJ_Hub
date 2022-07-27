import 'dart:async';

import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/infrastructure/devices/companies_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/switcher/switcher_api/switcher_api_object.dart';
import 'package:cbj_hub/infrastructure/devices/switcher/switcher_api/switcher_discover.dart';
import 'package:cbj_hub/infrastructure/devices/switcher/switcher_helpers.dart';
import 'package:cbj_hub/infrastructure/devices/switcher/switcher_runner/switcher_runner_entity.dart';
import 'package:cbj_hub/infrastructure/devices/switcher/switcher_v2/switcher_v2_entity.dart';
import 'package:cbj_hub/infrastructure/generic_devices/abstract_device/abstract_company_connector_conjector.dart';
import 'package:cbj_hub/utils.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@singleton
class SwitcherConnectorConjector implements AbstractCompanyConnectorConjector {
  SwitcherConnectorConjector() {
    _discoverNewDevices();
  }

  static Map<String, DeviceEntityAbstract> companyDevices = {};

  Future<void> _discoverNewDevices() async {
    SwitcherDiscover.discover20002Devices().listen((switcherApiObject) {
      addOnlyNewSwitcherDevice(switcherApiObject);
    });
    SwitcherDiscover.discover20003Devices().listen((switcherApiObject) {
      addOnlyNewSwitcherDevice(switcherApiObject);
    });
  }

  Future<void> addOnlyNewSwitcherDevice(
    SwitcherApiObject switcherApiObject,
  ) async {
    for (final DeviceEntityAbstract savedDevice in companyDevices.values) {
      if (savedDevice is SwitcherV2Entity) {
        if (switcherApiObject.deviceId ==
            savedDevice.vendorUniqueId.getOrCrash()) {
          return;
        }
      } else if (savedDevice is SwitcherRunnerEntity) {
        if (switcherApiObject.deviceId ==
            savedDevice.vendorUniqueId.getOrCrash()) {
          return;
        }
      } else {
        logger
            .w("Can't add switcher device, type was not set to get device ID");
      }
    }

    final DeviceEntityAbstract? addDevice =
        SwitcherHelpers.addDiscoverdDevice(switcherApiObject);
    if (addDevice == null) {
      return;
    }

    final DeviceEntityAbstract deviceToAdd =
        CompaniesConnectorConjector.addDiscoverdDeviceToHub(addDevice);

    final MapEntry<String, DeviceEntityAbstract> deviceAsEntry =
        MapEntry(deviceToAdd.uniqueId.getOrCrash(), deviceToAdd);

    companyDevices.addEntries([deviceAsEntry]);

    logger.v('New switcher devices name:${switcherApiObject.switcherName}');
  }

  Future<Either<CoreFailure, Unit>> create(DeviceEntityAbstract switcher) {
    // TODO: implement create
    throw UnimplementedError();
  }

  Future<Either<CoreFailure, Unit>> delete(DeviceEntityAbstract switcher) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  Future<void> initiateHubConnection() {
    // TODO: implement initiateHubConnection
    throw UnimplementedError();
  }

  Future<void> manageHubRequestsForDevice(
    DeviceEntityAbstract switcherDE,
  ) async {
    final DeviceEntityAbstract? device =
        companyDevices[switcherDE.getDeviceId()];

    // if (device == null) {
    //   setTheSameDeviceFromAllDevices(switcherDE);
    //   device =
    //   companyDevices[switcherDE.getDeviceId()];
    // }

    if (device != null &&
        (device is SwitcherV2Entity || device is SwitcherRunnerEntity)) {
      device.executeDeviceAction(newEntity: switcherDE);
    } else {
      logger.w('Switcher device type ${device.runtimeType} does not exist');
    }
  }

  // Future<void> setTheSameDeviceFromAllDevices(
  //   DeviceEntityAbstract switcherDE,
  // ) async {
  //   final String deviceVendorUniqueId = switcherDE.vendorUniqueId.getOrCrash();
  //   for(a)
  // }

  Future<Either<CoreFailure, Unit>> updateDatabase({
    required String pathOfField,
    required Map<String, dynamic> fieldsToUpdate,
    String? forceUpdateLocation,
  }) async {
    // TODO: implement updateDatabase
    throw UnimplementedError();
  }
}
