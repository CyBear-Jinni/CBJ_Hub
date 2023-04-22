import 'package:cbj_hub/domain/binding/binding_cbj_entity.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/local_db/local_db_failures.dart';
import 'package:cbj_hub/domain/room/room_entity.dart';
import 'package:cbj_hub/domain/routine/routine_cbj_entity.dart';
import 'package:cbj_hub/domain/scene/scene_cbj_entity.dart';
import 'package:cbj_hub/domain/vendors/esphome_login/generic_esphome_login_entity.dart';
import 'package:cbj_hub/domain/vendors/ewelink_login/generic_ewelink_login_entity.dart';
import 'package:cbj_hub/domain/vendors/lifx_login/generic_lifx_login_entity.dart';
import 'package:cbj_hub/domain/vendors/login_abstract/login_entity_abstract.dart';
import 'package:cbj_hub/domain/vendors/tuya_login/generic_tuya_login_entity.dart';
import 'package:cbj_hub/domain/vendors/xiaomi_mi_login/generic_xiaomi_mi_login_entity.dart';
import 'package:cbj_hub/infrastructure/local_db/hive_objects/esphome_vendor_credentials_hive_model.dart';
import 'package:cbj_hub/infrastructure/local_db/hive_objects/ewelink_vendor_credentials_hive_model.dart';
import 'package:cbj_hub/infrastructure/local_db/hive_objects/lifx_vendor_credentials_hive_model.dart';
import 'package:cbj_hub/infrastructure/local_db/hive_objects/tuya_vendor_credentials_hive_model.dart';
import 'package:cbj_hub/infrastructure/local_db/hive_objects/xiaomi_mi_vendor_credentials_hive_model.dart';
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

  /// Name of the box that stores all the routines in form of string json
  String routinesBoxName = 'routinesBox';

  /// Name of the box that stores all the bindings in form of string json
  String bindingsBoxName = 'bindingsBox';

  /// Name of the box that stores Tuya login credentials
  String tuyaVendorCredentialsBoxName = 'tuyaVendorCredentialsBoxName';

  /// Name of the box that stores Smart Life login credentials
  String smartLifeVendorCredentialsBoxName =
      'smartLifeVendorCredentialsBoxName';

  /// Name of the box that stores Jinvoo Smart login credentials
  String jinvooSmartVendorCredentialsBoxName =
      'jinvooSmartVendorCredentialsBoxName';

  /// Name of the box that stores Lifx login credentials
  String lifxVendorCredentialsBoxName = 'lifxVendorCredentialsBoxName';

  /// Name of the box that stores ESPHome device password
  String espHomeVendorCredentialsBoxName = 'espHomeVendorCredentialsBoxName';

  /// Name of the box that stores Xiaomi Mi account email ans password
  String xiaomiMiVendorCredentialsBoxName = 'xiaomiMiVendorCredentialsBoxName';

  /// Name of the box that stores eWeLink account email ans password
  String ewelinkVendorCredentialsBoxName = 'ewelinkVendorCredentialsBoxName';

  /// Name of the box that stores Hub general info
  String hubEntityBoxName = 'hubEntityBox';

  /// Loading once all the data from the database
  Future<void> initializeDb();

  /// Will load all the local database content into the program
  Future<void> loadFromDb();

  Future<Either<LocalDbFailures, String>> getRemotePipesDnsName();

  /// Get all saved devices from local db
  Future<Either<LocalDbFailures, List<DeviceEntityAbstract>>>
      getSmartDevicesFromDb();

  /// Get all saved scenes from local db
  Future<Either<LocalDbFailures, List<SceneCbjEntity>>> getScenesFromDb();

  /// Get all saved routines from local db
  Future<Either<LocalDbFailures, List<RoutineCbjEntity>>> getRoutinesFromDb();

  /// Get all saved bindings from local db
  Future<Either<LocalDbFailures, List<BindingCbjEntity>>> getBindingsFromDb();

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
      getTuyaVendorLoginCredentials({
    required List<TuyaVendorCredentialsHiveModel>
        tuyaVendorCredentialsModelFromDb,
    required String vendorBoxName,
  });

  Future<Either<LocalDbFailures, GenericLifxLoginDE>>
      getLifxVendorLoginCredentials({
    required List<LifxVendorCredentialsHiveModel>
        lifxVendorCredentialsModelFromDb,
  });

  Future<Either<LocalDbFailures, GenericEspHomeLoginDE>>
      getEspHomeVendorLoginCredentials({
    required List<EspHomeVendorCredentialsHiveModel>
        espHomeVendorCredentialsModelFromDb,
  });

  Future<Either<LocalDbFailures, GenericXiaomiMiLoginDE>>
      getXiaomiMiVendorLoginCredentials({
    required List<XiaomiMiVendorCredentialsHiveModel>
        xiaomiMiVendorCredentialsModelFromDb,
  });

  Future<Either<LocalDbFailures, GenericEwelinkLoginDE>>
      getEwelinkVendorLoginCredentials({
    required List<EwelinkVendorCredentialsHiveModel>
        ewelinkVendorCredentialsModelFromDb,
  });

  Future<Either<LocalDbFailures, Unit>> saveRoomsToDb({
    required List<RoomEntity> roomsList,
  });

  Future<Either<LocalDbFailures, Unit>> saveSmartDevices({
    required List<DeviceEntityAbstract> deviceList,
  });

  Future<Either<LocalDbFailures, Unit>> saveScenes({
    required List<SceneCbjEntity> sceneList,
  });

  Future<Either<LocalDbFailures, Unit>> saveRoutines({
    required List<RoutineCbjEntity> routineList,
  });

  Future<Either<LocalDbFailures, Unit>> saveBindings({
    required List<BindingCbjEntity> bindingList,
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
