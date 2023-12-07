import 'dart:async';
import 'dart:convert';

import 'package:cbj_hub/infrastructure/app_communication/app_communication_repository.dart';
import 'package:cbj_integrations_controller/domain/mqtt_server/i_mqtt_server_repository.dart';
import 'package:cbj_integrations_controller/domain/room/room_entity.dart';
import 'package:cbj_integrations_controller/domain/room/value_objects_room.dart';
import 'package:cbj_integrations_controller/domain/rooms/i_saved_rooms_repo.dart';
import 'package:cbj_integrations_controller/domain/saved_devices/i_saved_devices_repo.dart';
import 'package:cbj_integrations_controller/infrastructure/devices/companies_connector_conjecture.dart';
import 'package:cbj_integrations_controller/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_integrations_controller/infrastructure/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_integrations_controller/infrastructure/generic_devices/abstract_device/device_entity_dto_abstract.dart';
import 'package:cbj_integrations_controller/infrastructure/hub_client/hub_client.dart';
import 'package:cbj_integrations_controller/utils.dart';
import 'package:mqtt_client/mqtt_client.dart';

class Connector {
  static Future<void> startConnector() async {
    ConnectorStreamToMqtt.toMqttStream.listen((entityForMqtt) async {
      if (entityForMqtt.value is DeviceEntityAbstract) {
        /// Data will probably arrive to the function
        /// updateAllDevicesReposWithDeviceChanges where we listen to request from
        /// the mqtt with this path
        await IMqttServerRepository.instance
            .publishDeviceEntity(entityForMqtt.value as DeviceEntityAbstract);
      } else if (entityForMqtt.value is RoomEntity) {
        // TODO: Create MQTT support for rooms
        logger.w('Please create MQTT support for Room Entity');
      } else {
        logger.w('Entity type to send to MQTT is not supported');
      }
    });

    final ISavedDevicesRepo savedDevicesRepo = ISavedDevicesRepo.instance;

    final Map<String, DeviceEntityAbstract> allDevices =
        await savedDevicesRepo.getAllDevicesAfterInitialize();

    for (final String deviceId in allDevices.keys) {
      ConnectorStreamToMqtt.toMqttController.add(
        allDevices.entries.firstWhere(
          (MapEntry<String, DeviceEntityAbstract> a) => a.key == deviceId,
        ),
      );
    }

    Future.delayed(const Duration(milliseconds: 3000)).whenComplete(() {
      AppCommunicationRepository();
    });

    IMqttServerRepository.instance.allHubDevicesSubscriptions();

    IMqttServerRepository.instance.sendToApp();

    CompaniesConnectorConjecture().updateAllDevicesReposWithDeviceChanges(
      ConnectorDevicesStreamFromMqtt.fromMqttStream,
    );

    ConnectorDevicesStreamFromMqtt.fromMqttStream.listen((deviceFromMqtt) {
      savedDevicesRepo.addOrUpdateFromMqtt(deviceFromMqtt);
    });
  }

  static Future<void> updateDevicesFromMqttDeviceChange(
    MapEntry<String, Map<String, dynamic>> deviceChangeFromMqtt,
  ) async {
    final ISavedDevicesRepo savedDevicesRepo = ISavedDevicesRepo.instance;

    final Map<String, DeviceEntityAbstract> allDevices =
        await savedDevicesRepo.getAllDevices();

    final Map<String, dynamic> devicePropertyAndValues =
        deviceChangeFromMqtt.value;

    // String? deviceStateValue;

    for (final DeviceEntityAbstract d in allDevices.values) {
      if (d.getDeviceId() == deviceChangeFromMqtt.key) {
        final Map<String, dynamic> deviceAsJson = d.toInfrastructure().toJson();

        for (final String property in devicePropertyAndValues.keys) {
          // final String pt =
          MqttPublishPayload.bytesToStringAsString(
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

          if (property == 'entityStateGRPC' &&
              propertyValueString == EntityStateGRPC.ack.toString()) {
            final Map<String, RoomEntity> rooms =
                await ISavedRoomsRepo.instance.getAllRooms();

            HubRequestsToApp.streamRequestsToApp.sink
                .add(savedDeviceWithSameIdAsMqtt.toInfrastructure());
            final RoomEntity? discoverRoom =
                rooms[RoomUniqueId.discoveredRoomId().getOrCrash()];
            if (discoverRoom == null) {
              continue;
            }

            if (discoverRoom.roomDevicesId
                .getOrCrash()
                .contains(savedDeviceWithSameIdAsMqtt.uniqueId.getOrCrash())) {
              HubRequestsToApp.streamRequestsToApp.sink.add(
                rooms[RoomUniqueId.discoveredRoomId().getOrCrash()]!
                    .toInfrastructure(),
              );
            }
          }
          return;
        }
      }
    }
  }
}
