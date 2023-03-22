import 'dart:async';

import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/generic_rgbw_light_device/generic_rgbw_light_entity.dart';
import 'package:cbj_hub/infrastructure/devices/companies_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/yeelight/yeelight_1se/yeelight_1se_entity.dart';
import 'package:cbj_hub/infrastructure/devices/yeelight/yeelight_helpers.dart';
import 'package:cbj_hub/infrastructure/generic_devices/abstract_device/abstract_company_connector_conjector.dart';
import 'package:cbj_hub/utils.dart';
import 'package:injectable/injectable.dart';
import 'package:yeedart/yeedart.dart';

@singleton
class YeelightConnectorConjector implements AbstractCompanyConnectorConjector {
  static Map<String, DeviceEntityAbstract> companyDevices = {};

  Future<void> discoverNewDevices() async {
    while (true) {
      try {
        final responses = await Yeelight.discover();
        for (final DiscoveryResponse yeelightDevice in responses) {
          bool deviceExist = false;
          CoreUniqueId? tempCoreUniqueId;

          for (final DeviceEntityAbstract savedDevice
              in companyDevices.values) {
            if (savedDevice is Yeelight1SeEntity &&
                yeelightDevice.id.toString() ==
                    savedDevice.entityUniqueId.getOrCrash()) {
              deviceExist = true;
              break;
            } else if (savedDevice is GenericRgbwLightDE &&
                yeelightDevice.id.toString() ==
                    savedDevice.entityUniqueId.getOrCrash()) {
              /// Device exist as generic and needs to get converted to non generic type for this vendor
              tempCoreUniqueId = savedDevice.uniqueId;
              break;
            } else if (yeelightDevice.id.toString() ==
                savedDevice.entityUniqueId.getOrCrash()) {
              logger.w(
                'Yeelight Mqtt device type supported but implementation is missing here',
              );
              break;
            }
          }
          if (!deviceExist) {
            final DeviceEntityAbstract? addDevice =
                YeelightHelpers.addDiscoverdDevice(
              yeelightDevice: yeelightDevice,
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

            logger.i('New Yeelight device got added');
          }
        }
        await Future.delayed(const Duration(minutes: 3));
      } catch (e) {
        logger.e('Error discover in Yeelight\n$e');
        await Future.delayed(const Duration(minutes: 5));
      }
    }
  }

  Future<void> manageHubRequestsForDevice(
    DeviceEntityAbstract yeelightDE,
  ) async {
    final DeviceEntityAbstract? device =
        companyDevices[yeelightDE.getDeviceId()];

    if (device is Yeelight1SeEntity) {
      device.executeDeviceAction(newEntity: yeelightDE);
    } else {
      logger.w('Yeelight device type does not exist');
    }
  }

  @override
  Future<void> setUpDeviceFromDb(DeviceEntityAbstract deviceEntity) async {}
}
