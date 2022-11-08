import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:mqtt_client/src/observable/src/records.dart';

abstract class IMqttServerRepository {
  // static const String hubBaseTopic = 'CBJ_Hub_Topic';
  //
  // static const String devicesTopicTypeName = 'Devices';

  String getHubBaseTopic();

  String getNodeRedApiBaseTopic();

  String getDevicesTopicTypeName();

  String getNodeRedDevicesTopicTypeName();

  String getScenesTopicTypeName();

  String getRoutinesTopicTypeName();

  String getBindingsTopicTypeName();

  /// Connecting the hub client to broker
  Future<MqttServerClient> connect();

  /// Make sure that mqtt is connected state before continuing
  Future<void> asyncConstractor();

  /// Stream all subscription changes
  Stream<List<MqttReceivedMessage<MqttMessage?>>> streamOfAllSubscriptions();

  /// Stream all hub subscription changes
  Stream<List<MqttReceivedMessage<MqttMessage?>>> streamOfAllHubSubscriptions();

  /// Stream all devices subscription changes
  Stream<List<MqttReceivedMessage<MqttMessage?>>>
      streamOfAllDevicesHubSubscriptions();

  /// Stream of chosen topic, example tasmota discover new devices topic
  Stream<List<MqttReceivedMessage<MqttMessage?>>> streamOfChosenSubscription(
    String topicPath,
  );

  /// Get hub subscription and for each device change it will call method to
  /// notify the needed devices
  Future<void> allHubDevicesSubscriptions();

  /// Publish message to a specific topic
  Future<void> publishMessage(String topic, String message);

  /// Publish all device properties
  Future<void> publishDeviceEntity(
    DeviceEntityAbstract deviceEntityDtoAbstract,
  );

  /// Read mqtt last massage in given topic
  Future<List<ChangeRecord>?> readingFromMqttOnce(String topic);

  /// Subscribe to changes in given topic
  Future<void> subscribeToTopic(String topic);

  /// Post object to mqtt correctly, right path and right way to post each type
  Future<void> postToMqtt({
    required dynamic entityFromTheApp,
    bool? gotFromApp,
  });
}
