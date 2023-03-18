import 'package:cbj_hub/infrastructure/node_red/node_red_nodes/node_red_visual_node_abstract.dart';

/// Class for Node-Red ESPHome node
/// https://flows.nodered.org/node/node-red-contrib-esphome
class NodeRedEspHomeOutNode extends NodeRedVisualNodeAbstract {
  NodeRedEspHomeOutNode({
    required this.espHomeNodeDeviceId,
    required this.espHomeEntityId,
    super.wires,
    super.name,
  }) : super(
          type: 'esphome-out',
        );

  /// Take esphome-device node id and pass it down as property and set it up, also pass wires to define the next node to connect to
  factory NodeRedEspHomeOutNode.passOnlyNewAction({
    required String espHomeNodeDeviceId,
    required String espHomeEntityId,
    List<List<String>>? wires,
    String? name,
  }) {
    return NodeRedEspHomeOutNode(
      wires: wires,
      name: name,
      espHomeNodeDeviceId: espHomeNodeDeviceId,
      espHomeEntityId: espHomeEntityId,
    );
  }

  String espHomeNodeDeviceId;
  String espHomeEntityId;

  @override
  String toString() {
    return '''
    {
        "id": "$id",
        "type": "$type",
        "z": "cc525388a451891a",
        "name": "$name",
        "device": "$espHomeNodeDeviceId",
        "entity": "$espHomeEntityId",
        "x": 1200,
        "y": 500,
        "wires":  [[]]
    }
''';
  }
}
