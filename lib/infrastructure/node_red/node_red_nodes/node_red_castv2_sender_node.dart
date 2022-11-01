import 'package:cbj_hub/infrastructure/node_red/node_red_nodes/node_red_visual_node_abstract.dart';

/// Class for Node-Red castv2 node
/// https://nodered.org/docs/user-guide/writing-castv2s
class NodeRedCastV2SenderNode extends NodeRedVisualNodeAbstract {
  NodeRedCastV2SenderNode({
    required this.connectionId,
    super.wires,
    super.name,
  }) : super(
          type: 'castv2-sender',
        );

  /// Take action and pass it down as property for the next node
  factory NodeRedCastV2SenderNode.passOnlyNewAction({
    required String connectionId,
    List<List<String>>? wires,
    String? name,
  }) {
    return NodeRedCastV2SenderNode(
      wires: wires,
      name: name,
      connectionId: connectionId,
    );
  }

  String connectionId;

  @override
  String toString() {
    return '''
    {
        "id": "$id",
        "type": "$type",
        "z": "cc525388a451891a",
        "name": "$name",
        "connection": "$connectionId",
        "x": 640,
        "y": 260,
        "wires":  ${fixWiresForNodeRed()}
    }
''';
  }
}
