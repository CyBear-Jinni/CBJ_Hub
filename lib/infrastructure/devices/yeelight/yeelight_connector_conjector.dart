import 'dart:async';

import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/generic_rgbw_light_device/generic_rgbw_light_entity.dart';
import 'package:cbj_hub/infrastructure/devices/companies_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/yeelight/yeelight_1se/yeelight_1se_entity.dart';
import 'package:cbj_hub/infrastructure/devices/yeelight/yeelight_helpers.dart';
import 'package:cbj_hub/infrastructure/generic_devices/abstract_device/abstract_company_connector_conjector.dart';
import 'package:cbj_hub/utils.dart';
import 'package:injectable/injectable.dart';
import 'package:network_tools/network_tools.dart';
import 'package:yeedart/yeedart.dart';

@singleton
class YeelightConnectorConjector implements AbstractCompanyConnectorConjector {
  @override
  Map<String, DeviceEntityAbstract> companyDevices = {};

  static const List<String> mdnsTypes = [
    '_hap._tcp',
  ];

  /// Make sure that it will activate discoverNewDevices only once
  bool searchStarted = false;

  Future<void> addNewDeviceByMdnsName({
    required String mDnsName,
    required String ip,
    required String port,
  }) async {
    addNewDevice(ip: ip, mDnsName: mDnsName);
  }

  Future<void> addNewDeviceByHostInfo({
    required ActiveHost activeHost,
  }) async {
    addNewDevice(ip: activeHost.address);
  }

  Future<void> addNewDevice({
    required String ip,
    String? mDnsName,
  }) async {
    try {
      final responses = await Yeelight.discover();
      if (responses.isEmpty) {
        return;
      }

      for (final DiscoveryResponse yeelightDevice in responses) {
        if (companyDevices.containsKey(yeelightDevice.id.toString())) {
          return;
        }

        DeviceEntityAbstract? addDevice;
        if (yeelightDevice.address.address == ip) {
          addDevice = YeelightHelpers.addDiscoverdDevice(
            yeelightDevice: yeelightDevice,
            mDnsName: mDnsName,
          );
        } else {
          addDevice = YeelightHelpers.addDiscoverdDevice(
            yeelightDevice: yeelightDevice,
          );
        }

        if (addDevice == null) {
          continue;
        }

        final DeviceEntityAbstract deviceToAdd =
            CompaniesConnectorConjector.addDiscoverdDeviceToHub(addDevice);

        final MapEntry<String, DeviceEntityAbstract> deviceAsEntry =
            MapEntry(deviceToAdd.entityUniqueId.getOrCrash(), deviceToAdd);

        companyDevices.addEntries([deviceAsEntry]);

        logger.i('New Yeelight device got added');
      }
    } catch (e) {
      logger.e('Error discover in Yeelight\n$e');
    }
  }

  @override
  Future<void> manageHubRequestsForDevice(
    DeviceEntityAbstract entity,
  ) async {
    final DeviceEntityAbstract? device =
        companyDevices[entity.entityUniqueId.getOrCrash()];

    if (device is Yeelight1SeEntity) {
      device.executeDeviceAction(newEntity: entity);
    } else {
      logger.w('Yeelight device type does not exist');
    }
  }

  @override
  Future<void> setUpDeviceFromDb(DeviceEntityAbstract deviceEntity) async {
    DeviceEntityAbstract? nonGenericDevice;

    if (deviceEntity is GenericRgbwLightDE) {
      nonGenericDevice = Yeelight1SeEntity.fromGeneric(deviceEntity);
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
