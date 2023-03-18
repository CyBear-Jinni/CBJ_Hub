import 'package:cbj_hub/infrastructure/node_red/node_red_nodes/node_red_visual_node_abstract.dart';

class NodeRedEspHomeDeviceNode extends NodeRedVisualNodeAbstract {
  NodeRedEspHomeDeviceNode({
    required this.host,
    required this.password,
    super.tempId,
    super.wires,
    super.name,
  }) : super(
          type: 'esphome-device',
        );

  factory NodeRedEspHomeDeviceNode.passOnlyNewAction({
    required String host,
    required String password,
    List<List<String>>? wires,
    String? name,
    String? tempId,
  }) {
    return NodeRedEspHomeDeviceNode(
      tempId: tempId,
      wires: wires,
      name: name,
      host: host,
      password: password,
    );
  }

  String host;
  String password;

  @override
  String toString() {
    return '''
    {
      "id": "$id",
      "type": "$type",
      "name": "$name",
      "target": "",
      "host": "$host",
      "port": "6053",
      "credentials": {
            "password": "$password"
      }
    }
''';
  }
}
