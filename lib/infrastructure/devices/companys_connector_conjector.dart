import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/saved_devices/i_saved_devices_repo.dart';
import 'package:cbj_hub/infrastructure/devices/esphome/esphome_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/google/google_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/switcher/switcher_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/tasmota/tasmota_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/xiaomi_io/xiaomi_io_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/yeelight/yeelight_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/injection.dart';
import 'package:cbj_hub/utils.dart';

class CompanysConnectorConjector {
  static updateAllDevicesReposWithDeviceChanges(
    Stream<DeviceEntityAbstract> allDevices,
  ) {
    allDevices.listen((deviceEntityAbstract) {
      final String deviceVendor =
          deviceEntityAbstract.deviceVendor.getOrCrash();
      if (deviceVendor == VendorsAndServices.yeelight.toString()) {
        YeelightConnectorConjector()
            .manageHubRequestsForDevice(deviceEntityAbstract);
      } else if (deviceVendor == VendorsAndServices.tasmota.toString()) {
        TasmotaConnectorConjector()
            .manageHubRequestsForDevice(deviceEntityAbstract);
      } else if (deviceVendor == VendorsAndServices.espHome.toString()) {
        ESPHomeConnectorConjector()
            .manageHubRequestsForDevice(deviceEntityAbstract);
      } else if (deviceVendor == VendorsAndServices.switcher.toString()) {
        SwitcherConnectorConjector()
            .manageHubRequestsForDevice(deviceEntityAbstract);
      } else if (deviceVendor == VendorsAndServices.google.toString()) {
        GoogleConnectorConjector()
            .manageHubRequestsForDevice(deviceEntityAbstract);
      } else if (deviceVendor == VendorsAndServices.xiaomiMiio.toString()) {
        XiaomiIoConnectorConjector()
            .manageHubRequestsForDevice(deviceEntityAbstract);
      } else {
        logger
            .i('Cannot send device changes to its repo, company not supported');
      }
    });
  }

  static addAllDevicesToItsRepos(Map<String, DeviceEntityAbstract> allDevices) {
    for (final String deviceId in allDevices.keys) {
      final MapEntry<String, DeviceEntityAbstract> currentDeviceMapEntry =
          MapEntry<String, DeviceEntityAbstract>(
        deviceId,
        allDevices[deviceId]!,
      );
      addDeviceToItsRepo(currentDeviceMapEntry);
    }
  }

  static addDeviceToItsRepo(
    MapEntry<String, DeviceEntityAbstract> deviceEntityAbstract,
  ) {
    final MapEntry<String, DeviceEntityAbstract> devicesEntry =
        MapEntry<String, DeviceEntityAbstract>(
      deviceEntityAbstract.key,
      deviceEntityAbstract.value,
    );

    final String deviceVendor =
        deviceEntityAbstract.value.deviceVendor.getOrCrash();

    if (deviceVendor == VendorsAndServices.yeelight.toString()) {
      YeelightConnectorConjector.companyDevices.addEntries([devicesEntry]);
    } else if (deviceVendor == VendorsAndServices.tasmota.toString()) {
      TasmotaConnectorConjector.companyDevices.addEntries([devicesEntry]);
    } else if (deviceVendor == VendorsAndServices.espHome.toString()) {
      ESPHomeConnectorConjector.companyDevices.addEntries([devicesEntry]);
    } else if (deviceVendor == VendorsAndServices.switcher.toString()) {
      SwitcherConnectorConjector.companyDevices.addEntries([devicesEntry]);
    } else if (deviceVendor == VendorsAndServices.google.toString()) {
      GoogleConnectorConjector.companyDevices.addEntries([devicesEntry]);
    } else if (deviceVendor == VendorsAndServices.xiaomiMiio.toString()) {
      XiaomiIoConnectorConjector.companyDevices.addEntries([devicesEntry]);
    } else {
      print('Cannot add device entity to its repo, type not supported');
    }
  }

  static void addDiscoverdDeviceToHub(DeviceEntityAbstract deviceEntity) {
    getIt<ISavedDevicesRepo>().addOrUpdateDevice(deviceEntity);
  }
}
