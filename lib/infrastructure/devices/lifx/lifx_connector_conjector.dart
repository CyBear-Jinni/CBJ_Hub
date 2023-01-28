import 'dart:async';

import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/generic_light_device/generic_light_entity.dart';
import 'package:cbj_hub/domain/vendors/lifx_login/generic_lifx_login_entity.dart';
import 'package:cbj_hub/infrastructure/devices/companies_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/lifx/lifx_helpers.dart';
import 'package:cbj_hub/infrastructure/devices/lifx/lifx_white/lifx_white_entity.dart';
import 'package:cbj_hub/infrastructure/generic_devices/abstract_device/abstract_company_connector_conjector.dart';
import 'package:cbj_hub/utils.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:lifx_http_api/lifx_http_api.dart';

@singleton
class LifxConnectorConjector implements AbstractCompanyConnectorConjector {
  Future<String> accountLogin(GenericLifxLoginDE genericLifxLoginDE) async {
    lifxClient = LIFXClient(genericLifxLoginDE.lifxApiKey.getOrCrash());
    _discoverNewDevices();
    return 'Success';
  }

  static Map<String, DeviceEntityAbstract> companyDevices = {};

  static LIFXClient? lifxClient;

  Future<void> _discoverNewDevices() async {
    while (true) {
      try {
        final Iterable<LIFXBulb> lights =
            await lifxClient!.listLights(const Selector());

        for (final LIFXBulb lifxDevice in lights) {
          CoreUniqueId? tempCoreUniqueId;
          bool deviceExist = false;
          for (final DeviceEntityAbstract savedDevice
              in companyDevices.values) {
            if (savedDevice is LifxWhiteEntity &&
                lifxDevice.id == savedDevice.vendorUniqueId.getOrCrash()) {
              deviceExist = true;
              break;
            } else if (savedDevice is GenericLightDE &&
                lifxDevice.id == savedDevice.vendorUniqueId.getOrCrash()) {
              tempCoreUniqueId = savedDevice.uniqueId;
              break;
            } else if (lifxDevice.id ==
                savedDevice.vendorUniqueId.getOrCrash()) {
              logger.w(
                'Lifx device type supported but implementation is missing here',
              );
              break;
            }
          }
          if (!deviceExist) {
            final DeviceEntityAbstract? addDevice =
                LifxHelpers.addDiscoverdDevice(
              lifxDevice: lifxDevice,
              uniqueDeviceId: tempCoreUniqueId,
            );

            if (addDevice == null) {
              continue;
            }

            final DeviceEntityAbstract deviceToAdd =
                CompaniesConnectorConjector.addDiscoverdDeviceToHub(addDevice);

            final MapEntry<String, DeviceEntityAbstract> deviceAsEntry =
                MapEntry(deviceToAdd.uniqueId.getOrCrash(), deviceToAdd);

            companyDevices.addEntries([deviceAsEntry]);

            logger.i('New Lifx device got added');
          }
        }
        await Future.delayed(const Duration(minutes: 3));
      } catch (e) {
        logger.e('Error discover in Lifx\n$e');
        await Future.delayed(const Duration(minutes: 1));
      }
    }
  }

  Future<Either<CoreFailure, Unit>> create(DeviceEntityAbstract lifx) {
    // TODO: implement create
    throw UnimplementedError();
  }

  Future<Either<CoreFailure, Unit>> delete(DeviceEntityAbstract lifx) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  Future<void> initiateHubConnection() {
    // TODO: implement initiateHubConnection
    throw UnimplementedError();
  }

  Future<void> manageHubRequestsForDevice(
    DeviceEntityAbstract lifxDE,
  ) async {
    final DeviceEntityAbstract? device = companyDevices[lifxDE.getDeviceId()];

    if (device is LifxWhiteEntity) {
      device.executeDeviceAction(newEntity: lifxDE);
    } else {
      logger.w('Lifx device type does not exist');
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
