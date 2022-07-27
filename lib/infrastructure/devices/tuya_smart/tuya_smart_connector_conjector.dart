import 'dart:async';

import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/vendors/tuya_login/generic_tuya_login_entity.dart';
import 'package:cbj_hub/infrastructure/devices/companies_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/tuya_smart/tuya_smart_helpers.dart';
import 'package:cbj_hub/infrastructure/devices/tuya_smart/tuya_smart_jbt_a70_rgbcw_wf/tuya_smart_jbt_a70_rgbcw_wf_entity.dart';
import 'package:cbj_hub/infrastructure/devices/tuya_smart/tuya_smart_plug/tuya_smart_switch_entity.dart';
import 'package:cbj_hub/infrastructure/devices/tuya_smart/tuya_smart_remote_api/cloudtuya.dart';
import 'package:cbj_hub/infrastructure/devices/tuya_smart/tuya_smart_remote_api/tuya_device_abstract.dart';
import 'package:cbj_hub/infrastructure/devices/tuya_smart/tuya_smart_switch/tuya_smart_switch_entity.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/infrastructure/generic_devices/abstract_device/abstract_company_connector_conjector.dart';
import 'package:cbj_hub/utils.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@singleton
class TuyaSmartConnectorConjector implements AbstractCompanyConnectorConjector {
  Future<String> accountLogin({
    required GenericTuyaLoginDE genericTuyaLoginDE,
  }) async {
    final CloudTuya cloudTuyaTemp = cloudTuya = CloudTuya(
      userName: genericTuyaLoginDE.tuyaUserName.getOrCrash(),
      userPassword: genericTuyaLoginDE.tuyaUserPassword.getOrCrash(),
      countryCode: genericTuyaLoginDE.tuyaCountryCode.getOrCrash(),
      bizType: genericTuyaLoginDE.tuyaBizType.getOrCrash(),
      region: genericTuyaLoginDE.tuyaRegion.getOrCrash(),
    );
    if (genericTuyaLoginDE.loginVendor.getOrCrash() ==
        VendorsAndServices.tuyaSmart.name) {
      cloudTuya = cloudTuyaTemp..bizType = 'tuya';
      final bool loginSuccess = await cloudTuya.login();
      if (!loginSuccess) {
        return 'Error';
      }
      _discoverNewDevices(cloudTuyaOrSmartLifeOrJinvooSmart: cloudTuya);
    } else if (genericTuyaLoginDE.loginVendor.getOrCrash() ==
        VendorsAndServices.smartLife.name) {
      cloudSmartLife = cloudTuyaTemp..bizType = 'smart_life';
      final bool loginSuccess = await cloudSmartLife.login();
      if (!loginSuccess) {
        return 'Error';
      }
      _discoverNewDevices(cloudTuyaOrSmartLifeOrJinvooSmart: cloudSmartLife);
      return 'Success';
    } else if (genericTuyaLoginDE.loginVendor.getOrCrash() ==
        VendorsAndServices.jinvooSmart.name) {
      cloudJinvooSmart = cloudTuyaTemp..bizType = 'jinvoo_smart';
      final bool loginSuccess = await cloudJinvooSmart.login();
      if (!loginSuccess) {
        return 'Error';
      }
      _discoverNewDevices(cloudTuyaOrSmartLifeOrJinvooSmart: cloudJinvooSmart);
      return 'Success';
    }
    // TODO: Add other types
    return 'Success';
  }

  static late CloudTuya cloudTuya;
  static late CloudTuya cloudJinvooSmart;
  static late CloudTuya cloudSmartLife;

  static Map<String, DeviceEntityAbstract> companyDevices = {};

  Future<void> _discoverNewDevices({
    required CloudTuya cloudTuyaOrSmartLifeOrJinvooSmart,
  }) async {
    while (true) {
      try {
        final List<TuyaDeviceAbstract> deviceList =
            await cloudTuyaOrSmartLifeOrJinvooSmart.findDevices();

        for (final TuyaDeviceAbstract tuyaDevice in deviceList) {
          bool deviceExist = false;
          for (final DeviceEntityAbstract savedDevice
              in companyDevices.values) {
            if (savedDevice is TuyaSmartJbtA70RgbcwWfEntity ||
                savedDevice is TuyaSmartSwitchEntity ||
                savedDevice is TuyaSmartPlugEntity) {
              if (tuyaDevice.id == savedDevice.vendorUniqueId.getOrCrash()) {
                deviceExist = true;
                break;
              }
            } else {
              logger.i('Please add new Tuya device type ${tuyaDevice.haType}');
              deviceExist = true;
              break;
            }
          }
          if (!deviceExist) {
            final DeviceEntityAbstract addDevice =
                TuyaSmartHelpers.addDiscoverdDevice(
              tuyaSmartDevice: tuyaDevice,
              cloudTuyaOrSmartLifeOrJinvooSmart:
                  cloudTuyaOrSmartLifeOrJinvooSmart,
            );

            final DeviceEntityAbstract deviceToAdd =
                CompaniesConnectorConjector.addDiscoverdDeviceToHub(addDevice);

            final MapEntry<String, DeviceEntityAbstract> deviceAsEntry =
                MapEntry(deviceToAdd.uniqueId.getOrCrash(), deviceToAdd);

            companyDevices.addEntries([deviceAsEntry]);

            logger.i(
              'New Tuya devices where added named '
              '${addDevice.defaultName.getOrCrash()}',
            );
          }
        }
        await Future.delayed(const Duration(minutes: 3));
      } catch (e) {
        logger.e('Error discover in Tuya\n$e');
        await Future.delayed(const Duration(minutes: 1));
      }
    }
  }

  Future<Either<CoreFailure, Unit>> create(DeviceEntityAbstract tuyaSmart) {
    // TODO: implement create
    throw UnimplementedError();
  }

  Future<Either<CoreFailure, Unit>> delete(DeviceEntityAbstract tuyaSmart) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  Future<void> initiateHubConnection() {
    // TODO: implement initiateHubConnection
    throw UnimplementedError();
  }

  Future<void> manageHubRequestsForDevice(
    DeviceEntityAbstract tuyaSmartDE,
  ) async {
    final DeviceEntityAbstract? device =
        companyDevices[tuyaSmartDE.getDeviceId()];

    if (device is TuyaSmartJbtA70RgbcwWfEntity) {
      device.executeDeviceAction(newEntity: tuyaSmartDE);
    } else if (device is TuyaSmartSwitchEntity) {
      device.executeDeviceAction(newEntity: tuyaSmartDE);
    } else if (device is TuyaSmartPlugEntity) {
      device.executeDeviceAction(newEntity: tuyaSmartDE);
    } else {
      logger.w('TuyaSmart device type does not exist');
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
