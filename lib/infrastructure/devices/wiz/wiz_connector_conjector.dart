import 'dart:async';

import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/vendors/wiz_login/generic_wiz_login_entity.dart';
import 'package:cbj_hub/infrastructure/devices/wiz/wiz_white/wiz_white_entity.dart';
import 'package:cbj_hub/infrastructure/generic_devices/abstract_device/abstract_company_connector_conjector.dart';
import 'package:cbj_hub/utils.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:network_tools/network_tools.dart';

@singleton
class WizConnectorConjector implements AbstractCompanyConnectorConjector {
  Future<String> accountLogin(GenericWizLoginDE genericWizLoginDE) async {
    // wizClient = WizClient(genericWizLoginDE.wizApiKey.getOrCrash());
    _discoverNewDevices();
    return 'Success';
  }

  static Map<String, DeviceEntityAbstract> companyDevices = {};

  Future<void> addNewDeviceByHostInfo({
    required ActiveHost activeHost,
  }) async {
    logger.w('Wiz device got discovered but missing implementation');
    // final List<CoreUniqueId?> tempCoreUniqueId = [];
    //
    // for (final DeviceEntityAbstract savedDevice in companyDevices.values) {
    //   if ((savedDevice is WizWhiteEntity) &&
    //       await activeHost.hostName ==
    //           savedDevice.vendorUniqueId.getOrCrash()) {
    //     return;
    //   } else if (await activeHost.hostName ==
    //       savedDevice.vendorUniqueId.getOrCrash()) {
    //     logger.w(
    //       'Wiz IP device type supported but implementation is missing here',
    //     );
    //   }
    // }
    // // TODO: Create list of CoreUniqueId and populate it with all the
    // //  components saved devices that already exist
    // final List<String> componentsInDevice =
    //     await getAllComponentsOfDevice(activeHost);
    //
    // final List<DeviceEntityAbstract> wizIpDevices =
    //     await WizIpHelpers.addDiscoverdDevice(
    //   activeHost: activeHost,
    //   uniqueDeviceIdList: tempCoreUniqueId,
    //   componentInDeviceNumberLabelList: componentsInDevice,
    // );
    //
    // if (wizIpDevices.isEmpty) {
    //   return;
    // }
    //
    // for (final DeviceEntityAbstract entityAsDevice in wizIpDevices) {
    //   final DeviceEntityAbstract deviceToAdd =
    //       CompaniesConnectorConjector.addDiscoverdDeviceToHub(entityAsDevice);
    //
    //   final MapEntry<String, DeviceEntityAbstract> deviceAsEntry =
    //       MapEntry(deviceToAdd.uniqueId.getOrCrash(), deviceToAdd);
    //
    //   companyDevices.addEntries([deviceAsEntry]);
    //
    //   logger.v(
    //     'New Wiz Ip device name:${entityAsDevice.defaultName.getOrCrash()}',
    //   );
    // }
  }

  // static WizClient? wizClient;

  Future<void> _discoverNewDevices() async {
    while (true) {
      try {
        // final Iterable<WizBulb> lights =
        //     await wizClient!.listLights(const Selector());

        // for (final WizBulb wizDevice in lights) {
        //   CoreUniqueId? tempCoreUniqueId;
        //   bool deviceExist = false;
        //   for (final DeviceEntityAbstract savedDevice
        //       in companyDevices.values) {
        //     if (savedDevice is WizWhiteEntity &&
        //         wizDevice.id == savedDevice.vendorUniqueId.getOrCrash()) {
        //       deviceExist = true;
        //       break;
        //     } else if (savedDevice is GenericLightDE &&
        //         wizDevice.id == savedDevice.vendorUniqueId.getOrCrash()) {
        //       tempCoreUniqueId = savedDevice.uniqueId;
        //       break;
        //     } else if (wizDevice.id ==
        //         savedDevice.vendorUniqueId.getOrCrash()) {
        //       logger.w(
        //         'Wiz device type supported but implementation is missing here',
        //       );
        //       break;
        //     }
        //   }
        //   if (!deviceExist) {
        //     final DeviceEntityAbstract? addDevice =
        //         WizHelpers.addDiscoverdDevice(
        //       wizDevice: wizDevice,
        //       uniqueDeviceId: tempCoreUniqueId,
        //     );
        //
        //     if (addDevice == null) {
        //       continue;
        //     }
        //
        //     final DeviceEntityAbstract deviceToAdd =
        //         CompaniesConnectorConjector.addDiscoverdDeviceToHub(addDevice);
        //
        //     final MapEntry<String, DeviceEntityAbstract> deviceAsEntry =
        //         MapEntry(deviceToAdd.uniqueId.getOrCrash(), deviceToAdd);
        //
        //     companyDevices.addEntries([deviceAsEntry]);
        //
        //     logger.i('New Wiz device got added');
        //   }
        // }
        await Future.delayed(const Duration(minutes: 3));
      } catch (e) {
        logger.e('Error discover in Wiz\n$e');
        await Future.delayed(const Duration(minutes: 1));
      }
    }
  }

  Future<Either<CoreFailure, Unit>> create(DeviceEntityAbstract wiz) {
    // TODO: implement create
    throw UnimplementedError();
  }

  Future<Either<CoreFailure, Unit>> delete(DeviceEntityAbstract wiz) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  Future<void> initiateHubConnection() {
    // TODO: implement initiateHubConnection
    throw UnimplementedError();
  }

  Future<void> manageHubRequestsForDevice(
    DeviceEntityAbstract wizDE,
  ) async {
    final DeviceEntityAbstract? device = companyDevices[wizDE.getDeviceId()];

    if (device is WizWhiteEntity) {
      device.executeDeviceAction(newEntity: wizDE);
    } else {
      logger.w('Wiz device type does not exist');
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
