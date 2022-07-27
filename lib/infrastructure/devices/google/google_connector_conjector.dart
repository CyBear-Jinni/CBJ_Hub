import 'dart:async';

import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/infrastructure/devices/companies_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/google/chrome_cast/chrome_cast_entity.dart';
import 'package:cbj_hub/infrastructure/devices/google/google_helpers.dart';
import 'package:cbj_hub/infrastructure/generic_devices/abstract_device/abstract_company_connector_conjector.dart';
import 'package:cbj_hub/utils.dart';
import 'package:dartz/dartz.dart';
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
    for (final DeviceEntityAbstract device in companyDevices.values) {
      if (device is ChromeCastEntity) {
        if (mDnsName == device.deviceMdnsName?.getOrCrash() ||
            ip == device.lastKnownIp!.getOrCrash()) {
          return;
        }
      } else {
        logger.w("Can't add Google device, type was not set to get device ID");
        return;
      }
    }

    final List<DeviceEntityAbstract> googleDevice =
        GoogleHelpers.addDiscoverdDevice(
      mDnsName: mDnsName,
      ip: ip,
      port: port,
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
    logger.i('New Chromecast devices where added');
  }

  Future<Either<CoreFailure, Unit>> create(DeviceEntityAbstract google) {
    // TODO: implement create
    throw UnimplementedError();
  }

  Future<Either<CoreFailure, Unit>> delete(DeviceEntityAbstract google) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  Future<void> initiateHubConnection() {
    // TODO: implement initiateHubConnection
    throw UnimplementedError();
  }

  Future<void> manageHubRequestsForDevice(DeviceEntityAbstract googleDE) async {
    final DeviceEntityAbstract? device = companyDevices[googleDE.getDeviceId()];

    if (device is ChromeCastEntity) {
      device.executeDeviceAction(newEntity: googleDE);
    } else {
      logger.i('Google device type does not exist');
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
