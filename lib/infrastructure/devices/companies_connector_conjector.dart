import 'dart:io';

import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/saved_devices/i_saved_devices_repo.dart';
import 'package:cbj_hub/domain/vendors/lifx_login/generic_lifx_login_entity.dart';
import 'package:cbj_hub/domain/vendors/login_abstract/login_entity_abstract.dart';
import 'package:cbj_hub/domain/vendors/tuya_login/generic_tuya_login_entity.dart';
import 'package:cbj_hub/infrastructure/devices/esphome/esphome_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/google/google_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/lg/lg_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/lifx/lifx_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/switcher/switcher_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/tasmota/tasmota_ip/tasmota_ip_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/tasmota/tasmota_mqtt/tasmota_mqtt_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/tuya_smart/tuya_smart_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/xiaomi_io/xiaomi_io_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/yeelight/yeelight_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/injection.dart';
import 'package:cbj_hub/utils.dart';
import 'package:network_tools/network_tools.dart';

class CompaniesConnectorConjector {
  static void updateAllDevicesReposWithDeviceChanges(
    Stream<dynamic> allDevices,
  ) {
    allDevices.listen((deviceEntityAbstract) {
      if (deviceEntityAbstract is DeviceEntityAbstract) {
        final String deviceVendor =
            deviceEntityAbstract.deviceVendor.getOrCrash();
        if (deviceVendor == VendorsAndServices.yeelight.toString()) {
          YeelightConnectorConjector()
              .manageHubRequestsForDevice(deviceEntityAbstract);
        } else if (deviceVendor == VendorsAndServices.tasmota.toString()) {
          TasmotaMqttConnectorConjector()
              .manageHubRequestsForDevice(deviceEntityAbstract);
        } else if (deviceVendor == VendorsAndServices.espHome.toString()) {
          ESPHomeConnectorConjector()
              .manageHubRequestsForDevice(deviceEntityAbstract);
        } else if (deviceVendor ==
            VendorsAndServices.switcherSmartHome.toString()) {
          SwitcherConnectorConjector()
              .manageHubRequestsForDevice(deviceEntityAbstract);
        } else if (deviceVendor == VendorsAndServices.google.toString()) {
          GoogleConnectorConjector()
              .manageHubRequestsForDevice(deviceEntityAbstract);
        } else if (deviceVendor == VendorsAndServices.miHome.toString()) {
          XiaomiIoConnectorConjector()
              .manageHubRequestsForDevice(deviceEntityAbstract);
        } else if (deviceVendor == VendorsAndServices.tuyaSmart.toString()) {
          TuyaSmartConnectorConjector()
              .manageHubRequestsForDevice(deviceEntityAbstract);
        } else if (deviceVendor == VendorsAndServices.lifx.toString()) {
          LifxConnectorConjector()
              .manageHubRequestsForDevice(deviceEntityAbstract);
        } else {
          logger.i(
            'Cannot send device changes to its repo, company not supported',
          );
        }
      } else {
        logger.w('Connector conjector got other type');
      }
    });
  }

  static void addAllDevicesToItsRepos(
    Map<String, DeviceEntityAbstract> allDevices,
  ) {
    for (final String deviceId in allDevices.keys) {
      final MapEntry<String, DeviceEntityAbstract> currentDeviceMapEntry =
          MapEntry<String, DeviceEntityAbstract>(
        deviceId,
        allDevices[deviceId]!,
      );
      addDeviceToItsRepo(currentDeviceMapEntry);
    }
  }

  static void addDeviceToItsRepo(
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
      TasmotaMqttConnectorConjector.companyDevices.addEntries([devicesEntry]);
    } else if (deviceVendor == VendorsAndServices.espHome.toString()) {
      ESPHomeConnectorConjector.companyDevices.addEntries([devicesEntry]);
    } else if (deviceVendor ==
        VendorsAndServices.switcherSmartHome.toString()) {
      SwitcherConnectorConjector.companyDevices.addEntries([devicesEntry]);
    } else if (deviceVendor == VendorsAndServices.google.toString()) {
      GoogleConnectorConjector.companyDevices.addEntries([devicesEntry]);
    } else if (deviceVendor == VendorsAndServices.miHome.toString()) {
      XiaomiIoConnectorConjector.companyDevices.addEntries([devicesEntry]);
    } else if (deviceVendor == VendorsAndServices.tuyaSmart.toString()) {
      TuyaSmartConnectorConjector.companyDevices.addEntries([devicesEntry]);
    } else if (deviceVendor == VendorsAndServices.lifx.toString()) {
      LifxConnectorConjector.companyDevices.addEntries([devicesEntry]);
    } else {
      logger.w('Cannot add device entity to its repo, type not supported');
    }
  }

  static DeviceEntityAbstract addDiscoverdDeviceToHub(
    DeviceEntityAbstract deviceEntity,
  ) {
    return getIt<ISavedDevicesRepo>().addOrUpdateDevice(deviceEntity);
  }

  static void setVendorLoginCredentials(LoginEntityAbstract loginEntity) {
    if (loginEntity is GenericLifxLoginDE) {
      getIt<LifxConnectorConjector>().accountLogin(loginEntity);
    } else if (loginEntity is GenericTuyaLoginDE) {
      getIt<TuyaSmartConnectorConjector>()
          .accountLogin(genericTuyaLoginDE: loginEntity);
    } else {
      logger.w('Vendor login type ${loginEntity.runtimeType} is not supported');
    }
  }

  static Future<void> searchAllMdnsDevicesAndSetThemUp() async {
    while (true) {
      for (final ActiveHost activeHost
          in await MdnsScanner.searchMdnsDevices()) {
        final MdnsInfo? mdnsInfo = activeHost.mdnsInfo;

        if (mdnsInfo != null) {
          setMdnsDeviceByCompany(activeHost);
        }
      }
      await Future.delayed(const Duration(minutes: 1));
    }
  }

  /// Getting ActiveHost that contain MdnsInfo property and activate it inside
  /// The correct company.
  static Future<void> setMdnsDeviceByCompany(ActiveHost activeHost) async {
    final MdnsInfo? hostMdnsInfo = activeHost.mdnsInfo;

    if (hostMdnsInfo == null) {
      return;
    }
    final String startOfMdnsName = hostMdnsInfo.getOnlyTheStartOfMdnsName();
    final String startOfMdnsNameLower = startOfMdnsName.toLowerCase();

    final String mdnsDeviceIp = activeHost.ip;
    final String mdnsPort = hostMdnsInfo.mdnsPort.toString();

    if (ESPHomeConnectorConjector.mdnsTypes
        .contains(hostMdnsInfo.mdnsServiceType)) {
      ESPHomeConnectorConjector().addNewDeviceByMdnsName(
        mDnsName: startOfMdnsName,
        ip: mdnsDeviceIp,
        port: mdnsPort,
      );
    } else if (GoogleConnectorConjector.mdnsTypes
            .contains(hostMdnsInfo.mdnsServiceType) &&
        (startOfMdnsNameLower.contains('google') ||
            startOfMdnsNameLower.contains('android') ||
            startOfMdnsNameLower.contains('chrome'))) {
      GoogleConnectorConjector().addNewDeviceByMdnsName(
        mDnsName: startOfMdnsName,
        ip: mdnsDeviceIp,
        port: mdnsPort,
      );
    } else if (LgConnectorConjector.mdnsTypes
            .contains(hostMdnsInfo.mdnsServiceType) &&
        (startOfMdnsNameLower.contains('lg') ||
            startOfMdnsNameLower.contains('webos'))) {
      LgConnectorConjector().addNewDeviceByMdnsName(
        mDnsName: startOfMdnsName,
        ip: mdnsDeviceIp,
        port: mdnsPort,
      );
    } else {
      // logger.v(
      //   'mDNS service type ${hostMdnsInfo.mdnsServiceType} is not supported\n IP: ${activeHost.ip}, Port: ${hostMdnsInfo.mdnsPort}, ServiceType: ${hostMdnsInfo.mdnsServiceType}, MdnsName: ${hostMdnsInfo.getOnlyTheStartOfMdnsName()}',
      // );
    }
  }

  /// Get all the host names in the connected networks and try to add the device
  static Future<void> searchPingableDevicesAndSetThemUpByHostName() async {
    final List<Stream<ActiveHost>> activeHostStreamList = [];

    while (true) {
      final List<NetworkInterface> networkInterfaceList =
          await NetworkInterface.list();

      for (final NetworkInterface networkInterface in networkInterfaceList) {
        for (final InternetAddress address in networkInterface.addresses) {
          final String ip = address.address;
          final String subnet = ip.substring(0, ip.lastIndexOf('.'));
          activeHostStreamList.add(HostScanner.discover(subnet));
        }
      }

      for (final Stream<ActiveHost> activeHostStream in activeHostStreamList) {
        await for (final ActiveHost activeHost in activeHostStream) {
          final InternetAddress? internetAddress =
              InternetAddress.tryParse(activeHost.ip);
          if (internetAddress == null) {
            continue;
          }
          try {
            final InternetAddress internetAddressWithHostName =
                await internetAddress.reverse();
            setHostNameDeviceByCompany(
                activeHost: activeHost,
                internetAddress: internetAddressWithHostName);
          } catch (e) {
            continue;
          }
        }

        await Future.delayed(const Duration(minutes: 1));
      }
    }
  }

  static Future<void> setHostNameDeviceByCompany({
    required InternetAddress internetAddress,
    required ActiveHost activeHost,
  }) async {
    final String deviceHostNameLowerCase = internetAddress.host.toLowerCase();
    if (deviceHostNameLowerCase.contains('tasmota')) {
      TasmotaIpConnectorConjector().addNewDeviceByHostInfo(
        activeHost: activeHost,
        hostName: internetAddress.host,
      );
    } else if (deviceHostNameLowerCase.contains('xiaomi') ||
        deviceHostNameLowerCase.contains('yeelink')) {
    } else {
      logger.i('Internet Name ${internetAddress.host}');
    }
  }
}
