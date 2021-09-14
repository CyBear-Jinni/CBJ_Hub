import 'package:cbj_hub/application/connector/connector.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/mqtt_server/i_mqtt_server_repository.dart';
import 'package:cbj_hub/infrastructure/generic_devices/abstract_device/device_entity_dto_abstract.dart';
import 'package:injectable/injectable.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:mqtt_client/src/observable/src/records.dart';
import 'package:cbj_hub/utils.dart';

@LazySingleton(as: IMqttServerRepository)
class MqttServerRepository extends IMqttServerRepository {
  MqttServerRepository() {
    connect();
  }

  /// Static instance of connection to mqtt broker
  static MqttServerClient client = MqttServerClient('127.0.0.1', 'CBJ_Hub');

  String hubBaseTopic = 'CBJ_Hub_Topic';
  String devicesTopicTypeName = 'Devices';

  /// Connect the client to mqtt if not in connecting or connected state already
  @override
  Future<MqttServerClient> connect() async {
    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      return client;
    } else if (client.connectionStatus!.state ==
        MqttConnectionState.connecting) {
      await Future.delayed(const Duration(seconds: 1));
      return client;
    } else {
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
        .withWillTopic('willtopic')
        .withWillMessage('Will message')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);

    print('Client connecting');
    client.connectionMessage = connMessage;
    try {
      await client.connect();
    } catch (e) {
      logger.e('Error: $e');
      client.disconnect();
    }
    client.subscribe('#', MqttQos.atLeastOnce);
    return client;
  }

  @override
  Future<void> subscribeToTopic(String topic) async {
    await connect();
    client.subscribe(topic, MqttQos.atLeastOnce);
  }

  @override
  Stream<List<MqttReceivedMessage<MqttMessage?>>>
      streamOfAllSubscriptions() async* {
    await connect();
    yield* MqttClientTopicFilter('#', client.updates).updates;
  }

  @override
  Stream<List<MqttReceivedMessage<MqttMessage?>>>
      streamOfAllHubSubscriptions() async* {
    await connect();

    yield* MqttClientTopicFilter('$hubBaseTopic/#', client.updates).updates;
  }

  @override
  Stream<List<MqttReceivedMessage<MqttMessage?>>>
      streamOfAllDevicesHubSubscriptions() async* {
    await connect();
    yield* MqttClientTopicFilter(
            '$hubBaseTopic/$devicesTopicTypeName/#', client.updates)
        .updates;
  }

  @override
  Stream<List<MqttReceivedMessage<MqttMessage?>>> streamOfChosenSubscription(
      String topicPath) async* {
    await connect();
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

      Connector.updateDevicesFromMqttDeviceChange(MapEntry(deviceId,
          {deviceDeviceTypeThatChanged: mqttPublishMessage[0].payload}));
    });
  }

  @override
  Future<void> publishMessage(String topic, String message) async {
    await connect();
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    client.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
  }

  @override
  Future<void> publishDeviceEntity(DeviceEntityAbstract deviceEntity) async {
    final DeviceEntityDtoAbstract deviceAsDto = deviceEntity.toInfrastructure();

    final Map<String, String> devicePropertiesAsMqttTopicsAndValues =
        deviceEntityPropertiesToListOfTopicAndValue(deviceAsDto);

    for (final String propertyTopicAndMassage
        in devicePropertiesAsMqttTopicsAndValues.keys) {
      final MapEntry<String, String> deviceTopicAndProperty =
          MapEntry<String, String>(propertyTopicAndMassage,
              devicePropertiesAsMqttTopicsAndValues[propertyTopicAndMassage]!);
      publishMessage(deviceTopicAndProperty.key, deviceTopicAndProperty.value);
    }
  }

  @override
  Future<List<ChangeRecord>?> readingFromMqttOnce(String topic) async {
    await connect();

    final MqttClientTopicFilter mqttClientTopic =
        MqttClientTopicFilter(topic, client.updates);
    final Stream<List<MqttReceivedMessage<MqttMessage?>>> myValueStream =
        mqttClientTopic.updates.asBroadcastStream();

    // myValueStream.listen((event) {
    //   print(event);
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
    print('Connected');
  }

  /// Unconnected
  void onDisconnected() {
    print('Disconnected');
  }

  /// subscribe to topic succeeded
  void onSubscribed(String topic) {
    print('Subscribed topic: $topic');
  }

  /// subscribe to topic failed
  void onSubscribeFail(String topic) {
    print('Failed to subscribe $topic');
  }

  /// unsubscribe succeeded
  void onUnsubscribed(String? topic) {
    print('Unsubscribed topic: $topic');
  }

  /// PING response received
  void pong() {
    print('Ping response client callback invoked');
  }

  /// Convert device entity properties to mqtt topic and massage
  Map<String, String> deviceEntityPropertiesToListOfTopicAndValue(
      DeviceEntityDtoAbstract deviceEntity) {
    final Map<String, dynamic> json = deviceEntity.toJson();
    final String deviceId = json['id'].toString();

    final Map<String, String> topicsAndProperties = <String, String>{};

    for (final String devicePropertyKey in json.keys) {
      if (devicePropertyKey == 'id') {
        continue;
      }
      final MapEntry<String, String> topicAndProperty = MapEntry<String,
              String>(
          '$hubBaseTopic/$devicesTopicTypeName/$deviceId/$devicePropertyKey',
          json[devicePropertyKey].toString());
      topicsAndProperties.addEntries([topicAndProperty]);
    }

    return topicsAndProperties;
  }

  /// Get saved device dto from mqtt by device id
  Future<DeviceEntityDtoAbstract> getDeviceDtoFromMqtt(String deviceId,
      {String? deviceComponentKey}) async {
    String pathToDeviceTopic = '$hubBaseTopic/$devicesTopicTypeName/$deviceId';

    if (deviceComponentKey != null) {
      pathToDeviceTopic += '/$deviceComponentKey';
    }
    final List<ChangeRecord>? a =
        await readingFromMqttOnce('$pathToDeviceTopic/type');
    print('This is a $a');
    return DeviceEntityDtoAbstract();
  }
}
