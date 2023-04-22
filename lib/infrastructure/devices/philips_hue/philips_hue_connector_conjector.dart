import 'dart:async';

import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/generic_dimmable_light_device/generic_dimmable_light_entity.dart';
import 'package:cbj_hub/infrastructure/devices/companies_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/philips_hue/philips_hue_e26/philips_hue_e26_entity.dart';
import 'package:cbj_hub/infrastructure/devices/philips_hue/philips_hue_helpers.dart';
import 'package:cbj_hub/infrastructure/generic_devices/abstract_device/abstract_company_connector_conjector.dart';
import 'package:cbj_hub/utils.dart';
import 'package:injectable/injectable.dart';

@singleton
class PhilipsHueConnectorConjector
    implements AbstractCompanyConnectorConjector {
  @override
  Map<String, DeviceEntityAbstract> companyDevices = {};

  static const List<String> mdnsTypes = [
    '_hue._tcp',
  ];

  static bool gotHueHubIp = false;

  /// Add new devices to [companyDevices] if not exist
  Future<void> addNewDeviceByMdnsName({
    required String mDnsName,
    required String ip,
    required String port,
  }) async {
    /// There can only be one Philips Hub in the same network
    if (gotHueHubIp) {
      return;
    }
    CoreUniqueId? tempCoreUniqueId;

    for (final DeviceEntityAbstract device in companyDevices.values) {
      if (device is PhilipsHueE26Entity &&
          (mDnsName == device.entityUniqueId.getOrCrash() ||
              ip == device.deviceLastKnownIp.getOrCrash())) {
        return;
      } else if (mDnsName == device.entityUniqueId.getOrCrash()) {
        logger.w(
          'HP device type supported but implementation is missing here',
        );
        return;
      }
    }
    gotHueHubIp = true;

    final List<DeviceEntityAbstract> phillipsDevice =
        await PhilipsHueHelpers.addDiscoverdDevice(
      mDnsName: mDnsName,
      ip: ip,
      port: port,
      uniqueDeviceId: tempCoreUniqueId,
    );

    if (phillipsDevice.isEmpty) {
      return;
    }

    for (final DeviceEntityAbstract entityAsDevice in phillipsDevice) {
      final DeviceEntityAbstract deviceToAdd =
          CompaniesConnectorConjector.addDiscoverdDeviceToHub(entityAsDevice);

      final MapEntry<String, DeviceEntityAbstract> deviceAsEntry =
          MapEntry(deviceToAdd.entityUniqueId.getOrCrash(), deviceToAdd);

      companyDevices.addEntries([deviceAsEntry]);
    }
    logger.i('New Philips Hue device got added');
  }

  @override
  Future<void> manageHubRequestsForDevice(
    DeviceEntityAbstract philipsHueDE,
  ) async {
    final DeviceEntityAbstract? device =
        companyDevices[philipsHueDE.entityUniqueId.getOrCrash()];

    if (device is PhilipsHueE26Entity) {
      device.executeDeviceAction(newEntity: philipsHueDE);
    } else {
      logger.w('PhilipsHue device type does not exist');
    }
  }

  @override
  Future<void> setUpDeviceFromDb(DeviceEntityAbstract deviceEntity) async {
    DeviceEntityAbstract? nonGenericDevice;

    if (deviceEntity is GenericDimmableLightDE) {
      nonGenericDevice = PhilipsHueE26Entity.fromGeneric(deviceEntity);
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
