import 'dart:async';

import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/generic_rgbw_light_device/generic_rgbw_light_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_smart_plug_device/generic_smart_plug_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_switch_device/generic_switch_entity.dart';
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
import 'package:injectable/injectable.dart';

@singleton
class TuyaSmartConnectorConjector implements AbstractCompanyConnectorConjector {
  @override
  Map<String, DeviceEntityAbstract> companyDevices = {};

  static late CloudTuya cloudTuya;
  static late CloudTuya cloudJinvooSmart;
  static late CloudTuya cloudSmartLife;

  Future<String> accountLogin(
    GenericTuyaLoginDE loginDE,
  ) async {
    final CloudTuya cloudTuyaTemp = cloudTuya = CloudTuya(
      userName: loginDE.tuyaUserName.getOrCrash(),
      userPassword: loginDE.tuyaUserPassword.getOrCrash(),
      countryCode: loginDE.tuyaCountryCode.getOrCrash(),
      bizType: loginDE.tuyaBizType.getOrCrash(),
      region: loginDE.tuyaRegion.getOrCrash(),
    );
    if (loginDE.loginVendor.getOrCrash() == VendorsAndServices.tuyaSmart.name) {
      cloudTuya = cloudTuyaTemp..bizType = 'tuya';
      final bool loginSuccess = await cloudTuya.login();
      if (!loginSuccess) {
        return 'Error';
      }
      _discoverNewDevices(cloudTuyaOrSmartLifeOrJinvooSmart: cloudTuya);
    } else if (loginDE.loginVendor.getOrCrash() ==
        VendorsAndServices.smartLife.name) {
      cloudSmartLife = cloudTuyaTemp..bizType = 'smart_life';
      final bool loginSuccess = await cloudSmartLife.login();
      if (!loginSuccess) {
        return 'Error';
      }
      _discoverNewDevices(cloudTuyaOrSmartLifeOrJinvooSmart: cloudSmartLife);
      return 'Success';
    } else if (loginDE.loginVendor.getOrCrash() ==
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

  Future<void> _discoverNewDevices({
    required CloudTuya cloudTuyaOrSmartLifeOrJinvooSmart,
  }) async {
    while (true) {
      try {
        final List<TuyaDeviceAbstract> deviceList =
            await cloudTuyaOrSmartLifeOrJinvooSmart.findDevices();

        for (final TuyaDeviceAbstract tuyaDevice in deviceList) {
          bool deviceExist = false;
          CoreUniqueId? tempCoreUniqueId;

          for (final DeviceEntityAbstract savedDevice
              in companyDevices.values) {
            if ((savedDevice is TuyaSmartJbtA70RgbcwWfEntity ||
                    savedDevice is TuyaSmartSwitchEntity ||
                    savedDevice is TuyaSmartPlugEntity) &&
                tuyaDevice.id == savedDevice.entityUniqueId.getOrCrash()) {
              deviceExist = true;
              break;
            } else if ((savedDevice is GenericRgbwLightDE ||
                    savedDevice is GenericSwitchDE ||
                    savedDevice is GenericSmartPlugDE) &&
                tuyaDevice.id == savedDevice.entityUniqueId.getOrCrash()) {
              /// Device exist as generic and needs to get converted to non generic type for this vendor
              tempCoreUniqueId = savedDevice.uniqueId;
              break;
            } else if (tuyaDevice.id ==
                savedDevice.entityUniqueId.getOrCrash()) {
              logger.w(
                'Tuya Mqtt device type supported but implementation is missing here',
              );
              break;
            }
          }
          if (!deviceExist) {
            final DeviceEntityAbstract? addDevice =
                TuyaSmartHelpers.addDiscoverdDevice(
              tuyaSmartDevice: tuyaDevice,
              cloudTuyaOrSmartLifeOrJinvooSmart:
                  cloudTuyaOrSmartLifeOrJinvooSmart,
              uniqueDeviceId: tempCoreUniqueId,
            );
            if (addDevice == null) {
              continue;
            }
            final DeviceEntityAbstract deviceToAdd =
                CompaniesConnectorConjector.addDiscoverdDeviceToHub(addDevice);

            final MapEntry<String, DeviceEntityAbstract> deviceAsEntry =
                MapEntry(deviceToAdd.uniqueId.getOrCrash(), deviceToAdd);

            companyDevices.addEntries([deviceAsEntry]);

            logger.i(
              'New Tuya device got added named '
              '${addDevice.cbjEntityName.getOrCrash()}',
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

  @override
  Future<void> manageHubRequestsForDevice(
    DeviceEntityAbstract tuyaSmartDE,
  ) async {
    final DeviceEntityAbstract? device =
        companyDevices[tuyaSmartDE.entityUniqueId.getOrCrash()];

    if (device is TuyaSmartJbtA70RgbcwWfEntity) {
      device.executeDeviceAction(newEntity: tuyaSmartDE);
    } else if (device is TuyaSmartSwitchEntity) {
      device.executeDeviceAction(newEntity: tuyaSmartDE);
    } else if (device is TuyaSmartPlugEntity) {
      device.executeDeviceAction(newEntity: tuyaSmartDE);
    } else {
      logger.w(
        'TuyaSmart device type does not exist ${device?.entityTypes.getOrCrash()}',
      );
    }
  }

  @override
  Future<void> setUpDeviceFromDb(DeviceEntityAbstract deviceEntity) async {}
}
