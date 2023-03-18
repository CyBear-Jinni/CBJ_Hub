import 'package:cbj_hub/utils.dart';
import 'package:http/http.dart';
import 'package:uuid/uuid.dart';

/// Admin API methods for Node-RED
/// https://nodered.org/docs/api/admin/methods/
class NodeRedAPI {
  /// Creates the request url for Nod-RED, use default connection values
  /// if not specified otherwise
  NodeRedAPI({
    this.address = '127.0.0.1',
    this.port = 1880,
  }) {
    requestsUrl = 'http://$address:$port';
  }

  /// The address of Node-RED to connect to
  String address;

  /// The port to connect to of Node-RED
  int port;

  /// Requests url to Node-RED, contains the address followed up with the port
  late String requestsUrl;

  /// Get the active authentication scheme
  Future<Response> getAuthLogin() async {
    return get(Uri.parse('$requestsUrl/auth/login'));
  }

  /// Exchange credentials for access token
  Future<Response> postAuthToken({
    required String grantType,
    required String scope,
    required String userName,
    required String password,
    String clientId = 'node-red-editor',
  }) async {
    logger.e('postAuthToken Not tested yet');
    final String jsonStringWithFields = '''
    {
      "client_id": "$clientId",
      "grant_type": "$grantType",
      "scope": "$scope",    
      "username": "$userName",    
      "password": "$password"    
    }
    ''';
    return post(
      Uri.parse('$requestsUrl/auth/token'),
      headers: {'Content-Type': 'application/json'},
      body: jsonStringWithFields,
    );
  }

  /// Revoke an access token
  Future<Response> postAuthRevoke(String token) async {
    logger.e('postAuthRevoke Not tested yet');
    return post(
      Uri.parse('$requestsUrl/auth/revoke'),
      headers: {'Content-Type': 'application/json'},
      body: token,
    );
  }

  /// Get the runtime settings
  Future<Response> getSettings() async {
    return get(Uri.parse('$requestsUrl/settings'));
  }

  /// Get the active flow configuration
  Future<Response> getFlows() async {
    return get(Uri.parse('$requestsUrl/flows'));
  }

  /// Set the active flow configuration.
  Future<Response> postFlows({
    required String type,
    required String id,
    required String label,
    int vType = 1,
    String? rev,
  }) async {
    logger.e('postFlows Not tested yet');

    final String jsonStringWithFields;

    if (vType == 1) {
      jsonStringWithFields = '''
      [
        {
          "type": "$type",
          "id": "$id",
          "label": "$label"
        }
      ]
      ''';
    } else if (vType == 2 && rev != null) {
      jsonStringWithFields = '''
      {
        "rev": "$rev",
        "flows": [
          {
            "type": "$type",
            "id": "$id",
            "label": "$label"
          }
        ]
      }
      ''';
    } else {
      logger.e('vType is invalid or rev is missing $rev');
      throw 'Error vType is invalid or rev is missing $rev';
    }
    return post(
      Uri.parse('$requestsUrl/flows'),
      headers: {'Content-Type': 'application/json'},
      body: jsonStringWithFields,
    );
  }

  // TODO: not working
  /// Add a single global node
  Future<Response> postGlobalNode({
    /// Should be node json string {}
    required String nodes,
  }) async {
    final String jsonStringWithFields = '''
      {
        "id": "global",
        "configs": [ ],
        "subflows": $nodes
      }
      ''';
    return put(
      Uri.parse('$requestsUrl/flow/global'),
      headers: {'Content-Type': 'application/json'},
      body: jsonStringWithFields,
    );
  }

  /// Add a flow to the active configuration
  Future<Response> postFlow({
    required String label,

    /// Should start as list of jsons [{},{}]
    required String nodes,

    /// Flow id will get ignored when creating new flow as mentioned in the doc
    /// TODO: check if flow id stopped getting ignored https://discourse.nodered.org/t/make-setting-an-id-in-post-flow-work/67815
    String? flowId,
    List<dynamic>? configs,
  }) async {
    final String idOfTheFlow = flowId ?? const Uuid().v1();
    final List<dynamic> configsList = configs ?? [];

    final String jsonStringWithFields = '''
      {
        "id": "$idOfTheFlow",
        "label": "$label",
        "nodes": $nodes,
        "configs": $configsList
      }
      ''';
    return post(
      Uri.parse('$requestsUrl/flow'),
      headers: {'Content-Type': 'application/json'},
      body: jsonStringWithFields,
    );
  }

  /// Get an individual flow configuration
  Future<Response> getFlowById(String flowId) async {
    return get(Uri.parse('$requestsUrl/flow/$flowId'));
  }

  /// Update an individual flow configuration
  Future<Response> putFlowById({
    required String flowId,
    required String nodes,
    List<dynamic>? configs,
    bool normalFlow = true,
    String? label,
    List<dynamic>? subFlows,
  }) async {
    final List<dynamic> configsList = configs ?? [];

    logger.e('putFlowById Not tested yet');
    final String jsonStringWithFields;

    if (normalFlow) {
      jsonStringWithFields = '''
        {
          "id": "$flowId",
          "label": "$label",
          "nodes": $nodes,
          "configs": $configsList
        }
        ''';
    } else {
      jsonStringWithFields = '''
        {
          "id": "$flowId",
          "configs": $configsList,
          "subflows": $subFlows
        }
        ''';
    }

    return put(
      Uri.parse('$requestsUrl/flow/$flowId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonStringWithFields,
    );
  }

  /// Delete an individual flow configuration
  Future<Response> deleteFlowById({
    required String id,
  }) async {
    return delete(
      Uri.parse('$requestsUrl/flow/$id'),
    );
  }

  /// Get a list of the installed nodes
  Future<Response> getNodes() async {
    return get(Uri.parse('$requestsUrl/nodes'));
  }

  /// Install a new node module
  Future<Response> postNodes({
    required String module,
  }) async {
    final String jsonStringWithFields = '''
    {
      "module": "$module"
    }
    ''';
    return post(
      Uri.parse('$requestsUrl/nodes'),
      headers: {'Content-Type': 'application/json'},
      body: jsonStringWithFields,
    );
  }

  /// Get a node module’s information
  Future<Response> getNodesByModule(String moduleId) async {
    return get(Uri.parse('$requestsUrl/nodes/$moduleId'));
  }

  /// Enable/Disable a node module
  Future<Response> putNodesByModule({
    required String module,
    required bool enableTheModule,
  }) async {
    logger.e('putNodesByModule Not tested yet');
    final String jsonStringWithFields = '''
        {
          "enabled": $enableTheModule
        }
        ''';

    return put(
      Uri.parse('$requestsUrl/nodes/$module'),
      headers: {'Content-Type': 'application/json'},
      body: jsonStringWithFields,
    );
  }

  /// Remove a node module
  Future<Response> deleteNodesByModule({
    required String module,
  }) async {
    logger.e('deleteNodesByModule Not tested yet');
    return delete(
      Uri.parse('$requestsUrl/nodes/$module'),
    );
  }

  /// Get a node module set information
  Future<Response> getNodesByModelSetInformation(
    String moduleId,
    String set,
  ) async {
    return get(Uri.parse('$requestsUrl/nodes/$moduleId/$set'));
  }

  /// Enable/Disable a node set
  Future<Response> putNodesModuleSetInformation({
    required String module,
    required String setName,
    required String enableTheModule,
  }) async {
    logger.e('putNodesModuleSetInformation Not tested yet');
    final String jsonStringWithFields = '''
        {
          "enabled": $enableTheModule
        }
        ''';

    return put(
      Uri.parse('$requestsUrl/nodes/$module/$setName'),
      headers: {'Content-Type': 'application/json'},
      body: jsonStringWithFields,
    );
  }
}
