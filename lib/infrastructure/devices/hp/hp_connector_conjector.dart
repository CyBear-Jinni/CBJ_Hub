import 'dart:async';

import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/infrastructure/devices/companies_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/hp/hp_helpers.dart';
import 'package:cbj_hub/infrastructure/devices/hp/hp_printer/hp_printer_entity.dart';
import 'package:cbj_hub/infrastructure/generic_devices/abstract_device/abstract_company_connector_conjector.dart';
import 'package:cbj_hub/utils.dart';
import 'package:injectable/injectable.dart';

@singleton
class HpConnectorConjector implements AbstractCompanyConnectorConjector {
  static const List<String> mdnsTypes = ['_hplib._tcp'];

  static Map<String, DeviceEntityAbstract> companyDevices = {};

  /// Add new devices to [companyDevices] if not exist
  Future<void> addNewDeviceByMdnsName({
    required String mDnsName,
    required String ip,
    required String port,
  }) async {
    CoreUniqueId? tempCoreUniqueId;

    for (final DeviceEntityAbstract device in companyDevices.values) {
      if (device is HpPrinterEntity &&
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

    final List<DeviceEntityAbstract> hpDevice = HpHelpers.addDiscoverdDevice(
      mDnsName: mDnsName,
      ip: ip,
      port: port,
      uniqueDeviceId: tempCoreUniqueId,
    );

    if (hpDevice.isEmpty) {
      return;
    }

    for (final DeviceEntityAbstract entityAsDevice in hpDevice) {
      final DeviceEntityAbstract deviceToAdd =
          CompaniesConnectorConjector.addDiscoverdDeviceToHub(entityAsDevice);

      final MapEntry<String, DeviceEntityAbstract> deviceAsEntry =
          MapEntry(deviceToAdd.uniqueId.getOrCrash(), deviceToAdd);

      companyDevices.addEntries([deviceAsEntry]);
    }
    logger.i('New HP device got added');
  }

  Future<void> manageHubRequestsForDevice(
    DeviceEntityAbstract hpDE,
  ) async {
    final DeviceEntityAbstract? device = companyDevices[hpDE.getDeviceId()];

    if (device is HpPrinterEntity) {
      device.executeDeviceAction(newEntity: hpDE);
    } else {
      logger.w('HP device type does not exist');
    }
  }

  @override
  Future<void> setUpDeviceFromDb(DeviceEntityAbstract deviceEntity) async {}
}
