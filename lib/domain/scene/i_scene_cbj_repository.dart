import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/scene/scene_cbj.dart';
import 'package:cbj_hub/domain/scene/scene_cbj_failures.dart';
import 'package:dartz/dartz.dart';

abstract class ISceneCbjRepository {
  Future<Either<SceneCbjFailure, SceneCbj>> getScene();

  /// Sending the new scene to the hub to get added
  Future<Either<SceneCbjFailure, SceneCbj>> addNewScene(
    String sceneName,
    List<MapEntry<DeviceEntityAbstract, MapEntry<String?, String?>>>
        smartDevicesWithActionToAdd,
  );
}
