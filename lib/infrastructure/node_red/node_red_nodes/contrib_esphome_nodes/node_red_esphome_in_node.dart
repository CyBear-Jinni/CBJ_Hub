import 'package:cbj_hub/infrastructure/node_red/node_red_nodes/node_red_visual_node_abstract.dart';

/// Class for Node-Red ESPHome node
/// https://flows.nodered.org/node/node-red-contrib-esphome
class NodeRedEspHomeInNode extends NodeRedVisualNodeAbstract {
  NodeRedEspHomeInNode({
    required this.espHomeNodeDeviceId,
    required this.epsHomeDeviceEntityId,
    super.wires,
    super.name,
  }) : super(
          type: 'esphome-in',
        );

  /// Take esphome-device node id and pass it down as property and set it up, also pass wires to define the next node to connect to
  factory NodeRedEspHomeInNode.passOnlyNewAction({
    required String espHomeNodeDeviceId,
    required String epsHomeDeviceEntityId,
    List<List<String>>? wires,
    String? name,
  }) {
    return NodeRedEspHomeInNode(
      wires: wires,
      name: name,
      espHomeNodeDeviceId: espHomeNodeDeviceId,
      epsHomeDeviceEntityId: epsHomeDeviceEntityId,
    );
  }

  String espHomeNodeDeviceId;
  String epsHomeDeviceEntityId;

  @override
  String toString() {
    return '''
    {
        "id": "$id",
        "type": "$type",
        "z": "cc525388a451891a",
        "name": "$name",
        "device": "$espHomeNodeDeviceId",
        "entity": "$epsHomeDeviceEntityId",
        "x": 680,
        "y": 500,
        "wires":  ${fixWiresForNodeRed()}
    }
''';
  }
}
