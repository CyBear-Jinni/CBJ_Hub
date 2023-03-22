import 'dart:async';

import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/generic_blinds_device/generic_blinds_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_boiler_device/generic_boiler_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_smart_plug_device/generic_smart_plug_entity.dart';
import 'package:cbj_hub/infrastructure/devices/companies_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/switcher/switcher_api/switcher_api_object.dart';
import 'package:cbj_hub/infrastructure/devices/switcher/switcher_helpers.dart';
import 'package:cbj_hub/infrastructure/devices/switcher/switcher_runner/switcher_runner_entity.dart';
import 'package:cbj_hub/infrastructure/devices/switcher/switcher_smart_plug/switcher_smart_plug_entity.dart';
import 'package:cbj_hub/infrastructure/devices/switcher/switcher_v2/switcher_v2_entity.dart';
import 'package:cbj_hub/infrastructure/generic_devices/abstract_device/abstract_company_connector_conjector.dart';
import 'package:cbj_hub/utils.dart';
import 'package:injectable/injectable.dart';

@singleton
class SwitcherConnectorConjector implements AbstractCompanyConnectorConjector {
  static Map<String, DeviceEntityAbstract> companyDevices = {};

  Future<void> addOnlyNewSwitcherDevice(
    SwitcherApiObject switcherApiObject,
  ) async {
    CoreUniqueId? tempCoreUniqueId;

    for (final DeviceEntityAbstract savedDevice in companyDevices.values) {
      if ((savedDevice is SwitcherV2Entity ||
              savedDevice is SwitcherRunnerEntity ||
              savedDevice is SwitcherSmartPlugEntity) &&
          switcherApiObject.deviceId ==
              savedDevice.entityUniqueId.getOrCrash()) {
        return;
      } else if (savedDevice is GenericBoilerDE ||
          savedDevice is GenericBlindsDE &&
              switcherApiObject.deviceId ==
                  savedDevice.entityUniqueId.getOrCrash()) {
        /// Device exist as generic and needs to get converted to non generic type for this vendor
        tempCoreUniqueId = savedDevice.uniqueId;
        break;
      } else if (switcherApiObject.deviceId ==
          savedDevice.entityUniqueId.getOrCrash()) {
        logger.w(
          'Switcher device type supported but implementation is missing here',
        );
        break;
      }
    }

    final DeviceEntityAbstract? addDevice = SwitcherHelpers.addDiscoverdDevice(
      switcherDevice: switcherApiObject,
      uniqueDeviceId: tempCoreUniqueId,
    );
    if (addDevice == null) {
      return;
    }

    final DeviceEntityAbstract deviceToAdd =
        CompaniesConnectorConjector.addDiscoverdDeviceToHub(addDevice);

    final MapEntry<String, DeviceEntityAbstract> deviceAsEntry =
        MapEntry(deviceToAdd.entityUniqueId.getOrCrash(), deviceToAdd);

    companyDevices.addEntries([deviceAsEntry]);

    // logger.v('New switcher devices name:${switcherApiObject.switcherName}');
  }

  Future<void> manageHubRequestsForDevice(
    DeviceEntityAbstract switcherDE,
  ) async {
    final DeviceEntityAbstract? device =
        companyDevices[switcherDE.entityUniqueId.getOrCrash()];

    // if (device == null) {
    //   setTheSameDeviceFromAllDevices(switcherDE);
    //   device =
    //   companyDevices[switcherDE.getDeviceId()];
    // }

    if (device != null &&
        (device is SwitcherV2Entity ||
            device is SwitcherRunnerEntity ||
            device is SwitcherSmartPlugEntity)) {
      device.executeDeviceAction(newEntity: switcherDE);
    } else {
      logger.w('Switcher device type ${device.runtimeType} does not exist');
    }
  }

  // Future<void> setTheSameDeviceFromAllDevices(
  //   DeviceEntityAbstract switcherDE,
  // ) async {
  //   final String deviceEntityUniqueId = switcherDE.entityUniqueId.getOrCrash();
  //   for(a)
  // }

  @override
  Future<void> setUpDeviceFromDb(DeviceEntityAbstract deviceEntity) async {
    DeviceEntityAbstract? nonGenericDevice;

    if (deviceEntity is GenericBoilerDE) {
      nonGenericDevice = SwitcherV2Entity.fromGeneric(deviceEntity);
    } else if (deviceEntity is GenericSmartPlugDE) {
      nonGenericDevice = SwitcherSmartPlugEntity.fromGeneric(deviceEntity);
    } else if (deviceEntity is GenericBlindsDE) {
      nonGenericDevice = SwitcherRunnerEntity.fromGeneric(deviceEntity);
    }

    if (nonGenericDevice == null) {
      logger.w('Switcher device could not get loaded from the server');
      return;
    }

    companyDevices.addEntries([
      MapEntry(nonGenericDevice.entityUniqueId.getOrCrash(), nonGenericDevice),
    ]);
  }
}
