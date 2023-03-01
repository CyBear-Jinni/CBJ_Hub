import 'dart:async';

import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/infrastructure/devices/companies_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/philips_hue/philips_hue_e26/philips_hue_e26_entity.dart';
import 'package:cbj_hub/infrastructure/devices/philips_hue/philips_hue_helpers.dart';
import 'package:cbj_hub/infrastructure/generic_devices/abstract_device/abstract_company_connector_conjector.dart';
import 'package:cbj_hub/utils.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@singleton
class PhilipsHueConnectorConjector
    implements AbstractCompanyConnectorConjector {
  static Map<String, DeviceEntityAbstract> companyDevices = {};

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
          (mDnsName == device.vendorUniqueId.getOrCrash() ||
              ip == device.lastKnownIp!.getOrCrash())) {
        return;
      } else if (mDnsName == device.vendorUniqueId.getOrCrash()) {
        logger.w(
          'HP device type supported but implementation is missing here',
        );
        return;
      }
    }
    gotHueHubIp = true;

    final List<DeviceEntityAbstract> hpDevice =
        await PhilipsHueHelpers.addDiscoverdDevice(
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
    logger.i('New Philips Hue device got added');
  }

  Future<Either<CoreFailure, Unit>> create(DeviceEntityAbstract philipsHue) {
    // TODO: implement create
    throw UnimplementedError();
  }

  Future<Either<CoreFailure, Unit>> delete(DeviceEntityAbstract philipsHue) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  Future<void> initiateHubConnection() {
    // TODO: implement initiateHubConnection
    throw UnimplementedError();
  }

  Future<void> manageHubRequestsForDevice(
    DeviceEntityAbstract philipsHueDE,
  ) async {
    final DeviceEntityAbstract? device =
        companyDevices[philipsHueDE.getDeviceId()];

    if (device is PhilipsHueE26Entity) {
      device.executeDeviceAction(newEntity: philipsHueDE);
    } else {
      logger.w('PhilipsHue device type does not exist');
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
