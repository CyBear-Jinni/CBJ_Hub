import 'package:cbj_hub/domain/binding/binding_cbj_entity.dart';
import 'package:cbj_hub/domain/routine/routine_cbj_entity.dart';
import 'package:cbj_hub/domain/scene/scene_cbj_entity.dart';

/// Class to define all Node RED repo functions
abstract class INodeRedRepository {
  /// Function to create new scene in Node-RED
  Future<String> createNewNodeRedScene(SceneCbjEntity sceneCbj);

  // /// Replace existing scene with new one
  // Future<bool> replaceSceneWithNewNodeRedScene(SceneCbjEntity sceneCbj);

  /// Function to create new routine in Node-RED
  Future<String> createNewNodeRedRoutine(RoutineCbjEntity routineCbj);

  /// Function to create new binding in Node-RED
  Future<String> createNewNodeRedBinding(BindingCbjEntity bindingCbj);

  /// Install node module if not exist and set a new flow for that api
  /// Label is name of the flow
  Future<String> setFlowWithModule({
    required String moduleToUse,
    required String label,
    required String nodes,
    required String flowId,
  });

  /// Update existing flow with more nodes
  Future<String> updateFlowNodes({
    required String nodes,
    required String flowId,
  });

  /// Install node module if needed and set one global node
  /// Label is name of the flow
  Future<String> setGlobalNodes({
    required String? moduleToUse,
    required String nodes,
  });
}
