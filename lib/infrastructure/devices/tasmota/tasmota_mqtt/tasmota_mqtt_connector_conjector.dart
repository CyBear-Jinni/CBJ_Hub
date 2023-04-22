import 'dart:async';

import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/generic_light_device/generic_light_entity.dart';
import 'package:cbj_hub/domain/mqtt_server/i_mqtt_server_repository.dart';
import 'package:cbj_hub/infrastructure/devices/companies_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/tasmota/tasmota_mqtt/tasmota_mqtt_helpers.dart';
import 'package:cbj_hub/infrastructure/devices/tasmota/tasmota_mqtt/tasmota_mqtt_led/tasmota_mqtt_led_entity.dart';
import 'package:cbj_hub/infrastructure/generic_devices/abstract_device/abstract_company_connector_conjector.dart';
import 'package:cbj_hub/injection.dart';
import 'package:cbj_hub/utils.dart';
import 'package:injectable/injectable.dart';

@singleton
class TasmotaMqttConnectorConjector
    implements AbstractCompanyConnectorConjector {
  // Future<void> addNewDeviceByHostInfo({
  //   required ActiveHost activeHost,
  // }) async {
  //   String tempMqttTopic = (await activeHost.hostName)!.replaceAll('-', '_');
  //   if (tempMqttTopic.lastIndexOf('_') != -1) {
  //     tempMqttTopic =
  //         tempMqttTopic.substring(0, tempMqttTopic.lastIndexOf('_'));
  //   }
  //   final String tasmotaMqttTopic = tempMqttTopic;
  //
  //   /// Make all tasmotaMqtt devices repost themselves under topic discovery
  //   /// in the MQTT broker
  //   getIt<IMqttServerRepository>()
  //       .publishMessage('cmnd/$tasmotaMqttTopic/SetOption19', '0');
  // }

  @override
  Map<String, DeviceEntityAbstract> companyDevices = {};

  Future<void> discoverNewDevices() async {
    getIt<IMqttServerRepository>()
        .streamOfChosenSubscription('tasmota/discovery/+/config')
        .listen((mqttPublishMessage) async {
      final String messageTopic = mqttPublishMessage[0].topic;

      final List<String> topicsSplitted = messageTopic.split('/');

      final String deviceId = topicsSplitted[2];

      bool deviceExist = false;
      CoreUniqueId? tempCoreUniqueId;

      for (final DeviceEntityAbstract savedDevice in companyDevices.values) {
        if (savedDevice is TasmotaMqttLedEntity &&
            deviceId == savedDevice.entityUniqueId.getOrCrash()) {
          deviceExist = true;
          break;
        } else if (savedDevice is GenericLightDE &&
            deviceId == savedDevice.entityUniqueId.getOrCrash()) {
          /// Device exist as generic and needs to get converted to non generic type for this vendor
          tempCoreUniqueId = savedDevice.uniqueId;
          break;
        } else if (deviceId == savedDevice.entityUniqueId.getOrCrash()) {
          logger.e(
            'Tasmota Mqtt device type supported but implementation is missing here',
          );
          return;
        }
      }
      if (deviceExist) {
        return;
      }

      final DeviceEntityAbstract? addDevice =
          TasmotaMqttHelpers.addDiscoverdDevice(
        deviceChangeFromMqtt:
            MapEntry(messageTopic, mqttPublishMessage[0].payload),
        uniqueDeviceId: tempCoreUniqueId,
      );

      if (addDevice == null) {
        return;
      }

      final DeviceEntityAbstract deviceToAdd =
          CompaniesConnectorConjector.addDiscoverdDeviceToHub(addDevice);

      final MapEntry<String, DeviceEntityAbstract> deviceAsEntry =
          MapEntry(deviceToAdd.uniqueId.getOrCrash(), deviceToAdd);

      companyDevices.addEntries([deviceAsEntry]);
      logger.v('Adding Tasmota mqtt device');
    });
  }

  @override
  Future<void> manageHubRequestsForDevice(
    DeviceEntityAbstract tasmotaMqttDE,
  ) async {
    final DeviceEntityAbstract? device =
        companyDevices[tasmotaMqttDE.entityUniqueId.getOrCrash()];

    if (device is TasmotaMqttLedEntity) {
      device.executeDeviceAction(newEntity: tasmotaMqttDE);
    } else {
      logger.w('TasmotaMqtt device type does not exist');
    }
  }

  @override
  Future<void> setUpDeviceFromDb(DeviceEntityAbstract deviceEntity) async {}
}
