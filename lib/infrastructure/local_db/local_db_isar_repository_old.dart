import 'dart:convert';

import 'package:cbj_hub/domain/app_communication/i_app_communication_repository.dart';
import 'package:cbj_hub/domain/binding/binding_cbj_entity.dart';
import 'package:cbj_hub/domain/binding/i_binding_cbj_repository.dart';
import 'package:cbj_hub/domain/binding/value_objects_routine_cbj.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/local_db/i_local_db_repository.dart';
import 'package:cbj_hub/domain/local_db/local_db_failures.dart';
import 'package:cbj_hub/domain/room/room_entity.dart';
import 'package:cbj_hub/domain/room/value_objects_room.dart';
import 'package:cbj_hub/domain/rooms/i_saved_rooms_repo.dart';
import 'package:cbj_hub/domain/routine/i_routine_cbj_repository.dart';
import 'package:cbj_hub/domain/routine/routine_cbj_entity.dart';
import 'package:cbj_hub/domain/routine/value_objects_routine_cbj.dart';
import 'package:cbj_hub/domain/saved_devices/i_saved_devices_repo.dart';
import 'package:cbj_hub/domain/scene/i_scene_cbj_repository.dart';
import 'package:cbj_hub/domain/scene/scene_cbj_entity.dart';
import 'package:cbj_hub/domain/scene/value_objects_scene_cbj.dart';
import 'package:cbj_hub/domain/vendors/esphome_login/generic_esphome_login_entity.dart';
import 'package:cbj_hub/domain/vendors/esphome_login/generic_esphome_login_value_objects.dart';
import 'package:cbj_hub/domain/vendors/lifx_login/generic_lifx_login_entity.dart';
import 'package:cbj_hub/domain/vendors/lifx_login/generic_lifx_login_value_objects.dart';
import 'package:cbj_hub/domain/vendors/login_abstract/login_entity_abstract.dart';
import 'package:cbj_hub/domain/vendors/login_abstract/value_login_objects_core.dart';
import 'package:cbj_hub/domain/vendors/tuya_login/generic_tuya_login_entity.dart';
import 'package:cbj_hub/domain/vendors/tuya_login/generic_tuya_login_value_objects.dart';
import 'package:cbj_hub/infrastructure/bindings/binding_cbj_dtos.dart';
import 'package:cbj_hub/infrastructure/devices/companies_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/device_helper/device_helper.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/infrastructure/local_db/hive_objects/esphome_vendor_credentials_hive_model.dart';
import 'package:cbj_hub/infrastructure/local_db/hive_objects/lifx_vendor_credentials_hive_model.dart';
import 'package:cbj_hub/infrastructure/local_db/hive_objects/tuya_vendor_credentials_hive_model.dart';
import 'package:cbj_hub/infrastructure/local_db/isar_old_objects/bindings_isar_model.dart';
import 'package:cbj_hub/infrastructure/local_db/isar_old_objects/devices_isar_model.dart';
import 'package:cbj_hub/infrastructure/local_db/isar_old_objects/remote_pipes_isar_model.dart';
import 'package:cbj_hub/infrastructure/local_db/isar_old_objects/rooms_isar_model.dart';
import 'package:cbj_hub/infrastructure/local_db/isar_old_objects/routines_isar_model.dart';
import 'package:cbj_hub/infrastructure/local_db/isar_old_objects/scenes_isar_model.dart';
import 'package:cbj_hub/infrastructure/local_db/isar_old_objects/tuya_vendor_credentials_isar_model.dart';
import 'package:cbj_hub/infrastructure/room/room_entity_dtos.dart';
import 'package:cbj_hub/infrastructure/routines/routine_cbj_dtos.dart';
import 'package:cbj_hub/infrastructure/scenes/scene_cbj_dtos.dart';
import 'package:cbj_hub/infrastructure/system_commands/system_commands_manager_d.dart';
import 'package:cbj_hub/injection.dart';
import 'package:cbj_hub/utils.dart';
import 'package:dartz/dartz.dart';
import 'package:isar/isar.dart';

// We are going back to hive and leving all this part as isar does not
// currently support linux arm/arm64 architecture
// https://github.com/isar/isar/issues/848

/// Only ISavedDevicesRepo need to call functions here
// @LazySingleton(as: ILocalDbRepository)
class IsarRepository extends ILocalDbRepository {
  late Isar isar;
  Future<bool>? didDbInitialzed;

  @override
  Future<void> initializeDb() async {
    if (didDbInitialzed == null) {
      didDbInitialzed = asyncConstractorHelper();
      await loadFromDb();
    } else {
      await didDbInitialzed;
    }
  }

  Future<bool> asyncConstractorHelper() async {
    String? localDbPath = await getIt<SystemCommandsManager>().getLocalDbPath();

    if (localDbPath == null) {
      logger.e('Cant find local DB path');
      localDbPath = '/';
    }

    logger.i('Isar db location\n${isar.path}');

    await Isar.initializeIsarCore(download: true);
    isar = await Isar.open([
      BindingsIsarModelSchema,
      RoomsIsarModelSchema,
      DevicesIsarModelSchema,
      TuyaVendorCredentialsIsarModelSchema,
      RemotePipesIsarModelSchema,
      ScenesIsarModelSchema,
      RoutinesIsarModelSchema,
    ]);

    return true;
  }

  @override
  Future<void> loadFromDb() async {
    (await getRemotePipesDnsName()).fold(
        (l) =>
            logger.w('No Remote Pipes Dns name was found in the local storage'),
        (r) {
      getIt<IAppCommunicationRepository>().startRemotePipesConnection(r);

      logger.i('Remote Pipes DNS name was "$r" found');
    });
    (await getTuyaVendorLoginCredentials(
      vendorBoxName: tuyaVendorCredentialsBoxName,
      tuyaVendorCredentialsModelFromDb: [],
    ))
        .fold((l) {}, (r) {
      CompaniesConnectorConjector.setVendorLoginCredentials(r);

      logger.i(
        'Tuya login credentials user name ${r.tuyaUserName.getOrCrash()} found',
      );
    });
    (await getTuyaVendorLoginCredentials(
      vendorBoxName: smartLifeVendorCredentialsBoxName,
      tuyaVendorCredentialsModelFromDb: [],
    ))
        .fold((l) {}, (r) {
      CompaniesConnectorConjector.setVendorLoginCredentials(r);

      logger.i(
        'Smart Life login credentials user name ${r.tuyaUserName.getOrCrash()} found',
      );
    });
    (await getTuyaVendorLoginCredentials(
      vendorBoxName: jinvooSmartVendorCredentialsBoxName,
      tuyaVendorCredentialsModelFromDb: [],
    ))
        .fold((l) {}, (r) {
      CompaniesConnectorConjector.setVendorLoginCredentials(r);

      logger.i(
        'Jinvoo Smart login credentials user name ${r.tuyaUserName.getOrCrash()} found',
      );
    });

    // Rooms need to stay first one
    await getIt<ISavedRoomsRepo>().setUpAllFromDb();
    await getIt<ISceneCbjRepository>().setUpAllFromDb();
    await getIt<IRoutineCbjRepository>().setUpAllFromDb();
    await getIt<IBindingCbjRepository>().setUpAllFromDb();
    await getIt<ISavedDevicesRepo>().setUpAllFromDb();
  }

  @override
  Future<Either<LocalDbFailures, List<RoomEntity>>> getRoomsFromDb() async {
    await initializeDb();

    final List<RoomEntity> rooms = <RoomEntity>[];
    try {
      final List<RoomsIsarModel> roomsIsarModelFromDb =
          await isar.roomsIsarModels.where().findAll();

      for (final RoomsIsarModel roomIsar in roomsIsarModelFromDb) {
        final RoomEntity roomEntity = RoomEntity(
          uniqueId: RoomUniqueId.fromUniqueString(roomIsar.roomUniqueId),
          defaultName: RoomDefaultName(roomIsar.roomDefaultName),
          background: RoomBackground(roomIsar.roomBackground),
          roomTypes: RoomTypes(roomIsar.roomTypes),
          roomDevicesId: RoomDevicesId(roomIsar.roomDevicesId),
          roomScenesId: RoomScenesId(roomIsar.roomScenesId),
          roomRoutinesId: RoomRoutinesId(roomIsar.roomRoutinesId),
          roomBindingsId: RoomBindingsId(roomIsar.roomBindingsId),
          roomMostUsedBy: RoomMostUsedBy(roomIsar.roomMostUsedBy),
          roomPermissions: RoomPermissions(roomIsar.roomPermissions),
        );
        rooms.add(roomEntity);
      }
    } catch (e) {
      logger.e('Local DB isar error while getting rooms: $e');
      await deleteAllSavedRooms();
    }
    return right(rooms);
  }

  @override
  Future<Either<LocalDbFailures, List<DeviceEntityAbstract>>>
      getSmartDevicesFromDb() async {
    await initializeDb();

    final List<DeviceEntityAbstract> devices = <DeviceEntityAbstract>[];

    try {
      final List<DevicesIsarModel> devicesIsarModelFromDb =
          await isar.devicesIsarModels.where().findAll();

      for (final DevicesIsarModel deviceIsar in devicesIsarModelFromDb) {
        final DeviceEntityAbstract deviceEntity =
            DeviceHelper.convertJsonStringToDomain(deviceIsar.deviceStringJson);

        devices.add(
          deviceEntity
            ..deviceStateGRPC =
                DeviceState(DeviceStateGRPC.waitingInComp.toString()),
        );
      }
      return right(devices);
    } catch (e) {
      logger.e('Local DB isar error while getting devices: $e');
    }
    return left(const LocalDbFailures.unexpected());
  }

  @override
  Future<Either<LocalDbFailures, String>> getHubEntityLastKnownIp() async {
    await initializeDb();

    // TODO: implement getHubEntityLastKnownIp
    throw UnimplementedError();
  }

  @override
  Future<Either<LocalDbFailures, String>> getHubEntityNetworkBssid() async {
    await initializeDb();

    // TODO: implement getHubEntityNetworkBssid
    throw UnimplementedError();
  }

  @override
  Future<Either<LocalDbFailures, String>> getHubEntityNetworkName() async {
    await initializeDb();

    // TODO: implement getHubEntityNetworkName
    throw UnimplementedError();
  }

  @override
  Future<Either<LocalDbFailures, GenericTuyaLoginDE>>
      getTuyaVendorLoginCredentials({
    required List<TuyaVendorCredentialsHiveModel>
        tuyaVendorCredentialsModelFromDb,
    required String vendorBoxName,
  }) async {
    await initializeDb();

    try {
      final List<TuyaVendorCredentialsIsarModel>
          tuyaVendorCredentialsModelFromDb =
          await isar.tuyaVendorCredentialsIsarModels.where().findAll();

      if (tuyaVendorCredentialsModelFromDb.isNotEmpty) {
        final TuyaVendorCredentialsIsarModel firstTuyaVendorFromDB =
            tuyaVendorCredentialsModelFromDb[0];

        final String? senderUniqueId = firstTuyaVendorFromDB.senderUniqueId;
        final String tuyaUserName = firstTuyaVendorFromDB.tuyaUserName;
        final String tuyaUserPassword = firstTuyaVendorFromDB.tuyaUserPassword;
        final String tuyaCountryCode = firstTuyaVendorFromDB.tuyaCountryCode;
        final String tuyaBizType = firstTuyaVendorFromDB.tuyaBizType;
        final String tuyaRegion = firstTuyaVendorFromDB.tuyaRegion;
        final String loginVendor = firstTuyaVendorFromDB.loginVendor;

        final GenericTuyaLoginDE genericTuyaLoginDE = GenericTuyaLoginDE(
          senderUniqueId: CoreLoginSenderId.fromUniqueString(senderUniqueId),
          loginVendor: CoreLoginVendor(loginVendor),
          tuyaUserName: GenericTuyaLoginUserName(tuyaUserName),
          tuyaUserPassword: GenericTuyaLoginUserPassword(tuyaUserPassword),
          tuyaCountryCode: GenericTuyaLoginCountryCode(tuyaCountryCode),
          tuyaBizType: GenericTuyaLoginBizType(tuyaBizType),
          tuyaRegion: GenericTuyaLoginRegion(tuyaRegion),
        );

        logger.i(
          'Tuya user name is: '
          '$tuyaUserName',
        );
        return right(genericTuyaLoginDE);
      }
      logger.i(
        "Didn't find any Tuya in the local DB for box name $vendorBoxName",
      );
    } catch (e) {
      logger.e('Local DB isar error while getting Tuya vendor: $e');
    }
    return left(const LocalDbFailures.unexpected());
  }

  @override
  Future<Either<LocalDbFailures, String>> getRemotePipesDnsName() async {
    await initializeDb();

    try {
      final List<RemotePipesIsarModel> remotePipesIsarModelFromDb =
          await isar.remotePipesIsarModels.where().findAll();

      if (remotePipesIsarModelFromDb.isNotEmpty) {
        final String remotePipesDnsName =
            remotePipesIsarModelFromDb[0].domainName;

        logger.i(
          'Remote pipes domain name is: '
          '$remotePipesDnsName',
        );
        return right(remotePipesDnsName);
      }
      logger.i("Didn't find any remote pipes in the local DB");
    } catch (e) {
      logger.e('Local DB isar error while getting Remote Pipes: $e');
      isar.close();
    }
    return left(const LocalDbFailures.unexpected());
  }

  @override
  Future<Either<LocalDbFailures, Unit>> saveSmartDevices({
    required List<DeviceEntityAbstract> deviceList,
  }) async {
    await initializeDb();

    try {
      final List<DevicesIsarModel> devicesIsarList = [];

      final List<String> devicesListStringJson = List<String>.from(
        deviceList.map((e) => DeviceHelper.convertDomainToJsonString(e)),
      );

      for (final String devicesEntityDtosJsonString in devicesListStringJson) {
        final DevicesIsarModel devicesIsarModel = DevicesIsarModel()
          ..deviceStringJson = devicesEntityDtosJsonString;
        devicesIsarList.add(devicesIsarModel);
      }

      await isar.writeTxn(() async {
        await isar.devicesIsarModels.clear();
        await isar.devicesIsarModels.putAll(devicesIsarList);
      });

      logger.i('Devices got saved to local storage');
    } catch (e) {
      logger.e('Error saving Devices to local storage\n$e');

      return left(const LocalDbFailures.unexpected());
    }

    return right(unit);
  }

  @override
  Future<Either<LocalDbFailures, Unit>> saveRoomsToDb({
    required List<RoomEntity> roomsList,
  }) async {
    await initializeDb();

    try {
      final List<RoomsIsarModel> roomsIsarList = [];

      final List<RoomEntityDtos> roomsListDto =
          List<RoomEntityDtos>.from(roomsList.map((e) => e.toInfrastructure()));

      for (final RoomEntityDtos roomEntityDtos in roomsListDto) {
        final RoomsIsarModel roomsIsarModel = RoomsIsarModel()
          ..roomUniqueId = roomEntityDtos.uniqueId
          ..roomDefaultName = roomEntityDtos.defaultName
          ..roomBackground = roomEntityDtos.background
          ..roomDevicesId = roomEntityDtos.roomDevicesId
          ..roomScenesId = roomEntityDtos.roomScenesId
          ..roomRoutinesId = roomEntityDtos.roomRoutinesId
          ..roomBindingsId = roomEntityDtos.roomBindingsId
          ..roomMostUsedBy = roomEntityDtos.roomMostUsedBy
          ..roomPermissions = roomEntityDtos.roomPermissions
          ..roomTypes = roomEntityDtos.roomTypes;
        roomsIsarList.add(roomsIsarModel);
      }

      await isar.writeTxn(() async {
        await isar.roomsIsarModels.clear();
        await isar.roomsIsarModels.putAll(roomsIsarList);
      });

      logger.i('Rooms got saved to local storage');
    } catch (e) {
      logger.e('Error saving Rooms to local storage\n$e');

      return left(const LocalDbFailures.unexpected());
    }

    return right(unit);
  }

  @override
  Future<Either<LocalDbFailures, Unit>> saveHubEntity({
    required String hubNetworkBssid,
    required String networkName,
    required String lastKnownIp,
  }) async {
    await initializeDb();

    // TODO: implement saveHubEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<LocalDbFailures, Unit>> saveVendorLoginCredentials({
    required LoginEntityAbstract loginEntityAbstract,
  }) async {
    await initializeDb();

    if (loginEntityAbstract is GenericTuyaLoginDE) {
      if (loginEntityAbstract.loginVendor.getOrCrash() ==
          VendorsAndServices.smartLife.name) {
        saveTuyaVendorCredentials(
          tuyaLoginDE: loginEntityAbstract,
          vendorCredentialsBoxName: smartLifeVendorCredentialsBoxName,
        );
      } else if (loginEntityAbstract.loginVendor.getOrCrash() ==
          VendorsAndServices.jinvooSmart.name) {
        saveTuyaVendorCredentials(
          tuyaLoginDE: loginEntityAbstract,
          vendorCredentialsBoxName: jinvooSmartVendorCredentialsBoxName,
        );
      } else {
        saveTuyaVendorCredentials(
          tuyaLoginDE: loginEntityAbstract,
          vendorCredentialsBoxName: tuyaVendorCredentialsBoxName,
        );
      }
    } else {
      logger.e(
        'Please implement save function for this login type '
        '${loginEntityAbstract.runtimeType}',
      );
    }

    return right(unit);
  }

  @override
  Future<Either<LocalDbFailures, Unit>> saveRemotePipes({
    required String remotePipesDomainName,
  }) async {
    await initializeDb();

    try {
      final RemotePipesIsarModel remotePipesIsarModel = RemotePipesIsarModel()
        ..domainName = remotePipesDomainName;

      await isar.writeTxn(() async {
        await isar.remotePipesIsarModels.clear();
        await isar.remotePipesIsarModels.put(remotePipesIsarModel);
      });

      logger.i(
        'Remote Pipes got saved to local storage with domain name is: '
        '$remotePipesDomainName',
      );
    } catch (e) {
      logger.e('Error saving Remote Pipes to local storage');

      return left(const LocalDbFailures.unexpected());
    }

    return right(unit);
  }

  Future<Either<LocalDbFailures, Unit>> saveTuyaVendorCredentials({
    required GenericTuyaLoginDE tuyaLoginDE,
    required String vendorCredentialsBoxName,
  }) async {
    await initializeDb();

    try {
      final TuyaVendorCredentialsIsarModel tuyaVendorCredentialsModel =
          TuyaVendorCredentialsIsarModel()
            ..senderUniqueId = tuyaLoginDE.senderUniqueId.getOrCrash()
            ..tuyaUserName = tuyaLoginDE.tuyaUserName.getOrCrash()
            ..tuyaUserPassword = tuyaLoginDE.tuyaUserPassword.getOrCrash()
            ..tuyaCountryCode = tuyaLoginDE.tuyaCountryCode.getOrCrash()
            ..tuyaBizType = tuyaLoginDE.tuyaBizType.getOrCrash()
            ..tuyaRegion = tuyaLoginDE.tuyaRegion.getOrCrash()
            ..loginVendor = tuyaLoginDE.loginVendor.getOrCrash();

      await isar.writeTxn(() async {
        await isar.tuyaVendorCredentialsIsarModels.clear();
        await isar.tuyaVendorCredentialsIsarModels
            .put(tuyaVendorCredentialsModel);
      });

      logger.i(
        'Tuya vendor credentials saved to local storage with the user name: '
        '${tuyaLoginDE.tuyaUserName.getOrCrash()}',
      );
    } catch (e) {
      logger.e('Error saving Remote Pipes to local storage');

      return left(const LocalDbFailures.unexpected());
    }
    return right(unit);
  }

  Future<void> deleteAllSavedRooms() async {
    await saveRoomsToDb(roomsList: []);
  }

  @override
  Future<Either<LocalDbFailures, List<SceneCbjEntity>>>
      getScenesFromDb() async {
    await initializeDb();

    final List<SceneCbjEntity> scenes = <SceneCbjEntity>[];

    try {
      final List<ScenesIsarModel> scenesIsarModelFromDb =
          await isar.scenesIsarModels.where().findAll();

      for (final ScenesIsarModel sceneIsar in scenesIsarModelFromDb) {
        final SceneCbjEntity sceneEntity = SceneCbjDtos.fromJson(
          jsonDecode(sceneIsar.scenesStringJson) as Map<String, dynamic>,
        ).toDomain();

        scenes.add(
          sceneEntity.copyWith(
            deviceStateGRPC: SceneCbjDeviceStateGRPC(
              DeviceStateGRPC.waitingInComp.toString(),
            ),
          ),
        );
      }
      return right(scenes);
    } catch (e) {
      logger.e('Local DB isar error while getting scenes: $e');
    }
    return left(const LocalDbFailures.unexpected());
  }

  @override
  Future<Either<LocalDbFailures, List<RoutineCbjEntity>>>
      getRoutinesFromDb() async {
    await initializeDb();

    final List<RoutineCbjEntity> routines = <RoutineCbjEntity>[];

    try {
      final List<RoutinesIsarModel> routinesIsarModelFromDb =
          await isar.routinesIsarModels.where().findAll();

      for (final RoutinesIsarModel routineIsar in routinesIsarModelFromDb) {
        final RoutineCbjEntity routineEntity = RoutineCbjDtos.fromJson(
          jsonDecode(routineIsar.routinesStringJson) as Map<String, dynamic>,
        ).toDomain();

        routines.add(
          routineEntity.copyWith(
            deviceStateGRPC: RoutineCbjDeviceStateGRPC(
              DeviceStateGRPC.waitingInComp.toString(),
            ),
          ),
        );
      }
      return right(routines);
    } catch (e) {
      logger.e('Local DB isar error while getting routines: $e');
    }
    return left(const LocalDbFailures.unexpected());
  }

  @override
  Future<Either<LocalDbFailures, List<BindingCbjEntity>>>
      getBindingsFromDb() async {
    await initializeDb();

    final List<BindingCbjEntity> bindings = <BindingCbjEntity>[];

    try {
      final List<BindingsIsarModel> bindingsIsarModelFromDb =
          await isar.bindingsIsarModels.where().findAll();

      for (final BindingsIsarModel bindingIsar in bindingsIsarModelFromDb) {
        final BindingCbjEntity bindingEntity = BindingCbjDtos.fromJson(
          jsonDecode(bindingIsar.bindingsStringJson) as Map<String, dynamic>,
        ).toDomain();

        bindings.add(
          bindingEntity.copyWith(
            deviceStateGRPC: BindingCbjDeviceStateGRPC(
              DeviceStateGRPC.waitingInComp.toString(),
            ),
          ),
        );
      }
      return right(bindings);
    } catch (e) {
      logger.e('Local DB isar error while getting bindings: $e');
    }
    return left(const LocalDbFailures.unexpected());
  }

  @override
  Future<Either<LocalDbFailures, Unit>> saveScenes({
    required List<SceneCbjEntity> sceneList,
  }) async {
    await initializeDb();

    try {
      final List<ScenesIsarModel> scenesIsarList = [];

      final List<String> scenesListStringJson = List<String>.from(
        sceneList.map((e) => jsonEncode(e.toInfrastructure().toJson())),
      );

      for (final String scenesEntityDtosJsonString in scenesListStringJson) {
        final ScenesIsarModel scenesIsarModel = ScenesIsarModel()
          ..scenesStringJson = scenesEntityDtosJsonString;
        scenesIsarList.add(scenesIsarModel);
      }

      await isar.writeTxn(() async {
        await isar.scenesIsarModels.clear();
        await isar.scenesIsarModels.putAll(scenesIsarList);
      });

      logger.i('Scenes got saved to local storage');
    } catch (e) {
      logger.e('Error saving Scenes to local storage\n$e');

      return left(const LocalDbFailures.unexpected());
    }

    return right(unit);
  }

  @override
  Future<Either<LocalDbFailures, Unit>> saveRoutines({
    required List<RoutineCbjEntity> routineList,
  }) async {
    await initializeDb();

    try {
      final List<RoutinesIsarModel> routinesIsarList = [];

      final List<String> routinesListStringJson = List<String>.from(
        routineList.map((e) => jsonEncode(e.toInfrastructure().toJson())),
      );

      for (final String routinesEntityDtosJsonString
          in routinesListStringJson) {
        final RoutinesIsarModel routinesIsarModel = RoutinesIsarModel()
          ..routinesStringJson = routinesEntityDtosJsonString;
        routinesIsarList.add(routinesIsarModel);
      }

      await isar.writeTxn(() async {
        await isar.routinesIsarModels.clear();
        await isar.routinesIsarModels.putAll(routinesIsarList);
      });

      logger.i('Routines got saved to local storage');
    } catch (e) {
      logger.e('Error saving Routines to local storage\n$e');

      return left(const LocalDbFailures.unexpected());
    }

    return right(unit);
  }

  @override
  Future<Either<LocalDbFailures, Unit>> saveBindings({
    required List<BindingCbjEntity> bindingList,
  }) async {
    await initializeDb();

    try {
      final List<BindingsIsarModel> bindingsIsarList = [];

      final List<String> bindingsListStringJson = List<String>.from(
        bindingList.map((e) => jsonEncode(e.toInfrastructure().toJson())),
      );

      for (final String bindingsEntityDtosJsonString
          in bindingsListStringJson) {
        final BindingsIsarModel bindingsIsarModel = BindingsIsarModel()
          ..bindingsStringJson = bindingsEntityDtosJsonString;
        bindingsIsarList.add(bindingsIsarModel);
      }

      await isar.writeTxn(() async {
        await isar.bindingsIsarModels.clear();
        await isar.bindingsIsarModels.putAll(bindingsIsarList);
      });

      logger.i('Bindings got saved to local storage');
    } catch (e) {
      logger.e('Error saving Bindings to local storage\n$e');

      return left(const LocalDbFailures.unexpected());
    }

    return right(unit);
  }

  @override
  Future<Either<LocalDbFailures, GenericLifxLoginDE>>
      getLifxVendorLoginCredentials({
    required List<LifxVendorCredentialsHiveModel>
        lifxVendorCredentialsModelFromDb,
  }) async {
    try {
      if (lifxVendorCredentialsModelFromDb.isNotEmpty) {
        final LifxVendorCredentialsHiveModel firstLifxVendorFromDB =
            lifxVendorCredentialsModelFromDb[0];

        final String? senderUniqueId = firstLifxVendorFromDB.senderUniqueId;
        final String lifxApiKey = firstLifxVendorFromDB.lifxApiKey;

        final GenericLifxLoginDE genericLifxLoginDE = GenericLifxLoginDE(
          senderUniqueId: CoreLoginSenderId.fromUniqueString(senderUniqueId),
          lifxApiKey: GenericLifxLoginApiKey(lifxApiKey),
        );

        logger.i(
          'Lifx got returned from local storage',
        );
        return right(genericLifxLoginDE);
      }
      logger.i(
        "Didn't find any Lifx in the local DB",
      );
    } catch (e) {
      logger.e('Local DB hive error while getting Lifx vendor: $e');
    }
    return left(const LocalDbFailures.unexpected());
  }

  @override
  Future<Either<LocalDbFailures, GenericEspHomeLoginDE>>
      getEspHomeVendorLoginCredentials({
    required List<EspHomeVendorCredentialsHiveModel>
        espHomeVendorCredentialsModelFromDb,
  }) async {
    try {
      if (espHomeVendorCredentialsModelFromDb.isNotEmpty) {
        final EspHomeVendorCredentialsHiveModel firstEspHomeVendorFromDB =
            espHomeVendorCredentialsModelFromDb[0];

        final String? senderUniqueId = firstEspHomeVendorFromDB.senderUniqueId;
        final String espHomeDevicePass =
            firstEspHomeVendorFromDB.espHomeDevicePass;

        final GenericEspHomeLoginDE genericEspHomeLoginDE =
            GenericEspHomeLoginDE(
          senderUniqueId: CoreLoginSenderId.fromUniqueString(senderUniqueId),
          espHomeDevicePass:
              GenericEspHomeDeviceLoginApiPass(espHomeDevicePass),
        );

        logger.i(
          'ESPHome got returned from local storage',
        );
        return right(genericEspHomeLoginDE);
      }
      logger.i(
        "Didn't find any ESPHome in the local DB",
      );
    } catch (e) {
      logger.e('Local DB hive error while getting ESPHome vendor: $e');
    }
    return left(const LocalDbFailures.unexpected());
  }
}
