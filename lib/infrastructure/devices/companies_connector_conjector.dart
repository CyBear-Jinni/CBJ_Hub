import 'dart:io';

import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/mqtt_server/i_mqtt_server_repository.dart';
import 'package:cbj_hub/domain/saved_devices/i_saved_devices_repo.dart';
import 'package:cbj_hub/domain/vendors/esphome_login/generic_esphome_login_entity.dart';
import 'package:cbj_hub/domain/vendors/ewelink_login/generic_ewelink_login_entity.dart';
import 'package:cbj_hub/domain/vendors/lifx_login/generic_lifx_login_entity.dart';
import 'package:cbj_hub/domain/vendors/login_abstract/login_entity_abstract.dart';
import 'package:cbj_hub/domain/vendors/tuya_login/generic_tuya_login_entity.dart';
import 'package:cbj_hub/domain/vendors/xiaomi_mi_login/generic_xiaomi_mi_login_entity.dart';
import 'package:cbj_hub/infrastructure/devices/cbj_devices/cbj_devices_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/cbj_devices/cbj_smart_device_client/cbj_smart_device_client.dart';
import 'package:cbj_hub/infrastructure/devices/esphome/esphome_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/ewelink/ewelink_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/google/google_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/hp/hp_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/hp/hp_printer/hp_printer_entity.dart';
import 'package:cbj_hub/infrastructure/devices/lg/lg_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/lifx/lifx_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/philips_hue/philips_hue_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/shelly/shelly_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/sonoff_diy/sonoff_diy_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/switcher/switcher_api/switcher_discover.dart';
import 'package:cbj_hub/infrastructure/devices/switcher/switcher_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/tasmota/tasmota_ip/tasmota_ip_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/tuya_smart/tuya_smart_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/wiz/wiz_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/xiaomi_io/xiaomi_io_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/yeelight/yeelight_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/infrastructure/generic_devices/abstract_device/abstract_company_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/system_commands/system_commands_manager_d.dart';
import 'package:cbj_hub/injection.dart';
import 'package:cbj_hub/utils.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:network_tools/network_tools.dart';

class CompaniesConnectorConjector {
  static void updateAllDevicesReposWithDeviceChanges(
    Stream<dynamic> allDevices,
  ) {
    allDevices.listen((deviceEntityAbstract) {
      if (deviceEntityAbstract is DeviceEntityAbstract) {
        final String deviceVendor =
            deviceEntityAbstract.deviceVendor.getOrCrash();

        final AbstractCompanyConnectorConjector? companyConnectorConjector =
            vendorStringToCompanyConnectorConjector(deviceVendor);

        if (companyConnectorConjector != null) {
          companyConnectorConjector
              .manageHubRequestsForDevice(deviceEntityAbstract);
        } else {
          logger.w(
            'Cannot send device changes to its repo, company not supported $deviceVendor',
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
    for (final MapEntry<String, DeviceEntityAbstract> deviceId
        in allDevices.entries) {
      addDeviceToItsRepo(deviceId);
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

    final AbstractCompanyConnectorConjector? companyConnectorConjector =
        vendorStringToCompanyConnectorConjector(deviceVendor);

    if (companyConnectorConjector != null) {
      companyConnectorConjector.setUpDeviceFromDb(devicesEntry.value);
    } else {
      logger.w('Cannot add device entity to its repo, type not supported');
    }
  }

  static DeviceEntityAbstract addDiscoverdDeviceToHub(
    DeviceEntityAbstract deviceEntity,
  ) {
    final DeviceEntityAbstract deviceEntityGotSaved =
        getIt<ISavedDevicesRepo>().addOrUpdateDevice(deviceEntity);

    getIt<IMqttServerRepository>()
        .postSmartDeviceToAppMqtt(entityFromTheHub: deviceEntityGotSaved);

    return deviceEntityGotSaved;
  }

  static void setVendorLoginCredentials(LoginEntityAbstract loginEntity) {
    if (loginEntity is GenericLifxLoginDE) {
      getIt<LifxConnectorConjector>().accountLogin(loginEntity);
    } else if (loginEntity is GenericEspHomeLoginDE) {
      getIt<EspHomeConnectorConjector>().accountLogin(loginEntity);
    } else if (loginEntity is GenericTuyaLoginDE) {
      getIt<TuyaSmartConnectorConjector>().accountLogin(loginEntity);
    } else if (loginEntity is GenericXiaomiMiLoginDE) {
      getIt<XiaomiIoConnectorConjector>().accountLogin(loginEntity);
    } else if (loginEntity is GenericEwelinkLoginDE) {
      getIt<EwelinkConnectorConjector>().accountLogin(loginEntity);
    } else {
      logger.w('Vendor login type ${loginEntity.runtimeType} is not supported');
    }
  }

  static Future<void> searchAllMdnsDevicesAndSetThemUp() async {
    try {
      while (true) {
        while (true) {
          // TODO: mdns search crash if there is no local internet connection
          // but crash can't be cached using try catch.
          // InternetConnectionChecker().hasConnection; check if there is
          // connection to the www which is not needed for mdns search.
          // we need to replace this part with check that return true if
          // there is local internet connection/ device is connected to
          // local network.
          final bool result = await InternetConnectionChecker().hasConnection;
          if (result) {
            break;
          }
          logger.w('No internet connection detected, will try again in 2m to'
              ' search mdns in the network');
          await Future.delayed(const Duration(minutes: 2));
        }
        for (ActiveHost activeHost in await MdnsScanner.searchMdnsDevices(
          forceUseOfSavedSrvRecordList: true,
        )) {
          // In some cases for some reason we get empty result when trying to
          // resolve mdns name to ip, the only way we found to fix that is to
          // use resolve it using avahi-resolve-host-name
          if (activeHost.address == '0.0.0.0') {
            final String? mdnsSrvTarget =
                (await activeHost.mdnsInfo)?.mdnsSrvTarget;
            if (mdnsSrvTarget == null) {
              continue;
            }
            final String? deviceIp = await getIt<SystemCommandsManager>()
                .getIpFromMdnsName(mdnsSrvTarget);
            if (deviceIp == null) {
              continue;
            }
            activeHost = activeHost
              ..internetAddress = InternetAddress(deviceIp);
          }

          final MdnsInfo? mdnsInfo = await activeHost.mdnsInfo;

          if (mdnsInfo != null) {
            setMdnsDeviceByCompany(activeHost);
          }
        }
        await Future.delayed(const Duration(minutes: 2));
      }
    } catch (e) {
      logger.e('Mdns search error\n$e');
    }
  }

  /// Getting ActiveHost that contain MdnsInfo property and activate it inside
  /// The correct company.
  static Future<void> setMdnsDeviceByCompany(ActiveHost activeHost) async {
    final MdnsInfo? hostMdnsInfo = await activeHost.mdnsInfo;

    if (hostMdnsInfo == null) {
      return;
    }

    final String mdnsDeviceIp = activeHost.address;

    if (activeHost.internetAddress.type != InternetAddressType.IPv4) {
      return;
    }

    final String startOfMdnsName = hostMdnsInfo.getOnlyTheStartOfMdnsName();
    final String startOfMdnsNameLower = startOfMdnsName.toLowerCase();

    final String mdnsPort = hostMdnsInfo.mdnsPort.toString();

    if (EspHomeConnectorConjector.mdnsTypes
        .contains(hostMdnsInfo.mdnsServiceType)) {
      getIt<EspHomeConnectorConjector>().addNewDeviceByMdnsName(
        mDnsName: startOfMdnsName,
        ip: mdnsDeviceIp,
        port: mdnsPort,
        address: mdnsDeviceIp,
      );
    } else if (ShellyConnectorConjector.mdnsTypes
            .contains(hostMdnsInfo.mdnsServiceType) &&
        hostMdnsInfo
            .getOnlyTheStartOfMdnsName()
            .toLowerCase()
            .contains('shelly')) {
      getIt<ShellyConnectorConjector>().addNewDeviceByMdnsName(
        mDnsName: startOfMdnsName,
        ip: mdnsDeviceIp,
        port: mdnsPort,
      );
    } else if (EwelinkConnectorConjector.mdnsTypes
        .contains(hostMdnsInfo.mdnsServiceType)) {
      getIt<EwelinkConnectorConjector>()
          .discoverNewDevices(activeHost: activeHost);
    } else if (GoogleConnectorConjector.mdnsTypes
            .contains(hostMdnsInfo.mdnsServiceType) &&
        (startOfMdnsNameLower.contains('google') ||
            startOfMdnsNameLower.contains('android') ||
            startOfMdnsNameLower.contains('chrome'))) {
      getIt<GoogleConnectorConjector>().addNewDeviceByMdnsName(
        mDnsName: startOfMdnsName,
        ip: mdnsDeviceIp,
        port: mdnsPort,
      );
    } else if (LgConnectorConjector.mdnsTypes
            .contains(hostMdnsInfo.mdnsServiceType) &&
        (startOfMdnsNameLower.contains('lg') ||
            startOfMdnsNameLower.contains('webos'))) {
      getIt<LgConnectorConjector>().addNewDeviceByMdnsName(
        mDnsName: startOfMdnsName,
        ip: mdnsDeviceIp,
        port: mdnsPort,
      );
    } else if (HpPrinterEntity.mdnsTypes
            .contains(hostMdnsInfo.mdnsServiceType) &&
        (startOfMdnsNameLower.contains('hp'))) {
      getIt<HpConnectorConjector>().addNewDeviceByMdnsName(
        mDnsName: startOfMdnsName,
        ip: mdnsDeviceIp,
        port: mdnsPort,
      );
    } else if (YeelightConnectorConjector.mdnsTypes
            .contains(hostMdnsInfo.mdnsServiceType) &&
        (startOfMdnsName.startsWith('YL'))) {
      getIt<YeelightConnectorConjector>().addNewDeviceByMdnsName(
        mDnsName: startOfMdnsName,
        ip: mdnsDeviceIp,
        port: mdnsPort,
      );
    } else if (PhilipsHueConnectorConjector.mdnsTypes
        .contains(hostMdnsInfo.mdnsServiceType)) {
      getIt<PhilipsHueConnectorConjector>().addNewDeviceByMdnsName(
        mDnsName: startOfMdnsName,
        ip: mdnsDeviceIp,
        port: mdnsPort,
      );
    } else {
      logger.v(
        'mDNS service type ${hostMdnsInfo.mdnsServiceType} is not supported\n IP: ${activeHost.address}, Port: ${hostMdnsInfo.mdnsPort}, ServiceType: ${hostMdnsInfo.mdnsServiceType}, MdnsName: ${hostMdnsInfo.getOnlyTheStartOfMdnsName()}',
      );
    }
  }

  /// Get all the host names in the connected networks and try to add the device
  static Future<void> searchPingableDevicesAndSetThemUpByHostName() async {
    while (true) {
      final List<NetworkInterface> networkInterfaceList =
          await NetworkInterface.list();

      for (final NetworkInterface networkInterface in networkInterfaceList) {
        for (final InternetAddress address in networkInterface.addresses) {
          final String ip = address.address;
          if (!ip.contains('.')) {
            continue;
          }
          final String subnet = ip.substring(0, ip.lastIndexOf('.'));

          await for (final ActiveHost activeHost
              in HostScanner.getAllPingableDevices(
            subnet,
            lastHostId: 126,
          )) {
            try {
              setHostNameDeviceByCompany(
                activeHost: activeHost,
              );
            } catch (e) {
              continue;
            }
          }

          // Spits to 2 requests to fix error in snap https://github.com/CyBear-Jinni-user/CBJ_Hub_Snap/issues/2
          await for (final ActiveHost activeHost
              in HostScanner.getAllPingableDevices(
            subnet,
            firstHostId: 127,
          )) {
            try {
              setHostNameDeviceByCompany(
                activeHost: activeHost,
              );
            } catch (e) {
              continue;
            }
          }
        }
      }
      await Future.delayed(const Duration(minutes: 5));
    }
  }

  static Future<void> setHostNameDeviceByCompany({
    required ActiveHost activeHost,
  }) async {
    final String? deviceHostNameLowerCase =
        (await activeHost.hostName)?.toLowerCase();
    if (deviceHostNameLowerCase == null) {
      return;
    }
    if (deviceHostNameLowerCase.contains('tasmota')) {
      getIt<TasmotaIpConnectorConjector>().addNewDeviceByHostInfo(
        activeHost: activeHost,
      );
    } else if (deviceHostNameLowerCase.contains('xiaomi') ||
        deviceHostNameLowerCase.contains('yeelink') ||
        deviceHostNameLowerCase.contains('xiao')) {
      getIt<XiaomiIoConnectorConjector>()
          .discoverNewDevices(activeHost: activeHost);
    } else if (deviceHostNameLowerCase.startsWith('wiz')) {
      getIt<WizConnectorConjector>()
          .addNewDeviceByHostInfo(activeHost: activeHost);
    } else {
      final ActiveHost? cbjSmartDeviceHost =
          await CbjSmartDeviceClient.checkIfDeviceIsCbjSmartDevice(
        activeHost.address,
      );
      if (cbjSmartDeviceHost != null) {
        getIt<CbjDevicesConnectorConjector>()
            .addNewDeviceByHostInfo(activeHost: cbjSmartDeviceHost);
        return;
      }
      // logger.i('Found pingable device $deviceHostNameLowerCase');
    }
  }

  /// Searching devices by binding to sockets, used for devices with
  /// udp ports which can't be discovered by regular open (tcp) port scan
  static Future<void> searchDevicesByBindingIntoSockets() async {
    SwitcherDiscover.discover20002Devices().listen((switcherApiObject) {
      getIt<SwitcherConnectorConjector>()
          .addOnlyNewSwitcherDevice(switcherApiObject);
    });
    SwitcherDiscover.discover20003Devices().listen((switcherApiObject) {
      getIt<SwitcherConnectorConjector>()
          .addOnlyNewSwitcherDevice(switcherApiObject);
    });
  }

  /// Searching for mqtt devices
  static Future<void> searchDevicesByMqttPath() async {
    // getIt<TasmotaMqttConnectorConjector>().discoverNewDevices();
  }

  /// Devices that we need to insert in to the other search options but didn't
  /// got to it yet.
  /// We do implement here the start of the search for convince organization
  /// and since putting it in the constructor of singleton will be called
  /// before all of our program.
  static Future<void> notImplementedDevicesSearch() async {
    // getIt<YeelightConnectorConjector>().discoverNewDevices();
  }

  static AbstractCompanyConnectorConjector?
      vendorStringToCompanyConnectorConjector(
    String vendorName,
  ) {
    //TODO: convert vendorName to type and then use switch case

    if (vendorName == VendorsAndServices.espHome.toString()) {
      return getIt<EspHomeConnectorConjector>();
    } else if (vendorName == VendorsAndServices.switcherSmartHome.toString()) {
      return getIt<SwitcherConnectorConjector>();
    } else if (vendorName == VendorsAndServices.lifx.toString()) {
      return getIt<LifxConnectorConjector>();
    } else if (vendorName == VendorsAndServices.yeelight.toString()) {
      return getIt<YeelightConnectorConjector>();
    } else if (vendorName == VendorsAndServices.philipsHue.toString()) {
      return getIt<PhilipsHueConnectorConjector>();
    } else if (vendorName == VendorsAndServices.tuyaSmart.toString()) {
      return getIt<TuyaSmartConnectorConjector>();
    } else if (vendorName == VendorsAndServices.sonoffDiy.toString()) {
      return getIt<SonoffDiyConnectorConjector>();
    } else if (vendorName == VendorsAndServices.google.toString()) {
      return getIt<GoogleConnectorConjector>();
    } else if (vendorName ==
        VendorsAndServices.cbjDeviceSmartEntity.toString()) {
      return getIt<CbjDevicesConnectorConjector>();
    } else if (vendorName == VendorsAndServices.shelly.toString()) {
      return getIt<ShellyConnectorConjector>();
    } else if (vendorName == VendorsAndServices.hp.toString()) {
      return getIt<HpConnectorConjector>();
    } else if (vendorName == VendorsAndServices.miHome.toString()) {
      return getIt<XiaomiIoConnectorConjector>();
    } else if (vendorName == VendorsAndServices.tasmota.toString()) {
      return getIt<TasmotaIpConnectorConjector>();
    } else if (vendorName == VendorsAndServices.sonoffEweLink.toString()) {
      return getIt<EwelinkConnectorConjector>();
    }

    logger.w(
      'Please add vendor to support string $vendorName to connector conjector',
    );

    return null;
  }
}
