import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/local_db/local_db_failures.dart';
import 'package:cbj_hub/domain/room/room_entity.dart';
import 'package:cbj_hub/domain/scene/scene_cbj_entity.dart';
import 'package:cbj_hub/domain/vendors/login_abstract/login_entity_abstract.dart';
import 'package:cbj_hub/domain/vendors/tuya_login/generic_tuya_login_entity.dart';
import 'package:dartz/dartz.dart';

/// Only ISavedDevicesRepo need to call functions here
abstract class ILocalDbRepository {
  /// Name of the box that stores Remote Pipes credentials
  String remotePipesBoxName = 'remotePipesBox';

  /// Name of the box that stores all the rooms
  String roomsBoxName = 'roomsBox';

  /// Name of the box that stores all the devices in form of string json
  String devicesBoxName = 'devicesBox';

  /// Name of the box that stores all the scenes in form of string json
  String scenesBoxName = 'scenesBox';

  /// Name of the box that stores Tuya login credentials
  String tuyaVendorCredentialsBoxName = 'tuyaVendorCredentialsBoxName';

  /// Name of the box that stores Smart Life login credentials
  String smartLifeVendorCredentialsBoxName =
      'smartLifeVendorCredentialsBoxName';

  /// Name of the box that stores Jinvoo Smart login credentials
  String jinvooSmartVendorCredentialsBoxName =
      'jinvooSmartVendorCredentialsBoxName';

  /// Name of the box that stores Hub general info
  String hubEntityBoxName = 'hubEntityBox';

  /// Will load all the local database content into the program
  Future<void> loadFromDb();

  Future<Either<LocalDbFailures, String>> getRemotePipesDnsName();

  /// Get all saved devices from local db
  Future<Either<LocalDbFailures, List<DeviceEntityAbstract>>>
      getSmartDevicesFromDb();

  /// Get all saved scenes from local db
  Future<Either<LocalDbFailures, List<SceneCbjEntity>>> getScenesFromDb();

  /// Will ger all rooms from db, if didn't find any will return discovered room
  /// without any devices
  Future<Either<LocalDbFailures, List<RoomEntity>>> getRoomsFromDb();

  Future<Either<LocalDbFailures, String>> getHubEntityNetworkBssid();

  Future<Either<LocalDbFailures, String>> getHubEntityNetworkName();

  Future<Either<LocalDbFailures, String>> getHubEntityLastKnownIp();

  Future<Either<LocalDbFailures, Unit>> saveRemotePipes({
    required String remotePipesDomainName,
  });

  Future<Either<LocalDbFailures, GenericTuyaLoginDE>>
      getTuyaVendorLoginCredentials({required String vendorBoxName});

  Future<Either<LocalDbFailures, Unit>> saveRoomsToDb({
    required List<RoomEntity> roomsList,
  });

  Future<Either<LocalDbFailures, Unit>> saveSmartDevices({
    required List<DeviceEntityAbstract> deviceList,
  });

  Future<Either<LocalDbFailures, Unit>> saveScenes({
    required List<SceneCbjEntity> sceneList,
  });

  Future<Either<LocalDbFailures, Unit>> saveVendorLoginCredentials({
    required LoginEntityAbstract loginEntityAbstract,
  });

  Future<Either<LocalDbFailures, Unit>> saveHubEntity({
    required String hubNetworkBssid,
    required String networkName,
    required String lastKnownIp,
  });
}
