import 'dart:async';

import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/infrastructure/devices/companies_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/google/chrome_cast/chrome_cast_entity.dart';
import 'package:cbj_hub/infrastructure/devices/google/google_helpers.dart';
import 'package:cbj_hub/infrastructure/generic_devices/abstract_device/abstract_company_connector_conjector.dart';
import 'package:cbj_hub/utils.dart';
import 'package:injectable/injectable.dart';

@singleton
class GoogleConnectorConjector implements AbstractCompanyConnectorConjector {
  static Map<String, DeviceEntityAbstract> companyDevices = {};

  static const List<String> mdnsTypes = [
    '_googlecast._tcp',
    '_androidtvremote2._tcp',
    '_rc._tcp',
  ];

  /// Add new devices to [companyDevices] if not exist
  Future<void> addNewDeviceByMdnsName({
    required String mDnsName,
    required String ip,
    required String port,
  }) async {
    CoreUniqueId? tempCoreUniqueId;

    for (final DeviceEntityAbstract device in companyDevices.values) {
      if (device is ChromeCastEntity &&
          (mDnsName == device.entityUniqueId.getOrCrash() ||
              ip == device.lastKnownIp!.getOrCrash())) {
        return;
      } // Same tv can have multiple mDns names so we can't compere it without ip in the object
      // else if (device is GenericSmartTvDE &&
      //     (mDnsName == device.entityUniqueId.getOrCrash() ||
      //         ip == device.lastKnownIp!.getOrCrash())) {
      //   return;
      // }
      else if (mDnsName == device.entityUniqueId.getOrCrash()) {
        logger.w(
          'Google device type supported but implementation is missing here',
        );
        return;
      }
    }

    final List<DeviceEntityAbstract> googleDevice =
        GoogleHelpers.addDiscoverdDevice(
      mDnsName: mDnsName,
      ip: ip,
      port: port,
      uniqueDeviceId: tempCoreUniqueId,
    );

    if (googleDevice.isEmpty) {
      return;
    }

    for (final DeviceEntityAbstract entityAsDevice in googleDevice) {
      final DeviceEntityAbstract deviceToAdd =
          CompaniesConnectorConjector.addDiscoverdDeviceToHub(entityAsDevice);

      final MapEntry<String, DeviceEntityAbstract> deviceAsEntry =
          MapEntry(deviceToAdd.uniqueId.getOrCrash(), deviceToAdd);

      companyDevices.addEntries([deviceAsEntry]);
    }
    logger.i('New Chromecast device got added');
  }

  Future<void> manageHubRequestsForDevice(DeviceEntityAbstract googleDE) async {
    final DeviceEntityAbstract? device = companyDevices[googleDE.getDeviceId()];

    if (device is ChromeCastEntity) {
      device.executeDeviceAction(newEntity: googleDE);
    } else {
      logger.w(
        'Google device type does not exist ${device?.entityTypes.getOrCrash()}',
      );
    }
  }

  @override
  Future<void> setUpDeviceFromDb(DeviceEntityAbstract deviceEntity) async {}
}
