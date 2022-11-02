import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/local_db/local_db_failures.dart';
import 'package:cbj_hub/domain/scene/scene_cbj_entity.dart';
import 'package:cbj_hub/domain/scene/scene_cbj_failures.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:dartz/dartz.dart';
import 'package:kt_dart/collection.dart';
import 'package:rxdart/rxdart.dart';

abstract class ISceneCbjRepository {
  /// Setting up all scenes from db
  Future<void> setUpAllFromDb();

  Future<List<SceneCbjEntity>> getAllScenesAsList();

  Future<Map<String, SceneCbjEntity>> getAllScenesAsMap();

  /// Will add new scene without saving it in the local db
  Future<Either<SceneCbjFailure, String>> addNewScene(
    SceneCbjEntity sceneCbj,
  );

  /// Sending the new scene to the hub to get added
  Future<Either<SceneCbjFailure, String>> addNewSceneAndSaveInDb(
    SceneCbjEntity sceneCbj,
  );

  Future<Either<LocalDbFailures, Unit>>
      saveAndActivateScenesAndSmartDevicesToDb();

  Future<bool> activateScene(
    SceneCbjEntity sceneCbj,
  );

  /// Get entity and return the full MQTT path to it
  Future<String> getFullMqttPathOfScene(SceneCbjEntity sceneCbj);

  Stream<Either<SceneCbjFailure, KtList<SceneCbjEntity>>> watchAllScenes();

  /// Sending the new scene to the hub to get added
  Future<Either<SceneCbjFailure, SceneCbjEntity>> addOrUpdateNewSceneInHub(
    SceneCbjEntity sceneCbjEntity,
  );

  /// Activate action of all scene list
  Future<Either<SceneCbjFailure, Unit>> activateScenes(
    KtList<SceneCbjEntity> scenesList,
  );

  /// Sending the new scene to the hub to get added
  Future<Either<SceneCbjFailure, SceneCbjEntity>>
      addOrUpdateNewSceneInHubFromDevicesPropertyActionList(
    String sceneName,
    List<MapEntry<DeviceEntityAbstract, MapEntry<String?, String?>>>
        smartDevicesWithActionToAdd,
    AreaPurposesTypes areaPurposesTypes,
  );

  /// Will add all the devices to area scene, for each device will use the preselected
  /// actions for that area type
  Future<Either<SceneCbjFailure, Unit>>
      addDevicesToMultipleScenesAreaTypeWithPreSetActions({
    required List<String> devicesId,
    required List<String> scenesId,
    required List<String> areaTypes,
  });

  /// Will add all the devices to area scene, for each device will use the preselected
  /// actions for that area type
  Future<Either<SceneCbjFailure, SceneCbjEntity>>
      addDevicesToSceneAreaTypeWithPreSetActions({
    required List<String> devicesId,
    required String sceneId,
    required AreaPurposesTypes areaType,
  });

  /// Sending the new scene from the hub to the app scene list
  void addOrUpdateNewSceneInApp(
    SceneCbjEntity sceneCbj,
  );

  Future<void> initiateHubConnection();

  BehaviorSubject<KtList<SceneCbjEntity>>
      scenesResponseFromTheHubStreamController =
      BehaviorSubject<KtList<SceneCbjEntity>>();
}
