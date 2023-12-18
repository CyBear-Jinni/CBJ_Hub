import 'dart:convert';

import 'package:cbj_hub/utils.dart';
import 'package:cbj_integrations_controller/domain/connector.dart';
import 'package:cbj_integrations_controller/domain/i_mqtt_server_repository.dart';
import 'package:cbj_integrations_controller/domain/i_saved_devices_repo.dart';
import 'package:cbj_integrations_controller/infrastructure/generic_entities/abstract_entity/device_entity_base.dart';
import 'package:cbj_integrations_controller/infrastructure/generic_entities/abstract_entity/device_entity_dto_base.dart';
import 'package:cbj_integrations_controller/infrastructure/generic_entities/abstract_entity/value_objects_core.dart';
import 'package:cbj_integrations_controller/infrastructure/generic_entities/generic_blinds_entity/generic_blinds_entity.dart';
import 'package:cbj_integrations_controller/infrastructure/generic_entities/generic_boiler_entity/generic_boiler_entity.dart';
import 'package:cbj_integrations_controller/infrastructure/generic_entities/generic_dimmable_light_entity/generic_dimmable_light_entity.dart';
import 'package:cbj_integrations_controller/infrastructure/generic_entities/generic_light_entity/generic_light_entity.dart';
import 'package:cbj_integrations_controller/infrastructure/generic_entities/generic_rgbw_light_entity/generic_rgbw_light_entity.dart';
import 'package:cbj_integrations_controller/infrastructure/generic_entities/generic_smart_computer_entity/generic_smart_computer_entity.dart';
import 'package:cbj_integrations_controller/infrastructure/generic_entities/generic_smart_plug_entity/generic_smart_plug_entity.dart';
import 'package:cbj_integrations_controller/infrastructure/generic_entities/generic_smart_tv_entity/generic_smart_tv_entity.dart';
import 'package:cbj_integrations_controller/infrastructure/generic_entities/generic_switch_entity/generic_switch_entity.dart';
import 'package:cbj_integrations_controller/infrastructure/hub_client/hub_client.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
// ignore: implementation_imports
import 'package:mqtt_client/src/observable/src/records.dart';

class MqttServerRepository extends IMqttServerRepository {
  MqttServerRepository() {
    IMqttServerRepository.instance = this;
  }

  /// Static instance of connection to mqtt broker
  static MqttServerClient client = MqttServerClient('127.0.0.1', 'CBJ_Hub');

  static const String hubBaseTopic = 'CBJ_Hub_Topic';

  static const String appBaseTopic = 'CBJ_App_Topic';

  static const String nodeRedApiBaseTopic = 'NodeRed_Api_Topic';

  static const String devicesTopicTypeName = 'Devices';

  static const String nodeRedDevicesTopic = 'Node_Red_Devices';

  static const String scenesTopicTypeName = 'Scenes';

  static const String routinesTopicTypeName = 'Routines';

  static const String bindingsTopicTypeName = 'Bindings';

  static Future<MqttServerClient>? clientFuture;

  @override
  Future<void> asyncConstructor() async {
    clientFuture = connect();
    await clientFuture;
  }

  @override
  String getHubBaseTopic() {
    return hubBaseTopic;
  }

  @override
  String getNodeRedApiBaseTopic() {
    return nodeRedApiBaseTopic;
  }

  @override
  String getDevicesTopicTypeName() {
    return devicesTopicTypeName;
  }

  @override
  String getNodeRedDevicesTopicTypeName() {
    return nodeRedDevicesTopic;
  }

  @override
  String getScenesTopicTypeName() {
    return scenesTopicTypeName;
  }

  @override
  String getRoutinesTopicTypeName() {
    return routinesTopicTypeName;
  }

  @override
  String getBindingsTopicTypeName() {
    return bindingsTopicTypeName;
  }

  /// Connect the client to mqtt if not in connecting or connected state already
  @override
  Future<MqttServerClient> connect() async {
    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      return client;
    }
    // else if (client.connectionStatus!.state ==
    //     MqttConnectionState.connecting) {
    //   // await Future.delayed(const Duration(seconds: 1));
    //   // return client;
    // }
    else {
      client.disconnect();
    }

    client.logging(on: false);

    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onUnsubscribed = onUnsubscribed;
    client.onSubscribed = onSubscribed;
    client.onSubscribeFail = onSubscribeFail;
    client.pongCallback = pong;
    client.keepAlivePeriod = 60;

    final connMessage = MqttConnectMessage()
        .withClientIdentifier('Mqtt_MyClientUniqueId')
        .withWillTopic('Will topic')
        .withWillMessage('Will message')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);

    logger.t('Client connecting');
    client.connectionMessage = connMessage;
    try {
      await client.connect();

      client.subscribe('#', MqttQos.atLeastOnce);
    } catch (e) {
      logger.e('Error in mqtt connect\n$e');
      client.disconnect();
    }

    return client;
  }

  @override
  Future<void> subscribeToTopic(String topic) async {
    client.subscribe(topic, MqttQos.atLeastOnce);
  }

  @override
  Stream<List<MqttReceivedMessage<MqttMessage?>>>
      streamOfAllSubscriptions() async* {
    yield* MqttClientTopicFilter('#', client.updates).updates;
  }

  @override
  Stream<List<MqttReceivedMessage<MqttMessage?>>>
      streamOfAllHubSubscriptions() async* {
    yield* MqttClientTopicFilter('$hubBaseTopic/#', client.updates).updates;
  }

  @override
  Stream<List<MqttReceivedMessage<MqttMessage?>>>
      streamOfAllDevicesHubSubscriptions() async* {
    yield* MqttClientTopicFilter(
      '$hubBaseTopic/$devicesTopicTypeName/#',
      client.updates,
    ).updates;
  }

  @override
  Stream<List<MqttReceivedMessage<MqttMessage?>>>
      streamOfAllDeviceAppSubscriptions() async* {
    yield* MqttClientTopicFilter(
      '$appBaseTopic/$devicesTopicTypeName/#',
      client.updates,
    ).updates;
  }

  @override
  Stream<List<MqttReceivedMessage<MqttMessage?>>> streamOfChosenSubscription(
    String topicPath,
  ) async* {
    yield* MqttClientTopicFilter(topicPath, client.updates).updates;
  }

  @override
  Future<void> allHubDevicesSubscriptions() async {
    streamOfAllDevicesHubSubscriptions().listen(
        (List<MqttReceivedMessage<MqttMessage?>> mqttPublishMessage) async {
      final String messageTopic = mqttPublishMessage[0].topic;
      final List<String> topicsSplitted = messageTopic.split('/');
      if (topicsSplitted.length < 4) {
        return;
      }
      final String deviceId = topicsSplitted[2];
      final String deviceDeviceTypeThatChanged = topicsSplitted[3];

      if (deviceDeviceTypeThatChanged == 'getValues') {
        findDeviceAndResendItToMqtt(deviceId);
        return;
      }

      Connector().updateDevicesFromMqttDeviceChange(
        MapEntry(
          deviceId,
          {deviceDeviceTypeThatChanged: mqttPublishMessage[0].payload},
        ),
      );
    });
  }

  @override
  Future<void> sendToApp() async {
    streamOfAllDeviceAppSubscriptions().listen(
        (List<MqttReceivedMessage<MqttMessage?>> mqttPublishMessage) async {
      final String messageTopic = mqttPublishMessage[0].topic;
      final List<String> topicsSplitted = messageTopic.split('/');
      if (topicsSplitted.length < 4) {
        return;
      }
      final String deviceId = topicsSplitted[2];
      final String deviceDeviceTypeThatChanged = topicsSplitted[3];

      final Map<String, dynamic> devicePropertyAndValues = {
        deviceDeviceTypeThatChanged: mqttPublishMessage[0].payload,
      };

      final ISavedDevicesRepo savedDevicesRepo = ISavedDevicesRepo.instance;

      final Map<String, DeviceEntityBase> allDevices =
          savedDevicesRepo.getAllDevices();

      for (final DeviceEntityBase d in allDevices.values) {
        if (d.getDeviceId() == deviceId) {
          final Map<String, dynamic> deviceAsJson =
              d.toInfrastructure().toJson();

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
            final DeviceEntityDtoBase savedDeviceWithSameIdAsMqtt =
                DeviceEntityDtoBase.fromJson(deviceAsJson);

            HubRequestsToApp.streamRequestsToApp.sink
                .add(savedDeviceWithSameIdAsMqtt);
            return;
          }
        }
      }
    });
  }

  @override
  Future<void> publishMessage(String topic, String message) async {
    try {
      final builder = MqttClientPayloadBuilder();
      builder.addUTF8String(message);
      client.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
    } catch (error) {
      logger.e('Error publishing MQTT message\n$error');
    }
  }

  @override
  Future<void> publishDeviceEntity(DeviceEntityBase deviceEntity) async {
    final DeviceEntityDtoBase deviceAsDto = deviceEntity.toInfrastructure();

    final Map<String, String> devicePropertiesAsMqttTopicsAndValues =
        deviceEntityPropertiesToListOfTopicAndValue(deviceAsDto);

    for (final String propertyTopicAndMassage
        in devicePropertiesAsMqttTopicsAndValues.keys) {
      final MapEntry<String, String> deviceTopicAndProperty =
          MapEntry<String, String>(
        propertyTopicAndMassage,
        devicePropertiesAsMqttTopicsAndValues[propertyTopicAndMassage]!,
      );
      publishMessage(deviceTopicAndProperty.key, deviceTopicAndProperty.value);
    }
  }

  @override
  Future<List<ChangeRecord>?> readingFromMqttOnce(String topic) async {
    final MqttClientTopicFilter mqttClientTopic =
        MqttClientTopicFilter(topic, client.updates);
    mqttClientTopic.updates.asBroadcastStream();

    // myValueStream.listen((event) {
    //   logger.t(event);
    // });
    // final List<MqttReceivedMessage<MqttMessage?>> result =
    //     await myValueStream.first;
    return client
        .subscribe('$hubBaseTopic/#', MqttQos.atLeastOnce)!
        .changes
        .last;
  }

  /// Callback function for connection succeeded
  void onConnected() {
    logger.t('Connected');
  }

  /// Unconnected
  void onDisconnected() {
    logger.t('Disconnected');
  }

  /// subscribe to topic succeeded
  void onSubscribed(String topic) {
    logger.t('Subscribed topic: $topic');
  }

  /// subscribe to topic failed
  void onSubscribeFail(String topic) {
    logger.t('Failed to subscribe $topic');
  }

  /// unsubscribe succeeded
  void onUnsubscribed(String? topic) {
    logger.t('Unsubscribed topic: $topic');
  }

  /// PING response received
  void pong() {
    logger.t('Ping response MQTT client callback invoked');
  }

  /// Convert device entity properties to mqtt topic and massage
  Map<String, String> deviceEntityPropertiesToListOfTopicAndValue(
    DeviceEntityDtoBase deviceEntity,
  ) {
    final Map<String, dynamic> json = deviceEntity.toJson();
    final String deviceId = json['id'].toString();

    final Map<String, String> topicsAndProperties = <String, String>{};

    for (final String devicePropertyKey in json.keys) {
      if (devicePropertyKey == 'id') {
        continue;
      }
      final MapEntry<String, String> topicAndProperty =
          MapEntry<String, String>(
        '$hubBaseTopic/$devicesTopicTypeName/$deviceId/$devicePropertyKey',
        json[devicePropertyKey].toString(),
      );
      topicsAndProperties.addEntries([topicAndProperty]);
    }

    return topicsAndProperties;
  }

  /// Get saved device dto from mqtt by device id
  Future<DeviceEntityDtoBase> getDeviceDtoFromMqtt(
    String deviceId, {
    String? deviceComponentKey,
  }) async {
    String pathToDeviceTopic = '$hubBaseTopic/$devicesTopicTypeName/$deviceId';

    if (deviceComponentKey != null) {
      pathToDeviceTopic += '/$deviceComponentKey';
    }
    final List<ChangeRecord>? a =
        await readingFromMqttOnce('$pathToDeviceTopic/type');
    logger.t('This is a $a');
    return DeviceEntityDtoBase();
  }

  /// Resend the device object throw mqtt
  Future<void> findDeviceAndResendItToMqtt(String deviceId) async {
    final ISavedDevicesRepo savedDevicesRepo = ISavedDevicesRepo.instance;

    final Map<String, DeviceEntityBase> allDevices =
        savedDevicesRepo.getAllDevices();

    DeviceEntityBase? deviceObjectOfDeviceId;

    for (final DeviceEntityBase d in allDevices.values) {
      if (d.getDeviceId() == deviceId) {
        deviceObjectOfDeviceId = d;
        break;
      }
    }
    if (deviceObjectOfDeviceId != null) {
      logger.i(
        'getValues got called on Device $deviceId and will get reposted to mqtt',
      );
      postToHubMqtt(entityFromTheApp: deviceObjectOfDeviceId);
    } else {
      logger.w('Device id does not exist');
    }
  }

  @override
  Future<void> postToHubMqtt({
    dynamic entityFromTheApp,
    bool? gotFromApp,
  }) async {
    if (entityFromTheApp is DeviceEntityBase) {
      final Map<String, DeviceEntityBase> allDevices =
          ISavedDevicesRepo.instance.getAllDevices();
      final DeviceEntityBase? savedDeviceEntity =
          allDevices[entityFromTheApp.getDeviceId()];

      if (savedDeviceEntity == null) {
        logger.w('Device id does not match existing device');
        return;
      }

      MapEntry<String, DeviceEntityBase> deviceFromApp;

      if (savedDeviceEntity is GenericLightDE &&
          entityFromTheApp is GenericLightDE) {
        savedDeviceEntity.lightSwitchState = entityFromTheApp.lightSwitchState;

        deviceFromApp = MapEntry(
          savedDeviceEntity.uniqueId.getOrCrash(),
          savedDeviceEntity,
        );
      } else if (savedDeviceEntity is GenericDimmableLightDE &&
          entityFromTheApp is GenericDimmableLightDE) {
        savedDeviceEntity.lightSwitchState = entityFromTheApp.lightSwitchState;
        savedDeviceEntity.lightBrightness = entityFromTheApp.lightBrightness;

        deviceFromApp = MapEntry(
          savedDeviceEntity.uniqueId.getOrCrash(),
          savedDeviceEntity,
        );
      } else if (savedDeviceEntity is GenericRgbwLightDE &&
          entityFromTheApp is GenericRgbwLightDE) {
        savedDeviceEntity.lightSwitchState = entityFromTheApp.lightSwitchState;
        savedDeviceEntity.lightColorSaturation =
            entityFromTheApp.lightColorSaturation;
        savedDeviceEntity.lightColorTemperature =
            entityFromTheApp.lightColorTemperature;
        savedDeviceEntity.lightColorHue = entityFromTheApp.lightColorHue;
        savedDeviceEntity.lightColorAlpha = entityFromTheApp.lightColorAlpha;
        savedDeviceEntity.lightColorValue = entityFromTheApp.lightColorValue;
        savedDeviceEntity.lightBrightness = entityFromTheApp.lightBrightness;

        deviceFromApp = MapEntry(
          savedDeviceEntity.uniqueId.getOrCrash(),
          savedDeviceEntity,
        );
      } else if (savedDeviceEntity is GenericSwitchDE &&
          entityFromTheApp is GenericSwitchDE) {
        savedDeviceEntity.switchState = entityFromTheApp.switchState;

        deviceFromApp = MapEntry(
          savedDeviceEntity.uniqueId.getOrCrash(),
          savedDeviceEntity,
        );
      } else if (savedDeviceEntity is GenericBoilerDE &&
          entityFromTheApp is GenericBoilerDE) {
        savedDeviceEntity.boilerSwitchState =
            entityFromTheApp.boilerSwitchState;

        deviceFromApp = MapEntry(
          savedDeviceEntity.uniqueId.getOrCrash(),
          savedDeviceEntity,
        );
      } else if (savedDeviceEntity is GenericBlindsDE &&
          entityFromTheApp is GenericBlindsDE) {
        savedDeviceEntity.blindsSwitchState =
            entityFromTheApp.blindsSwitchState;

        deviceFromApp = MapEntry(
          savedDeviceEntity.uniqueId.getOrCrash(),
          savedDeviceEntity,
        );
      } else if (savedDeviceEntity is GenericSmartPlugDE &&
          entityFromTheApp is GenericSmartPlugDE) {
        savedDeviceEntity.smartPlugState = entityFromTheApp.smartPlugState;

        deviceFromApp = MapEntry(
          savedDeviceEntity.uniqueId.getOrCrash(),
          savedDeviceEntity,
        );
      } else if (savedDeviceEntity is GenericSmartComputerDE &&
          entityFromTheApp is GenericSmartComputerDE) {
        savedDeviceEntity.smartComputerSuspendState =
            entityFromTheApp.smartComputerSuspendState;

        savedDeviceEntity.smartComputerShutDownState =
            entityFromTheApp.smartComputerShutDownState;

        deviceFromApp = MapEntry(
          savedDeviceEntity.uniqueId.getOrCrash(),
          savedDeviceEntity,
        );
      } else if (savedDeviceEntity is GenericSmartTvDE &&
          entityFromTheApp is GenericSmartTvDE) {
        savedDeviceEntity.openUrl = entityFromTheApp.openUrl;
        savedDeviceEntity.volume = entityFromTheApp.volume;
        savedDeviceEntity.skip = entityFromTheApp.skip;
        savedDeviceEntity.pausePlayState = entityFromTheApp.pausePlayState;

        deviceFromApp = MapEntry(
          savedDeviceEntity.uniqueId.getOrCrash(),
          savedDeviceEntity,
        );
      } else {
        logger.w(
          'Cant find device from app type '
          '${entityFromTheApp.entityTypes.getOrCrash()}',
        );
        return;
      }
      if (gotFromApp != null && gotFromApp == true) {
        deviceFromApp.value.entityStateGRPC =
            EntityState(entityFromTheApp.entityStateGRPC.getOrCrash());
      }
      Connector().fromMqtt(deviceFromApp);
    } else {
      logger.w(
        'Entity from app type ${entityFromTheApp.runtimeType} not '
        'support sending to MQTT',
      );
    }
  }

  @override
  Future<void> postToAppMqtt({
    required DeviceEntityBase entityFromTheHub,
  }) async {
    // if (entityFromTheHub is Map<String, dynamic>) {
    // if (entityFromTheHub['entityStateGRPC'] !=
    //         EntityStateGRPC.waitingInComp.toString() ||
    //     entityFromTheHub['entityStateGRPC'] !=
    //         EntityStateGRPC.ack.toString()) {
    //   logger.w("Hub didn't confirmed receiving the request yet");
    //   return;
    // }

    final MapEntry<String, dynamic> deviceInMapEntry =
        MapEntry<String, dynamic>(
      entityFromTheHub.uniqueId.getOrCrash(),
      entityFromTheHub,
    );

    Connector().fromMqtt(deviceInMapEntry);

    // } else {
    //   logger.w(
    //     'Entity from Hub type ${entityFromTheHub.runtimeType} not '
    //     'support sending to MQTT for the app',
    //   );
    // }
  }

  @override
  Future<void> postSmartDeviceToAppMqtt({
    required DeviceEntityBase entityFromTheHub,
  }) async {
    postToAppMqtt(entityFromTheHub: entityFromTheHub);
  }
}
