import 'dart:async';
import 'dart:convert';

import 'package:cbj_hub/domain/app_communication/i_app_communication_repository.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/mqtt_server/i_mqtt_server_repository.dart';
import 'package:cbj_hub/domain/room/room_entity.dart';
import 'package:cbj_hub/domain/saved_devices/i_saved_devices_repo.dart';
import 'package:cbj_hub/infrastructure/devices/companies_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/generic_devices/abstract_device/device_entity_dto_abstract.dart';
import 'package:cbj_hub/injection.dart';
import 'package:cbj_hub/utils.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:rxdart/rxdart.dart';

class Connector {
  static Future<void> startConnector() async {
    ConnectorStreamToMqtt.toMqttStream.listen((entityForMqtt) async {
      if (entityForMqtt.value is DeviceEntityAbstract) {
        await getIt<IMqttServerRepository>()
            .publishDeviceEntity(entityForMqtt.value as DeviceEntityAbstract);
      } else if (entityForMqtt.value is RoomEntity) {
        // TODO: Create MQTT support for rooms
        logger.w('Please create MQTT support for Room Entity');
      } else {
        logger.w('Entity type to send to MQTT is not supported');
      }
    });

    final ISavedDevicesRepo savedDevicesRepo = getIt<ISavedDevicesRepo>();

    final Map<String, DeviceEntityAbstract> allDevices =
        await savedDevicesRepo.getAllDevices();

    for (final String deviceId in allDevices.keys) {
      ConnectorStreamToMqtt.toMqttController.add(
        allDevices.entries.firstWhere(
          (MapEntry<String, DeviceEntityAbstract> a) => a.key == deviceId,
        ),
      );
    }

    Future.delayed(const Duration(milliseconds: 3000)).whenComplete(() {
      final IAppCommunicationRepository appCommunication =
          getIt<IAppCommunicationRepository>();
    });

    getIt<IMqttServerRepository>().allHubDevicesSubscriptions();
    // appCommunication.sendToApp();

    CompaniesConnectorConjector.updateAllDevicesReposWithDeviceChanges(
      ConnectorDevicesStreamFromMqtt.fromMqttStream,
    );

    ConnectorDevicesStreamFromMqtt.fromMqttStream.listen((deviceFromMqtt) {
      savedDevicesRepo.addOrUpdateFromMqtt(deviceFromMqtt);
    });
  }

  static Future<void> updateDevicesFromMqttDeviceChange(
    MapEntry<String, Map<String, dynamic>> deviceChangeFromMqtt,
  ) async {
    final ISavedDevicesRepo savedDevicesRepo = getIt<ISavedDevicesRepo>();

    final Map<String, DeviceEntityAbstract> allDevices =
        await savedDevicesRepo.getAllDevices();

    final Map<String, dynamic> devicePropertyAndValues =
        deviceChangeFromMqtt.value;

    for (final DeviceEntityAbstract d in allDevices.values) {
      if (d.getDeviceId() == deviceChangeFromMqtt.key) {
        final Map<String, dynamic> deviceAsJson = d.toInfrastructure().toJson();

        for (final String property in devicePropertyAndValues.keys) {
          final String pt = MqttPublishPayload.bytesToStringAsString(
            (devicePropertyAndValues[property] as MqttPublishMessage)
                .payload
                .message,
          ).replaceAll('\n', '');

          final valueMessage =
              (devicePropertyAndValues[property] as MqttPublishMessage)
                  .payload
                  .message;
          final String propertyValueString =
              utf8.decode(valueMessage, allowMalformed: true);

          if (propertyValueString.contains('value')) {
            final Map<String, dynamic> propertyValueJson =
                jsonDecode(propertyValueString) as Map<String, dynamic>;
            deviceAsJson[property] = propertyValueJson['value'];
          } else {
            deviceAsJson[property] = propertyValueString;
          }
          final DeviceEntityAbstract savedDeviceWithSameIdAsMqtt =
              DeviceEntityDtoAbstract.fromJson(deviceAsJson).toDomain();

          ConnectorDevicesStreamFromMqtt.fromMqttStream.sink
              .add(savedDeviceWithSameIdAsMqtt);
          return;
        }
      }
    }
  }
}

/// Connect all streams from the internet devices into one stream that will be
/// send to mqtt broker to update devices states
class ConnectorStreamToMqtt {
  static StreamController<MapEntry<String, dynamic>> toMqttController =
      StreamController();

  static Stream<MapEntry<String, dynamic>> get toMqttStream =>
      toMqttController.stream.asBroadcastStream();
}

/// Connect all streams from the mqtt devices changes into one stream that will
/// be sent to whoever need to be notify of changes
class ConnectorDevicesStreamFromMqtt {
  static BehaviorSubject<dynamic> fromMqttStream = BehaviorSubject<dynamic>();
}
