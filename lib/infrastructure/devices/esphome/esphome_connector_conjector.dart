import 'dart:async';

import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/generic_light_device/generic_light_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_switch_device/generic_switch_entity.dart';
import 'package:cbj_hub/domain/saved_devices/i_saved_devices_repo.dart';
import 'package:cbj_hub/domain/vendors/esphome_login/generic_esphome_login_entity.dart';
import 'package:cbj_hub/infrastructure/devices/companies_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/esphome/esphome_helpers.dart';
import 'package:cbj_hub/infrastructure/devices/esphome/esphome_light/esphome_light_entity.dart';
import 'package:cbj_hub/infrastructure/devices/esphome/esphome_switch/esphome_switch_entity.dart';
import 'package:cbj_hub/infrastructure/generic_devices/abstract_device/abstract_company_connector_conjector.dart';
import 'package:cbj_hub/injection.dart';
import 'package:cbj_hub/utils.dart';
import 'package:injectable/injectable.dart';

@singleton
class EspHomeConnectorConjector implements AbstractCompanyConnectorConjector {
  static const List<String> mdnsTypes = ['_esphomelib._tcp'];

  @override
  Map<String, DeviceEntityAbstract> companyDevices = {};

  static String? espHomeDevicePass;

  Map<String, DeviceEntityAbstract> get getAllCompanyDevices => companyDevices;

  Future<String> accountLogin(
    GenericEspHomeLoginDE genericEspHomeDeviceLoginDE,
  ) async {
    espHomeDevicePass =
        genericEspHomeDeviceLoginDE.espHomeDevicePass.getOrCrash();
    // We can start a search of devices in node red using a request to
    // /esphome/discovery but for now lets just let the devices get found by
    // the global mdns search
    return 'Success';
  }

  /// Add new devices to [companyDevices] if not exist
  Future<void> addNewDeviceByMdnsName({
    required String mDnsName,
    required String ip,
    required String port,
    required String address,
  }) async {
    if (espHomeDevicePass == null) {
      logger.w('ESPHome device got found but missing a password, please add '
          'password for it in the app');
      return;
    }

    final List<DeviceEntityAbstract> espDevice =
        await EspHomeHelpers.addDiscoverdEntities(
      mDnsName: mDnsName,
      port: port,
      address: address,
      devicePassword: espHomeDevicePass!,
    );

    for (final DeviceEntityAbstract entityAsDevice in espDevice) {
      final DeviceEntityAbstract deviceToAdd =
          CompaniesConnectorConjector.addDiscoverdDeviceToHub(entityAsDevice);

      final MapEntry<String, DeviceEntityAbstract> deviceAsEntry =
          MapEntry(deviceToAdd.entityUniqueId.getOrCrash(), deviceToAdd);

      companyDevices.addEntries([deviceAsEntry]);

      logger.i(
        'New ESPHome devices name:${entityAsDevice.cbjEntityName.getOrCrash()}',
      );
    }
    // Save state locally so that nodeRED flows will not get created again
    // after restart
    getIt<ISavedDevicesRepo>().saveAndActivateSmartDevicesToDb();
  }

  @override
  Future<void> manageHubRequestsForDevice(
    DeviceEntityAbstract espHomeDE,
  ) async {
    final DeviceEntityAbstract? device =
        companyDevices[espHomeDE.entityUniqueId.getOrCrash()];

    if (device != null) {
      device.executeDeviceAction(newEntity: espHomeDE);
    } else {
      logger.w('ESPHome device type does not exist');
    }
  }

  @override
  Future<void> setUpDeviceFromDb(DeviceEntityAbstract deviceEntity) async {
    DeviceEntityAbstract? nonGenericDevice;

    if (deviceEntity is GenericLightDE) {
      nonGenericDevice = EspHomeLightEntity.fromGeneric(deviceEntity);
    } else if (deviceEntity is GenericSwitchDE) {
      nonGenericDevice = EspHomeSwitchEntity.fromGeneric(deviceEntity);
    }

    if (nonGenericDevice == null) {
      logger.w('EspHome device could not get loaded from the server');
      return;
    }

    companyDevices.addEntries([
      MapEntry(nonGenericDevice.entityUniqueId.getOrCrash(), nonGenericDevice),
    ]);
  }
}
