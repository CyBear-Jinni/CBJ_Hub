import 'dart:async';

import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/infrastructure/devices/companies_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/yeelight/yeelight_1se/yeelight_1se_entity.dart';
import 'package:cbj_hub/infrastructure/devices/yeelight/yeelight_helpers.dart';
import 'package:cbj_hub/infrastructure/generic_devices/abstract_device/abstract_company_connector_conjector.dart';
import 'package:cbj_hub/utils.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:yeedart/yeedart.dart';

@singleton
class YeelightConnectorConjector implements AbstractCompanyConnectorConjector {
  YeelightConnectorConjector() {
    _discoverNewDevices();
  }

  static Map<String, DeviceEntityAbstract> companyDevices = {};

  Future<void> _discoverNewDevices() async {
    while (true) {
      try {
        final responses = await Yeelight.discover();
        for (final DiscoveryResponse yeelightDevice in responses) {
          bool deviceExist = false;
          for (DeviceEntityAbstract savedDevice in companyDevices.values) {
            savedDevice = savedDevice as Yeelight1SeEntity;

            if (yeelightDevice.id.toString() ==
                savedDevice.vendorUniqueId.getOrCrash()) {
              deviceExist = true;
              break;
            }
          }
          if (!deviceExist) {
            final DeviceEntityAbstract addDevice =
                YeelightHelpers.addDiscoverdDevice(yeelightDevice);

            final DeviceEntityAbstract deviceToAdd =
                CompaniesConnectorConjector.addDiscoverdDeviceToHub(addDevice);

            final MapEntry<String, DeviceEntityAbstract> deviceAsEntry =
                MapEntry(deviceToAdd.uniqueId.getOrCrash(), deviceToAdd);

            companyDevices.addEntries([deviceAsEntry]);

            logger.i('New Yeelight devices where added');
          }
        }
        await Future.delayed(const Duration(minutes: 3));
      } catch (e) {
        logger.e('Error discover in Yeelight\n$e');
        await Future.delayed(const Duration(minutes: 5));
      }
    }
  }

  Future<Either<CoreFailure, Unit>> create(DeviceEntityAbstract yeelight) {
    // TODO: implement create
    throw UnimplementedError();
  }

  Future<Either<CoreFailure, Unit>> delete(DeviceEntityAbstract yeelight) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  Future<void> initiateHubConnection() {
    // TODO: implement initiateHubConnection
    throw UnimplementedError();
  }

  Future<void> manageHubRequestsForDevice(
    DeviceEntityAbstract yeelightDE,
  ) async {
    final DeviceEntityAbstract? device =
        companyDevices[yeelightDE.getDeviceId()];

    if (device is Yeelight1SeEntity) {
      device.executeDeviceAction(newEntity: yeelightDE);
    } else {
      logger.w('Yeelight device type does not exist');
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
