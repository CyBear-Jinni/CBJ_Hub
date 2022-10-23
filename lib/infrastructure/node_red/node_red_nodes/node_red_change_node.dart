import 'package:cbj_hub/infrastructure/node_red/node_red_nodes/node_red_visual_node_abstract.dart';

//TODO: Test that this node works
/// Class for Node-Red change node
/// https://nodered.org/docs/user-guide/nodes#change
class NodeRedFunctionNode extends NodeRedVisualNodeAbstract {
  NodeRedFunctionNode({
    super.wires,
    super.name,
  }) : super(
          type: 'change',
        );

  @override
  String toString() {
    return '''
  {
    "id": "$id",
    "type": "$type",
    "name": "$name",
    "z": "cc525388a451891a",
    "rules": [
        {
            "t": "set",
            "p": "payload",
            "pt": "msg",
            "to": "{"app":"YouTube","type":"MEDIA","videoId":"I9rc23oxvsw"}",
            "tot": "json"
        }
    ],
    "action": "",
    "property": "",
    "from": "",
    "to": "",
    "reg": false,
    "x": 380,
    "y": 260,
    "wires": ${fixWiresForNodeRed()}
  }
''';
  }
}
