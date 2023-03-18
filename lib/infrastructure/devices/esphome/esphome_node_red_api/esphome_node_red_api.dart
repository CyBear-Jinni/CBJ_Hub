import 'package:cbj_hub/domain/core/value_objects.dart';
import 'package:cbj_hub/domain/mqtt_server/i_mqtt_server_repository.dart';
import 'package:cbj_hub/domain/node_red/i_node_red_repository.dart';
import 'package:cbj_hub/infrastructure/node_red/node_red_nodes/contrib_esphome_nodes/node_red_esphome_device_node.dart';
import 'package:cbj_hub/infrastructure/node_red/node_red_nodes/contrib_esphome_nodes/node_red_esphome_in_node.dart';
import 'package:cbj_hub/infrastructure/node_red/node_red_nodes/contrib_esphome_nodes/node_red_esphome_out_node.dart';
import 'package:cbj_hub/infrastructure/node_red/node_red_nodes/node_red_function_node.dart';
import 'package:cbj_hub/infrastructure/node_red/node_red_nodes/node_red_mqtt_broker_node.dart';
import 'package:cbj_hub/infrastructure/node_red/node_red_nodes/node_red_mqtt_in_node.dart';
import 'package:cbj_hub/infrastructure/node_red/node_red_nodes/node_red_mqtt_out_node.dart';
import 'package:cbj_hub/injection.dart';
import 'package:cbj_hub/utils.dart';

class EspHomeNodeRedApi {
  static String module = 'node-red-contrib-esphome';

  static String deviceStateProperty = 'deviceStateProperty';
  static String inputDeviceProperty = 'inputDeviceProperty';
  static String outputDeviceProperty = 'outputDeviceProperty';

  // Returns the espHome device node id
  static Future<void> setNewGlobalEspHomeDeviceNode({
    required String deviceMdnsName,
    required String password,
    String? espHomeDeviceId,
  }) async {
    String nodes = '[\n';

    final String espHomeDeviceIdTemp =
        espHomeDeviceId ?? UniqueId().getOrCrash();

    /// Device connection
    final NodeRedEspHomeDeviceNode nodeRedEspHomeDeviceNode =
        NodeRedEspHomeDeviceNode(
      tempId: espHomeDeviceIdTemp,
      host: '$deviceMdnsName.local',
      name: 'ESPHome $deviceMdnsName device id $espHomeDeviceIdTemp',
      password: password,
    );
    nodes += nodeRedEspHomeDeviceNode.toString();

    nodes += '\n]';

    /// Setting the flow
    final String response = await getIt<INodeRedRepository>().setGlobalNodes(
      moduleToUse: module,
      nodes: nodes,
    );
    if (response != 'ok') {
      logger.e('Error setting ESPHome device node\n$response');
    }
  }

  static Future<String> setNewStateNodes({
    required String flowId,
    required String entityId,
    required String espHomeDeviceId,
  }) async {
    String nodes = '[\n';

    final String nodeRedApiBaseTopic =
        getIt<IMqttServerRepository>().getNodeRedApiBaseTopic();

    final String nodeRedDevicesTopic =
        getIt<IMqttServerRepository>().getNodeRedDevicesTopicTypeName();

    const String mqttNodeName = 'Esphome';

    final String topic =
        '$nodeRedApiBaseTopic/$nodeRedDevicesTopic/$entityId/$deviceStateProperty';

    /// Mqtt broker
    final NodeRedMqttBrokerNode mqttBrokerNode =
        NodeRedMqttBrokerNode(name: 'Cbj NodeRed plugs Api Broker');

    nodes += mqttBrokerNode.toString();

    /// Mqtt out

    final NodeRedMqttOutNode mqttOutNode = NodeRedMqttOutNode(
      brokerNodeId: mqttBrokerNode.id,
      topic: '$topic/$outputDeviceProperty',
      name: '$mqttNodeName - $outputDeviceProperty',
    );
    nodes += ', ${mqttOutNode.toString()}';

    /// Create an EspHome in node
    final NodeRedEspHomeInNode nodeRedEspHomeInNode = NodeRedEspHomeInNode(
      wires: [
        [
          mqttOutNode.id,
        ]
      ],
      espHomeNodeDeviceId: espHomeDeviceId,
      name: 'ESPHome $entityId in type',
      epsHomeDeviceEntityId: entityId,
    );
    nodes += ', ${nodeRedEspHomeInNode.toString()}';

    /// Create an EspHome out node
    final NodeRedEspHomeOutNode nodeRedEspHomeOutNode = NodeRedEspHomeOutNode(
      wires: [[]],
      espHomeNodeDeviceId: espHomeDeviceId,
      name: 'ESPHome $entityId out type',
      espHomeEntityId: entityId,
    );
    nodes += ', ${nodeRedEspHomeOutNode.toString()}';

    final NodeRedFunctionNode nodeRedFunctionToJsonNode =
        NodeRedFunctionNode.inputPayloadToJson(
      wires: [
        [
          nodeRedEspHomeOutNode.id,
        ]
      ],
    );
    nodes += ', ${nodeRedFunctionToJsonNode.toString()}';

    /// Mqtt in
    final NodeRedMqttInNode nodeRedMqttInNode = NodeRedMqttInNode(
      name: '$mqttNodeName - $inputDeviceProperty',
      brokerNodeId: mqttBrokerNode.id,
      topic: '$topic/$inputDeviceProperty',
      wires: [
        [
          nodeRedFunctionToJsonNode.id,
        ]
      ],
    );
    nodes += ', ${nodeRedMqttInNode.toString()}';

    nodes += '\n]';

    /// Setting the flow
    final Future<String> settingTheFlowResponse =
        getIt<INodeRedRepository>().setFlowWithModule(
      label: 'Setting device $entityId',
      moduleToUse: module,
      nodes: nodes,
      flowId: flowId,
    );
    return settingTheFlowResponse;
  }
}
