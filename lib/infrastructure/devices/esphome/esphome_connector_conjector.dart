import 'dart:async';

import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/generic_light_device/generic_light_entity.dart';
import 'package:cbj_hub/infrastructure/devices/companies_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/esphome/esphome_helpers.dart';
import 'package:cbj_hub/infrastructure/devices/esphome/esphome_light/esphome_light_entity.dart';
import 'package:cbj_hub/infrastructure/generic_devices/abstract_device/abstract_company_connector_conjector.dart';
import 'package:cbj_hub/utils.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@singleton
class EspHomeConnectorConjector implements AbstractCompanyConnectorConjector {
  static const List<String> mdnsTypes = ['_esphomelib._tcp'];

  static Map<String, DeviceEntityAbstract> companyDevices = {};

  /// Add new devices to [companyDevices] if not exist
  Future<void> addNewDeviceByMdnsName({
    required String mDnsName,
    required String ip,
    required String port,
    required String address,
  }) async {
    CoreUniqueId? tempCoreUniqueId;

    logger.i('Found mdns of ESPHome device named $mDnsName in the ip $address');

    for (final DeviceEntityAbstract device in companyDevices.values) {
      if (device is EspHomeLightEntity &&
          mDnsName == device.vendorUniqueId.getOrCrash()) {
        return;
      } else if (device is GenericLightDE &&
          mDnsName == device.vendorUniqueId.getOrCrash()) {
        tempCoreUniqueId = device.uniqueId;
        break;
      } else if (mDnsName == device.vendorUniqueId.getOrCrash()) {
        logger.w(
          'ESPHome device type supported but implementation is missing here',
        );
        return;
      }
    }

    final List<DeviceEntityAbstract> espDevice =
        await EspHomeHelpers.addDiscoverdEntities(
      mDnsName: mDnsName,
      port: port,
      address: address,
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

      logger.i(
        'New ESPHome devices name:${entityAsDevice.defaultName.getOrCrash()}',
      );
    }
  }

  Future<void> manageHubRequestsForDevice(
    DeviceEntityAbstract espHomeDE,
  ) async {
    final DeviceEntityAbstract? device =
        companyDevices[espHomeDE.getDeviceId()];

    if (device is EspHomeLightEntity) {
      device.executeDeviceAction(newEntity: espHomeDE);
    } else {
      logger.w('ESPHome device type does not exist');
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

  Future<Either<CoreFailure, Unit>> create(DeviceEntityAbstract espHome) {
    // TODO: implement create
    throw UnimplementedError();
  }

  Future<Either<CoreFailure, Unit>> delete(DeviceEntityAbstract espHome) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  Future<void> initiateHubConnection() {
    // TODO: implement initiateHubConnection
    throw UnimplementedError();
  }
}
