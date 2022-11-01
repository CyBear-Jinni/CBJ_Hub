import 'package:cbj_hub/infrastructure/node_red/node_red_nodes/node_red_visual_node_abstract.dart';

/// Class for Node-Red castv2 node
/// https://nodered.org/docs/user-guide/writing-castv2s
class NodeRedCastV2ConnectionNode extends NodeRedVisualNodeAbstract {
  NodeRedCastV2ConnectionNode({
    required this.host,
    super.wires,
    super.name,
  }) : super(
          type: 'castv2-connection',
        );

  /// Take action and pass it down as property for the next node
  factory NodeRedCastV2ConnectionNode.passOnlyNewAction({
    List<List<String>>? wires,
    String? name,
    required String host,
  }) {
    return NodeRedCastV2ConnectionNode(
      wires: wires,
      name: name,
      host: host,
    );
  }

  String host;

  @override
  String toString() {
    return '''
    {
      "id": "$id",
      "type": "$type",
      "name": "$name",
      "target": "",
      "host": "$host",
      "port": "8009"
    }
''';
  }
}
