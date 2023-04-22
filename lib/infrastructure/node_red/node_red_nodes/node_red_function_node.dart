import 'package:cbj_hub/infrastructure/node_red/node_red_nodes/node_red_visual_node_abstract.dart';

/// Class for Node-Red function node
/// https://nodered.org/docs/user-guide/writing-functions
class NodeRedFunctionNode extends NodeRedVisualNodeAbstract {
  NodeRedFunctionNode({
    required this.funcString,
    super.wires,
    super.name,
  }) : super(
          type: 'function',
        );

  /// Take action and pass it down as property for the next node
  factory NodeRedFunctionNode.passOnlyNewAction({
    required String action,
    List<List<String>>? wires,
    String? name,
  }) {
    final String function = '''msg.payload=\\"$action\\"; return msg;''';
    return NodeRedFunctionNode(funcString: function, wires: wires, name: name);
  }

  /// Gets input string and parse the payload as json to the next node
  factory NodeRedFunctionNode.inputPayloadToJson({
    List<List<String>>? wires,
  }) {
    const String function =
        '''msg.payload = JSON.parse(msg.payload); return msg;''';
    return NodeRedFunctionNode(
      funcString: function,
      wires: wires,
      name: 'Input to json',
    );
  }

  String funcString;

  @override
  String toString() {
    return '''
    {
    "id": "$id",
    "type": "$type",
    "name": "$name",
    "func": "$funcString",
    "outputs": 1,
    "noerr": 0,
    "x": 400,
    "y": 1000,
    "initialize": "",
    "finalize": "",
    "wires":  ${fixWiresForNodeRed()}
  }''';
  }
}
