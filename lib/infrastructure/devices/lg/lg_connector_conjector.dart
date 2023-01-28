import 'dart:async';

import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/infrastructure/devices/companies_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/lg/lg_helpers.dart';
import 'package:cbj_hub/infrastructure/devices/lg/lg_webos_tv/lg_webos_tv_entity.dart';
import 'package:cbj_hub/infrastructure/generic_devices/abstract_device/abstract_company_connector_conjector.dart';
import 'package:cbj_hub/utils.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@singleton
class LgConnectorConjector implements AbstractCompanyConnectorConjector {
  static Map<String, DeviceEntityAbstract> companyDevices = {};

  static const List<String> mdnsTypes = [
    '_hap._tcp',
    '_display._tcp',
    '_airplay._tcp'
  ];

  /// Add new devices to [companyDevices] if not exist
  Future<void> addNewDeviceByMdnsName({
    required String mDnsName,
    required String ip,
    required String port,
  }) async {
    CoreUniqueId? tempCoreUniqueId;

    for (final DeviceEntityAbstract device in companyDevices.values) {
      if (device is LgWebosTvEntity &&
          (mDnsName == device.vendorUniqueId.getOrCrash() ||
              ip == device.lastKnownIp!.getOrCrash())) {
        return;
      }
      // Same tv can have multiple mDns names so we can't compere it without ip in the object
      // else if (device is GenericSmartTvDE &&
      //     (mDnsName == device.vendorUniqueId.getOrCrash() ||
      //         ip == device.lastKnownIp!.getOrCrash())) {
      //   return;
      // }
      else if (mDnsName == device.vendorUniqueId.getOrCrash()) {
        logger.w(
          'LG device type supported but implementation is missing here',
        );
        return;
      }
    }

    final List<DeviceEntityAbstract> lgDevice = LgHelpers.addDiscoverdDevice(
      mDnsName: mDnsName,
      ip: ip,
      port: port,
      uniqueDeviceId: tempCoreUniqueId,
    );

    if (lgDevice.isEmpty) {
      return;
    }

    for (final DeviceEntityAbstract entityAsDevice in lgDevice) {
      final DeviceEntityAbstract deviceToAdd =
          CompaniesConnectorConjector.addDiscoverdDeviceToHub(entityAsDevice);

      final MapEntry<String, DeviceEntityAbstract> deviceAsEntry =
          MapEntry(deviceToAdd.uniqueId.getOrCrash(), deviceToAdd);

      companyDevices.addEntries([deviceAsEntry]);
      logger.i(
        'New LG device got added ${entityAsDevice.defaultName.getOrCrash()}',
      );
    }
  }

  Future<Either<CoreFailure, Unit>> create(DeviceEntityAbstract lg) {
    // TODO: implement create
    throw UnimplementedError();
  }

  Future<Either<CoreFailure, Unit>> delete(DeviceEntityAbstract lg) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  Future<void> initiateHubConnection() {
    // TODO: implement initiateHubConnection
    throw UnimplementedError();
  }

  Future<void> manageHubRequestsForDevice(DeviceEntityAbstract lgDE) async {
    final DeviceEntityAbstract? device = companyDevices[lgDE.getDeviceId()];

    if (device is LgWebosTvEntity) {
      device.executeDeviceAction(newEntity: lgDE);
    } else {
      logger.i('Lg device type does not exist');
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
