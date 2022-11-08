import 'package:cbj_hub/application/connector/connector.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/generic_blinds_device/generic_blinds_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_boiler_device/generic_boiler_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_light_device/generic_light_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_rgbw_light_device/generic_rgbw_light_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_smart_computer_device/generic_smart_computer_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_smart_plug_device/generic_switch_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_smart_tv/generic_smart_tv_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_switch_device/generic_switch_entity.dart';
import 'package:cbj_hub/domain/mqtt_server/i_mqtt_server_repository.dart';
import 'package:cbj_hub/domain/saved_devices/i_saved_devices_repo.dart';
import 'package:cbj_hub/infrastructure/generic_devices/abstract_device/device_entity_dto_abstract.dart';
import 'package:cbj_hub/injection.dart';
import 'package:cbj_hub/utils.dart';
import 'package:injectable/injectable.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:mqtt_client/src/observable/src/records.dart';

@LazySingleton(as: IMqttServerRepository)
class MqttServerRepository extends IMqttServerRepository {
  /// Static instance of connection to mqtt broker
  static MqttServerClient client = MqttServerClient('127.0.0.1', 'CBJ_Hub');

  static const String hubBaseTopic = 'CBJ_Hub_Topic';

  static const String nodeRedApiBaseTopic = 'NodeRed_Api_Topic';

  static const String devicesTopicTypeName = 'Devices';

  static const String nodeRedDevicesTopic = 'Node_Red_Devices';

  static const String scenesTopicTypeName = 'Scenes';

  static const String routinesTopicTypeName = 'Routines';

  static const String bindingsTopicTypeName = 'Bindings';

  static Future<MqttServerClient>? clientFuture;

  static bool clientConnected = false;

  Future<void> asyncConstractor() async {
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

    logger.v('Client connecting');
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

      Connector.updateDevicesFromMqttDeviceChange(
        MapEntry(
          deviceId,
          {deviceDeviceTypeThatChanged: mqttPublishMessage[0].payload},
        ),
      );
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
  Future<void> publishDeviceEntity(DeviceEntityAbstract deviceEntity) async {
    final DeviceEntityDtoAbstract deviceAsDto = deviceEntity.toInfrastructure();

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
    final Stream<List<MqttReceivedMessage<MqttMessage?>>> myValueStream =
        mqttClientTopic.updates.asBroadcastStream();

    // myValueStream.listen((event) {
    //   logger.v(event);
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
    clientConnected = true;
    clientFuture = Future(() => client);
    logger.v('Connected');
  }

  /// Unconnected
  void onDisconnected() {
    logger.v('Disconnected');
  }

  /// subscribe to topic succeeded
  void onSubscribed(String topic) {
    logger.v('Subscribed topic: $topic');
  }

  /// subscribe to topic failed
  void onSubscribeFail(String topic) {
    logger.v('Failed to subscribe $topic');
  }

  /// unsubscribe succeeded
  void onUnsubscribed(String? topic) {
    logger.v('Unsubscribed topic: $topic');
  }

  /// PING response received
  void pong() {
    logger.v('Ping response MQTT client callback invoked');
  }

  /// Convert device entity properties to mqtt topic and massage
  Map<String, String> deviceEntityPropertiesToListOfTopicAndValue(
    DeviceEntityDtoAbstract deviceEntity,
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
  Future<DeviceEntityDtoAbstract> getDeviceDtoFromMqtt(
    String deviceId, {
    String? deviceComponentKey,
  }) async {
    String pathToDeviceTopic = '$hubBaseTopic/$devicesTopicTypeName/$deviceId';

    if (deviceComponentKey != null) {
      pathToDeviceTopic += '/$deviceComponentKey';
    }
    final List<ChangeRecord>? a =
        await readingFromMqttOnce('$pathToDeviceTopic/type');
    logger.v('This is a $a');
    return DeviceEntityDtoAbstract();
  }

  /// Resend the device object throw mqtt
  Future<void> findDeviceAndResendItToMqtt(String deviceId) async {
    final ISavedDevicesRepo savedDevicesRepo = getIt<ISavedDevicesRepo>();

    final Map<String, DeviceEntityAbstract> allDevices =
        await savedDevicesRepo.getAllDevices();

    DeviceEntityAbstract? deviceObjectOfDeviceId;

    for (final DeviceEntityAbstract d in allDevices.values) {
      if (d.getDeviceId() == deviceId) {
        deviceObjectOfDeviceId = d;
        break;
      }
    }
    if (deviceObjectOfDeviceId != null) {
      logger.i(
        'getValues got called on Device $deviceId and will get reposted to mqtt',
      );
      postToMqtt(entityFromTheApp: deviceObjectOfDeviceId);
    } else {
      logger.w('Device id does not exist');
    }
  }

  @override
  Future<void> postToMqtt({
    dynamic entityFromTheApp,
    bool? gotFromApp,
  }) async {
    if (entityFromTheApp is DeviceEntityAbstract) {
      final ISavedDevicesRepo savedDevicesRepo = getIt<ISavedDevicesRepo>();
      final Map<String, DeviceEntityAbstract> allDevices =
          await savedDevicesRepo.getAllDevices();
      final DeviceEntityAbstract? savedDeviceEntity =
          allDevices[entityFromTheApp.getDeviceId()];

      if (savedDeviceEntity == null) {
        logger.w('Device id does not match existing device');
        return;
      }

      MapEntry<String, DeviceEntityAbstract> deviceFromApp;

      if (savedDeviceEntity is GenericLightDE &&
          entityFromTheApp is GenericLightDE) {
        savedDeviceEntity.lightSwitchState = entityFromTheApp.lightSwitchState;

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
          '${entityFromTheApp.deviceTypes.getOrCrash()}',
        );
        return;
      }
      if (gotFromApp != null && gotFromApp == true) {
        deviceFromApp.value.deviceStateGRPC =
            DeviceState(entityFromTheApp.deviceStateGRPC.getOrCrash());
      }

      ConnectorStreamToMqtt.toMqttController.sink.add(deviceFromApp);
    } else {
      logger.w(
        'Entity from app type ${entityFromTheApp.runtimeType} not '
        'support sending to MQTT',
      );
    }
  }
}
