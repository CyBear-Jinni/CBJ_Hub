import 'package:cbj_hub/infrastructure/node_red/node_red_nodes/node_red_visual_node_abstract.dart';

class NodeRedMqttInNode extends NodeRedVisualNodeAbstract {
  NodeRedMqttInNode({
    required this.brokerNodeId,
    required this.topic,
    super.tempId,
    super.name,
    super.wires,
    this.qos,
    this.datatype,
  }) : super(
          type: 'mqtt in',
        );

  /// Mqtt broker node id
  String brokerNodeId;
  String topic;
  String? qos = '2';
  String? datatype = 'auto';

  @override
  String toString() {
    return '''
    {
    "id": "$id",
    "type": "$type",
    "name": "$name",
    "topic": "$topic",
    "qos": "$qos",
    "x": 600,
    "y": 400,
    "datatype": "$datatype",
    "broker": "$brokerNodeId",
    "wires":  ${fixWiresForNodeRed()}
  }''';
  }
}
