import 'dart:async';

import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/generic_rgbw_light_device/generic_rgbw_light_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_switch_device/generic_switch_entity.dart';
import 'package:cbj_hub/infrastructure/devices/companies_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/shelly/shelly_helpers.dart';
import 'package:cbj_hub/infrastructure/devices/shelly/shelly_light/shelly_light_entity.dart';
import 'package:cbj_hub/infrastructure/devices/shelly/shelly_relay_switch/shelly_relay_switch_entity.dart';
import 'package:cbj_hub/infrastructure/generic_devices/abstract_device/abstract_company_connector_conjector.dart';
import 'package:cbj_hub/utils.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@singleton
class ShellyConnectorConjector implements AbstractCompanyConnectorConjector {
  static const List<String> mdnsTypes = ['_http._tcp'];

  static Map<String, DeviceEntityAbstract> companyDevices = {};

  /// Add new devices to [companyDevices] if not exist
  Future<void> addNewDeviceByMdnsName({
    required String mDnsName,
    required String ip,
    required String port,
  }) async {
    CoreUniqueId? tempCoreUniqueId;

    for (final DeviceEntityAbstract device in companyDevices.values) {
      if ((device is ShellyColorLightEntity ||
              device is ShellyRelaySwitchEntity) &&
          mDnsName == device.vendorUniqueId.getOrCrash()) {
        return;
      } else if ((device is GenericRgbwLightDE || device is GenericSwitchDE) &&
          mDnsName == device.vendorUniqueId.getOrCrash()) {
        /// Device exist as generic and needs to get converted to non generic type for this vendor
        tempCoreUniqueId = device.uniqueId;
        break;
      } else if (mDnsName == device.vendorUniqueId.getOrCrash()) {
        logger.w(
          'Shelly device type supported but implementation is missing here',
        );
        return;
      }
    }

    final List<DeviceEntityAbstract> espDevice =
        await ShellyHelpers.addDiscoverdDevice(
      mDnsName: mDnsName,
      ip: ip,
      port: port,
      uniqueDeviceId: tempCoreUniqueId,
    );

    if (espDevice.isEmpty) {
      return;
    }

    for (final DeviceEntityAbstract entityAsDevice in espDevice) {
      final DeviceEntityAbstract deviceToAdd =
          CompaniesConnectorConjector.addDiscoverdDeviceToHub(entityAsDevice);

      final MapEntry<String, DeviceEntityAbstract> deviceAsEntry =
          MapEntry(deviceToAdd.uniqueId.getOrCrash(), deviceToAdd);

      companyDevices.addEntries([deviceAsEntry]);
    }
    logger.v('New shelly devices name:$mDnsName');
  }

  Future<void> manageHubRequestsForDevice(
    DeviceEntityAbstract shellyDE,
  ) async {
    final DeviceEntityAbstract? device = companyDevices[shellyDE.getDeviceId()];

    if (device is ShellyColorLightEntity) {
      device.executeDeviceAction(newEntity: shellyDE);
    } else if (device is ShellyRelaySwitchEntity) {
      device.executeDeviceAction(newEntity: shellyDE);
    } else {
      logger.w('Shelly device type does not exist');
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

  Future<Either<CoreFailure, Unit>> create(DeviceEntityAbstract shelly) {
    // TODO: implement create
    throw UnimplementedError();
  }

  Future<Either<CoreFailure, Unit>> delete(DeviceEntityAbstract shelly) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  Future<void> initiateHubConnection() {
    // TODO: implement initiateHubConnection
    throw UnimplementedError();
  }
}
