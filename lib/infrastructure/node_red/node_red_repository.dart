import 'dart:convert';

import 'package:cbj_hub/domain/binding/binding_cbj_entity.dart';
import 'package:cbj_hub/domain/node_red/i_node_red_repository.dart';
import 'package:cbj_hub/domain/routine/routine_cbj_entity.dart';
import 'package:cbj_hub/domain/scene/scene_cbj_entity.dart';
import 'package:cbj_hub/infrastructure/node_red/node_red_api/node_red_api.dart';
import 'package:cbj_hub/utils.dart';
import 'package:http/src/response.dart';
import 'package:injectable/injectable.dart';

/// Control Node-RED, create scenes and more
@LazySingleton(as: INodeRedRepository)
class NodeRedRepository extends INodeRedRepository {
  static NodeRedAPI nodeRedApi = NodeRedAPI();

  // /// List of all the scenes JSONs in Node-RED
  // List<String> scenesList = [];
  //
  // /// List of all the routines JSONs in Node-RED
  // List<String> routinesList = [];
  //
  // /// List of all the bindings JSONs in Node-RED
  // List<String> bindingsList = [];

  @override
  Future<String> createNewNodeRedScene(SceneCbjEntity sceneCbj) async {
    // final String flowId = sceneCbj.uniqueId.getOrCrash();

    try {
      if (sceneCbj.nodeRedFlowId.getOrCrash() != null) {
        await nodeRedApi.deleteFlowById(
          id: sceneCbj.nodeRedFlowId.getOrCrash()!,
        );
      }
      final Response response = await nodeRedApi.postFlow(
        label: sceneCbj.name.getOrCrash(),
        nodes: sceneCbj.automationString.getOrCrash()!,
        flowId: sceneCbj.uniqueId.getOrCrash(),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBodyJson =
            json.decode(response.body) as Map<String, dynamic>;
        final String flowId = responseBodyJson["id"] as String;
        return flowId;
      } else if (response.statusCode == 400) {
        logger.w(
          'Scene probably already exist in node red status code\n${response.statusCode}',
        );
      } else {
        logger.e(
          'Error setting scene in node red status code\n${response.statusCode}',
        );
      }
    } catch (e) {
      if (e.toString() ==
          'The remote computer refused the network connection.\r\n') {
        logger.e('Node-RED is not installed');
      } else {
        logger.e('Node-RED create new scene error:\n$e');
      }
    }
    return "";
  }

  @override
  Future<String> createNewNodeRedRoutine(RoutineCbjEntity routineCbj) async {
    // await _deviceIsReadyToSendInternetRequests;
    // final String flowId = routineCbj.uniqueId.getOrCrash();

    try {
      // if (routinesList.contains(routineCbj.uniqueId.getOrCrash())) {
      //   await nodeRedApi.deleteFlowById(id: flowId);
      // }
      final Response response = await nodeRedApi.postFlow(
        label: routineCbj.name.getOrCrash(),
        nodes: routineCbj.automationString.getOrCrash()!,
        flowId: routineCbj.uniqueId.getOrCrash(),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBodyJson =
            json.decode(response.body) as Map<String, dynamic>;
        final String flowId = responseBodyJson["id"] as String;
        return flowId;
      } else if (response.statusCode == 400) {
        logger.w(
          'Routine probably already exist in node red status code\n${response.statusCode}',
        );
      } else {
        logger.e(
          'Error setting routine in node red status code\n${response.statusCode}',
        );
      }
    } catch (e) {
      if (e.toString() ==
          'The remote computer refused the network connection.\r\n') {
        logger.e('Node-RED is not installed');
      } else {
        logger.e('Node-RED create new routine error:\n$e');
      }
    }
    return "";
  }

  @override
  Future<String> createNewNodeRedBinding(BindingCbjEntity bindingCbj) async {
    try {
      // if (bindingsList.contains(bindingCbj.uniqueId.getOrCrash())) {
      //   await nodeRedApi.deleteFlowById(id: flowId);
      // }
      final Response response = await nodeRedApi.postFlow(
        label: bindingCbj.name.getOrCrash(),
        nodes: bindingCbj.automationString.getOrCrash()!,
        flowId: bindingCbj.uniqueId.getOrCrash(),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBodyJson =
            json.decode(response.body) as Map<String, dynamic>;
        final String flowId = responseBodyJson["id"] as String;
        return flowId;
      } else if (response.statusCode == 400) {
        logger.w(
          'Binding probably already exist in node red status code\n${response.statusCode}',
        );
      } else {
        logger.e(
          'Error setting binding in node red status code\n${response.statusCode}',
        );
      }
    } catch (e) {
      if (e.toString() ==
          'The remote computer refused the network connection.\r\n') {
        logger.e('Node-RED is not installed');
      } else {
        logger.e('Node-RED create new Binding error:\n$e');
      }
    }
    return "";
  }

  @override
  Future<String> setFlowWithModule({
    required String moduleToUse,
    required String label,
    required String nodes,
    required String flowId,
  }) async {
    // TODO: check if hub crash when trying to download new node inside node red without internet connection

    try {
      /// Install the new node module
      final Response postNodesResponse =
          await nodeRedApi.postNodes(module: moduleToUse);

      final Response response = await nodeRedApi.postFlow(
        label: label,
        nodes: nodes,
        flowId: flowId,
      );
    } catch (e) {
      if (e.toString() ==
          'The remote computer refused the network connection.\r\n') {
        logger.e('Node-RED is not installed');
      } else {
        logger.e('Node-RED setting flow with module $moduleToUse\n$e');
      }
    }
    return "";
  }
}
