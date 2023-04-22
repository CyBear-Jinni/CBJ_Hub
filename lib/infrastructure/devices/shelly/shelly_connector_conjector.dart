import 'dart:async';

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
import 'package:injectable/injectable.dart';

@singleton
class ShellyConnectorConjector implements AbstractCompanyConnectorConjector {
  static const List<String> mdnsTypes = ['_http._tcp'];

  @override
  Map<String, DeviceEntityAbstract> companyDevices = {};

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
          mDnsName == device.entityUniqueId.getOrCrash()) {
        return;
      } else if ((device is GenericRgbwLightDE || device is GenericSwitchDE) &&
          mDnsName == device.entityUniqueId.getOrCrash()) {
        /// Device exist as generic and needs to get converted to non generic type for this vendor
        tempCoreUniqueId = device.uniqueId;
        break;
      } else if (mDnsName == device.entityUniqueId.getOrCrash()) {
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
          MapEntry(deviceToAdd.entityUniqueId.getOrCrash(), deviceToAdd);

      companyDevices.addEntries([deviceAsEntry]);
    }
    logger.v('New shelly devices name:$mDnsName');
  }

  @override
  Future<void> manageHubRequestsForDevice(
    DeviceEntityAbstract shellyDE,
  ) async {
    final DeviceEntityAbstract? device =
        companyDevices[shellyDE.entityUniqueId.getOrCrash()];

    if (device is ShellyColorLightEntity) {
      device.executeDeviceAction(newEntity: shellyDE);
    } else if (device is ShellyRelaySwitchEntity) {
      device.executeDeviceAction(newEntity: shellyDE);
    } else {
      logger.w('Shelly device type does not exist');
    }
  }

  @override
  Future<void> setUpDeviceFromDb(DeviceEntityAbstract deviceEntity) async {
    DeviceEntityAbstract? nonGenericDevice;

    if (deviceEntity is GenericRgbwLightDE) {
      nonGenericDevice = ShellyColorLightEntity.fromGeneric(deviceEntity);
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
