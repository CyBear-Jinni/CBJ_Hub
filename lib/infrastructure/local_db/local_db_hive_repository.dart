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
import 'package:cbj_hub/domain/vendors/ewelink_login/generic_ewelink_login_entity.dart';
import 'package:cbj_hub/domain/vendors/ewelink_login/generic_ewelink_login_value_objects.dart';
import 'package:cbj_hub/domain/vendors/lifx_login/generic_lifx_login_entity.dart';
import 'package:cbj_hub/domain/vendors/lifx_login/generic_lifx_login_value_objects.dart';
import 'package:cbj_hub/domain/vendors/login_abstract/login_entity_abstract.dart';
import 'package:cbj_hub/domain/vendors/login_abstract/value_login_objects_core.dart';
import 'package:cbj_hub/domain/vendors/tuya_login/generic_tuya_login_entity.dart';
import 'package:cbj_hub/domain/vendors/tuya_login/generic_tuya_login_value_objects.dart';
import 'package:cbj_hub/domain/vendors/xiaomi_mi_login/generic_xiaomi_mi_login_entity.dart';
import 'package:cbj_hub/domain/vendors/xiaomi_mi_login/generic_xiaomi_mi_login_value_objects.dart';
import 'package:cbj_hub/infrastructure/bindings/binding_cbj_dtos.dart';
import 'package:cbj_hub/infrastructure/devices/companies_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/device_helper/device_helper.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/infrastructure/local_db/hive_objects/bindings_hive_model.dart';
import 'package:cbj_hub/infrastructure/local_db/hive_objects/devices_hive_model.dart';
import 'package:cbj_hub/infrastructure/local_db/hive_objects/esphome_vendor_credentials_hive_model.dart';
import 'package:cbj_hub/infrastructure/local_db/hive_objects/ewelink_vendor_credentials_hive_model.dart';
import 'package:cbj_hub/infrastructure/local_db/hive_objects/hub_entity_hive_model.dart';
import 'package:cbj_hub/infrastructure/local_db/hive_objects/lifx_vendor_credentials_hive_model.dart';
import 'package:cbj_hub/infrastructure/local_db/hive_objects/remote_pipes_hive_model.dart';
import 'package:cbj_hub/infrastructure/local_db/hive_objects/rooms_hive_model.dart';
import 'package:cbj_hub/infrastructure/local_db/hive_objects/routines_hive_model.dart';
import 'package:cbj_hub/infrastructure/local_db/hive_objects/scenes_hive_model.dart';
import 'package:cbj_hub/infrastructure/local_db/hive_objects/tuya_vendor_credentials_hive_model.dart';
import 'package:cbj_hub/infrastructure/local_db/hive_objects/xiaomi_mi_vendor_credentials_hive_model.dart';
import 'package:cbj_hub/infrastructure/room/room_entity_dtos.dart';
import 'package:cbj_hub/infrastructure/routines/routine_cbj_dtos.dart';
import 'package:cbj_hub/infrastructure/scenes/scene_cbj_dtos.dart';
import 'package:cbj_hub/infrastructure/system_commands/system_commands_manager_d.dart';
import 'package:cbj_hub/injection.dart';
import 'package:cbj_hub/utils.dart';
import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

/// Only ISavedDevicesRepo need to call functions here
@LazySingleton(as: ILocalDbRepository)
class HiveRepository extends ILocalDbRepository {
  @override
  Future<void> initializeDb() async {
    String? localDbPath = await getIt<SystemCommandsManager>().getLocalDbPath();

    if (localDbPath[localDbPath.length - 1] == '/') {
      localDbPath = localDbPath.substring(0, localDbPath.length - 1);
    }
    localDbPath += '/hive';

    logger.i('Hive db location\n$localDbPath');

    Hive.init(localDbPath);
    await Future.delayed(const Duration(milliseconds: 500));
    Hive.registerAdapter(RemotePipesHiveModelAdapter());
    Hive.registerAdapter(RoomsHiveModelAdapter());
    Hive.registerAdapter(DevicesHiveModelAdapter());
    Hive.registerAdapter(ScenesHiveModelAdapter());
    Hive.registerAdapter(RoutinesHiveModelAdapter());
    Hive.registerAdapter(BindingsHiveModelAdapter());
    Hive.registerAdapter(HubEntityHiveModelAdapter());
    Hive.registerAdapter(TuyaVendorCredentialsHiveModelAdapter());
    Hive.registerAdapter(LifxVendorCredentialsHiveModelAdapter());
    Hive.registerAdapter(EspHomeVendorCredentialsHiveModelAdapter());
    Hive.registerAdapter(XiaomiMiVendorCredentialsHiveModelAdapter());
    Hive.registerAdapter(EwelinkVendorCredentialsHiveModelAdapter());

    /// Delay inorder for the Hive boxes to initialize
    /// In case you got the following error:
    /// "HiveError: You need to initialize Hive or provide a path to store
    /// the box."
    /// Please increase the duration
    await Future.delayed(const Duration(milliseconds: 100));

    await loadFromDb();
  }

  Box<RoomsHiveModel>? roomsBox;
  Box<DevicesHiveModel>? devicesBox;
  Box<RemotePipesHiveModel>? remotePipesBox;
  Box<ScenesHiveModel>? scenesBox;
  Box<RoutinesHiveModel>? routinesBox;
  Box<BindingsHiveModel>? bindingsBox;
  Box<TuyaVendorCredentialsHiveModel>? tuyaVendorCredentialsBox;
  Box<TuyaVendorCredentialsHiveModel>? smartLifeVendorCredentialsBox;
  Box<TuyaVendorCredentialsHiveModel>? jinvooSmartVendorCredentialsBox;
  Box<LifxVendorCredentialsHiveModel>? lifxVendorCredentialsBox;
  Box<EspHomeVendorCredentialsHiveModel>? espHomeVendorCredentialsBox;
  Box<XiaomiMiVendorCredentialsHiveModel>? xiaomiMiVendorCredentialsBox;
  Box<EwelinkVendorCredentialsHiveModel>? ewelinkVendorCredentialsBox;

  @override
  Future<void> loadFromDb() async {
    (await getRemotePipesDnsName()).fold(
        (l) =>
            logger.w('No Remote Pipes Dns name was found in the local storage'),
        (r) {
      getIt<IAppCommunicationRepository>().startRemotePipesConnection(r);

      logger.i('Remote Pipes DNS name was "$r" found');
    });

    {
      await tuyaVendorCredentialsBox?.close();

      tuyaVendorCredentialsBox =
          await Hive.openBox<TuyaVendorCredentialsHiveModel>(
        tuyaVendorCredentialsBoxName,
      );

      final List<TuyaVendorCredentialsHiveModel>
          tuyaVendorCredentialsModelFromDb = tuyaVendorCredentialsBox!.values
              .toList()
              .cast<TuyaVendorCredentialsHiveModel>();
      await tuyaVendorCredentialsBox?.close();

      (await getTuyaVendorLoginCredentials(
        tuyaVendorCredentialsModelFromDb: tuyaVendorCredentialsModelFromDb,
        vendorBoxName: tuyaVendorCredentialsBoxName,
      ))
          .fold((l) {}, (r) {
        CompaniesConnectorConjector.setVendorLoginCredentials(r);

        logger.i(
          'Tuya login credentials user name ${r.tuyaUserName.getOrCrash()} found',
        );
      });
    }

    {
      await smartLifeVendorCredentialsBox?.close();

      smartLifeVendorCredentialsBox =
          await Hive.openBox<TuyaVendorCredentialsHiveModel>(
        smartLifeVendorCredentialsBoxName,
      );

      final List<TuyaVendorCredentialsHiveModel>
          tuyaVendorCredentialsModelFromDb = smartLifeVendorCredentialsBox!
              .values
              .toList()
              .cast<TuyaVendorCredentialsHiveModel>();
      await smartLifeVendorCredentialsBox?.close();
      (await getTuyaVendorLoginCredentials(
        tuyaVendorCredentialsModelFromDb: tuyaVendorCredentialsModelFromDb,
        vendorBoxName: smartLifeVendorCredentialsBoxName,
      ))
          .fold((l) {}, (r) {
        CompaniesConnectorConjector.setVendorLoginCredentials(r);

        logger.i(
          'Smart Life login credentials user name ${r.tuyaUserName.getOrCrash()} found',
        );
      });
    }

    {
      await jinvooSmartVendorCredentialsBox?.close();

      jinvooSmartVendorCredentialsBox =
          await Hive.openBox<TuyaVendorCredentialsHiveModel>(
        jinvooSmartVendorCredentialsBoxName,
      );

      final List<TuyaVendorCredentialsHiveModel>
          tuyaVendorCredentialsModelFromDb = jinvooSmartVendorCredentialsBox!
              .values
              .toList()
              .cast<TuyaVendorCredentialsHiveModel>();
      await jinvooSmartVendorCredentialsBox?.close();

      (await getTuyaVendorLoginCredentials(
        tuyaVendorCredentialsModelFromDb: tuyaVendorCredentialsModelFromDb,
        vendorBoxName: jinvooSmartVendorCredentialsBoxName,
      ))
          .fold((l) {}, (r) {
        CompaniesConnectorConjector.setVendorLoginCredentials(r);

        logger.i(
          'Jinvoo Smart login credentials user name ${r.tuyaUserName.getOrCrash()} found',
        );
      });
    }

    {
      await lifxVendorCredentialsBox?.close();

      lifxVendorCredentialsBox =
          await Hive.openBox<LifxVendorCredentialsHiveModel>(
        lifxVendorCredentialsBoxName,
      );

      final List<LifxVendorCredentialsHiveModel>
          lifxVendorCredentialsModelFromDb = lifxVendorCredentialsBox!.values
              .toList()
              .cast<LifxVendorCredentialsHiveModel>();
      await lifxVendorCredentialsBox?.close();

      (await getLifxVendorLoginCredentials(
        lifxVendorCredentialsModelFromDb: lifxVendorCredentialsModelFromDb,
      ))
          .fold((l) {}, (r) {
        CompaniesConnectorConjector.setVendorLoginCredentials(r);

        logger.i(
          'Lifx login credentials got found in DB',
        );
      });
    }

    {
      await espHomeVendorCredentialsBox?.close();

      espHomeVendorCredentialsBox =
          await Hive.openBox<EspHomeVendorCredentialsHiveModel>(
        espHomeVendorCredentialsBoxName,
      );

      final List<EspHomeVendorCredentialsHiveModel>
          espHomeVendorCredentialsModelFromDb = espHomeVendorCredentialsBox!
              .values
              .toList()
              .cast<EspHomeVendorCredentialsHiveModel>();
      await espHomeVendorCredentialsBox?.close();

      (await getEspHomeVendorLoginCredentials(
        espHomeVendorCredentialsModelFromDb:
            espHomeVendorCredentialsModelFromDb,
      ))
          .fold((l) {}, (r) {
        CompaniesConnectorConjector.setVendorLoginCredentials(r);

        logger.i(
          'ESPHome device password got found in DB',
        );
      });
    }

    /// Xiaomi Mi
    {
      await xiaomiMiVendorCredentialsBox?.close();

      xiaomiMiVendorCredentialsBox =
          await Hive.openBox<XiaomiMiVendorCredentialsHiveModel>(
        xiaomiMiVendorCredentialsBoxName,
      );

      final List<XiaomiMiVendorCredentialsHiveModel>
          xiaomiMiVendorCredentialsModelFromDb = xiaomiMiVendorCredentialsBox!
              .values
              .toList()
              .cast<XiaomiMiVendorCredentialsHiveModel>();
      await xiaomiMiVendorCredentialsBox?.close();

      (await getXiaomiMiVendorLoginCredentials(
        xiaomiMiVendorCredentialsModelFromDb:
            xiaomiMiVendorCredentialsModelFromDb,
      ))
          .fold((l) {}, (r) {
        CompaniesConnectorConjector.setVendorLoginCredentials(r);

        logger.i(
          'Xiaomi Mi device password got found in DB',
        );
      });
    }

    /// eWeLink
    {
      await ewelinkVendorCredentialsBox?.close();

      ewelinkVendorCredentialsBox =
          await Hive.openBox<EwelinkVendorCredentialsHiveModel>(
        ewelinkVendorCredentialsBoxName,
      );

      final List<EwelinkVendorCredentialsHiveModel>
          ewelinkVendorCredentialsModelFromDb = ewelinkVendorCredentialsBox!
              .values
              .toList()
              .cast<EwelinkVendorCredentialsHiveModel>();
      await ewelinkVendorCredentialsBox?.close();

      (await getEwelinkVendorLoginCredentials(
        ewelinkVendorCredentialsModelFromDb:
            ewelinkVendorCredentialsModelFromDb,
      ))
          .fold((l) {}, (r) {
        CompaniesConnectorConjector.setVendorLoginCredentials(r);

        logger.i(
          'EweLink account email and password got found in DB',
        );
      });
    }

    // Rooms need to stay first one
    await getIt<ISavedRoomsRepo>().setUpAllFromDb();
    await getIt<ISceneCbjRepository>().setUpAllFromDb();
    await getIt<IRoutineCbjRepository>().setUpAllFromDb();
    await getIt<IBindingCbjRepository>().setUpAllFromDb();
    await getIt<ISavedDevicesRepo>().setUpAllFromDb();
  }

  @override
  Future<Either<LocalDbFailures, List<RoomEntity>>> getRoomsFromDb() async {
    final List<RoomEntity> rooms = <RoomEntity>[];

    try {
      await roomsBox?.close();
      roomsBox = await Hive.openBox<RoomsHiveModel>(roomsBoxName);
      final List<RoomsHiveModel> roomsHiveModelFromDb =
          roomsBox!.values.toList().cast<RoomsHiveModel>();

      await roomsBox?.close();
      for (final RoomsHiveModel roomHive in roomsHiveModelFromDb) {
        final RoomEntity roomEntity = RoomEntity(
          uniqueId: RoomUniqueId.fromUniqueString(roomHive.roomUniqueId),
          cbjEntityName: RoomDefaultName(roomHive.roomDefaultName),
          background: RoomBackground(roomHive.roomBackground),
          roomTypes: RoomTypes(roomHive.roomTypes),
          roomDevicesId: RoomDevicesId(roomHive.roomDevicesId),
          roomScenesId: RoomScenesId(roomHive.roomScenesId),
          roomRoutinesId: RoomRoutinesId(roomHive.roomRoutinesId),
          roomBindingsId: RoomBindingsId(roomHive.roomBindingsId),
          roomMostUsedBy: RoomMostUsedBy(roomHive.roomMostUsedBy),
          roomPermissions: RoomPermissions(roomHive.roomPermissions),
        );
        rooms.add(roomEntity);
      }
    } catch (e) {
      logger.e('Local DB hive error while getting rooms: $e');
      // TODO: Check why hive crash stop this from working
      await deleteAllSavedRooms();
    }

    return right(rooms);
  }

  @override
  Future<Either<LocalDbFailures, List<DeviceEntityAbstract>>>
      getSmartDevicesFromDb() async {
    final List<DeviceEntityAbstract> devices = <DeviceEntityAbstract>[];

    try {
      await devicesBox?.close();
      devicesBox = await Hive.openBox<DevicesHiveModel>(devicesBoxName);

      final List<DevicesHiveModel> devicesHiveModelFromDb =
          devicesBox!.values.toList().cast<DevicesHiveModel>();

      await devicesBox?.close();

      for (final DevicesHiveModel deviceHive in devicesHiveModelFromDb) {
        final DeviceEntityAbstract deviceEntity =
            DeviceHelper.convertJsonStringToDomain(deviceHive.deviceStringJson);

        devices.add(
          deviceEntity
            ..entityStateGRPC =
                EntityState(EntityStateGRPC.waitingInComp.toString()),
        );
      }
      return right(devices);
    } catch (e) {
      logger.e('Local DB hive error while getting devices: $e');
    }
    return left(const LocalDbFailures.unexpected());
  }

  @override
  Future<Either<LocalDbFailures, String>> getHubEntityLastKnownIp() async {
    // TODO: implement getHubEntityLastKnownIp
    throw UnimplementedError();
  }

  @override
  Future<Either<LocalDbFailures, String>> getHubEntityNetworkBssid() async {
    // TODO: implement getHubEntityNetworkBssid
    throw UnimplementedError();
  }

  @override
  Future<Either<LocalDbFailures, String>> getHubEntityNetworkName() async {
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
    try {
      if (tuyaVendorCredentialsModelFromDb.isNotEmpty) {
        final TuyaVendorCredentialsHiveModel firstTuyaVendorFromDB =
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
      // logger.i(
      //   "Didn't find any Tuya in the local DB",
      // );
    } catch (e) {
      logger.e('Local DB hive error while getting Tuya vendor: $e');
    }
    return left(const LocalDbFailures.unexpected());
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
      // logger.i(
      //   "Didn't find any Lifx in the local DB",
      // );
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
      // logger.i(
      //   "Didn't find any ESPHome in the local DB",
      // );
    } catch (e) {
      logger.e('Local DB hive error while getting ESPHome vendor: $e');
    }
    return left(const LocalDbFailures.unexpected());
  }

  @override
  Future<Either<LocalDbFailures, GenericXiaomiMiLoginDE>>
      getXiaomiMiVendorLoginCredentials({
    required List<XiaomiMiVendorCredentialsHiveModel>
        xiaomiMiVendorCredentialsModelFromDb,
  }) async {
    try {
      if (xiaomiMiVendorCredentialsModelFromDb.isNotEmpty) {
        final XiaomiMiVendorCredentialsHiveModel firstXiaomiMiVendorFromDB =
            xiaomiMiVendorCredentialsModelFromDb[0];

        final String? senderUniqueId = firstXiaomiMiVendorFromDB.senderUniqueId;
        final String xiaomiMiAccountEmail =
            firstXiaomiMiVendorFromDB.xiaomiMiAccountEmail;
        final String xiaomiMiAccountPass =
            firstXiaomiMiVendorFromDB.xiaomiMiAccountPass;

        final GenericXiaomiMiLoginDE genericXiaomiMiLoginDE =
            GenericXiaomiMiLoginDE(
          senderUniqueId: CoreLoginSenderId.fromUniqueString(senderUniqueId),
          xiaomiMiAccountEmail:
              GenericXiaomiMiAccountEmail(xiaomiMiAccountEmail),
          xiaomiMiAccountPass: GenericXiaomiMiAccountPass(xiaomiMiAccountPass),
        );

        logger.i(
          'Xiaomi Mi got returned from local storage',
        );
        return right(genericXiaomiMiLoginDE);
      }
      // logger.i(
      //   "Didn't find any Xiaomi Mi in the local DB",
      // );
    } catch (e) {
      logger.e('Local DB hive error while getting Xiaomi Mi vendor: $e');
    }
    return left(const LocalDbFailures.unexpected());
  }

  @override
  Future<Either<LocalDbFailures, GenericEwelinkLoginDE>>
      getEwelinkVendorLoginCredentials({
    required List<EwelinkVendorCredentialsHiveModel>
        ewelinkVendorCredentialsModelFromDb,
  }) async {
    try {
      if (ewelinkVendorCredentialsModelFromDb.isNotEmpty) {
        final EwelinkVendorCredentialsHiveModel firstEwelinkVendorFromDB =
            ewelinkVendorCredentialsModelFromDb[0];

        final String? senderUniqueId = firstEwelinkVendorFromDB.senderUniqueId;
        final String ewelinkAccountEmail =
            firstEwelinkVendorFromDB.ewelinkAccountEmail;
        final String ewelinkAccountPass =
            firstEwelinkVendorFromDB.ewelinkAccountPass;

        final GenericEwelinkLoginDE genericEwelinkLoginDE =
            GenericEwelinkLoginDE(
          senderUniqueId: CoreLoginSenderId.fromUniqueString(senderUniqueId),
          ewelinkAccountEmail: GenericEwelinkAccountEmail(ewelinkAccountEmail),
          ewelinkAccountPass: GenericEwelinkAccountPass(ewelinkAccountPass),
        );

        logger.i(
          'EweLink got returned from local storage',
        );
        return right(genericEwelinkLoginDE);
      }
      // logger.i(
      //   "Didn't find any Xiaomi Mi in the local DB",
      // );
    } catch (e) {
      logger.e('Local DB hive error while getting Xiaomi Mi vendor: $e');
    }
    return left(const LocalDbFailures.unexpected());
  }

  @override
  Future<Either<LocalDbFailures, String>> getRemotePipesDnsName() async {
    try {
      await remotePipesBox?.close();
      remotePipesBox =
          await Hive.openBox<RemotePipesHiveModel>(remotePipesBoxName);
      final List<RemotePipesHiveModel> remotePipesHiveModelFromDb =
          remotePipesBox!.values.toList().cast<RemotePipesHiveModel>();
      await remotePipesBox?.close();

      if (remotePipesHiveModelFromDb.isNotEmpty) {
        final String remotePipesDnsName =
            remotePipesHiveModelFromDb[0].domainName;

        logger.i(
          'Remote pipes domain name is: '
          '$remotePipesDnsName',
        );
        return right(remotePipesDnsName);
      }
      logger.i("Didn't find any remote pipes in the local DB");
    } catch (e) {
      logger.e('Local DB hive error while getting Remote Pipes: $e');
    }
    return left(const LocalDbFailures.unexpected());
  }

  @override
  Future<Either<LocalDbFailures, Unit>> saveSmartDevices({
    required List<DeviceEntityAbstract> deviceList,
  }) async {
    try {
      final List<DevicesHiveModel> devicesHiveList = [];

      final List<String> devicesListStringJson = List<String>.from(
        deviceList.map((e) => DeviceHelper.convertDomainToJsonString(e)),
      );

      for (final String devicesEntityDtosJsonString in devicesListStringJson) {
        final DevicesHiveModel devicesHiveModel = DevicesHiveModel()
          ..deviceStringJson = devicesEntityDtosJsonString;
        devicesHiveList.add(devicesHiveModel);
      }

      await devicesBox?.close();
      devicesBox = await Hive.openBox<DevicesHiveModel>(devicesBoxName);
      await devicesBox?.clear();
      await devicesBox?.addAll(devicesHiveList);

      await devicesBox?.close();
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
    try {
      final List<RoomsHiveModel> rommsHiveList = [];

      final List<RoomEntityDtos> roomsListDto =
          List<RoomEntityDtos>.from(roomsList.map((e) => e.toInfrastructure()));

      for (final RoomEntityDtos roomEntityDtos in roomsListDto) {
        final RoomsHiveModel roomsHiveModel = RoomsHiveModel()
          ..roomUniqueId = roomEntityDtos.uniqueId
          ..roomDefaultName = roomEntityDtos.cbjEntityName
          ..roomBackground = roomEntityDtos.background
          ..roomDevicesId = roomEntityDtos.roomDevicesId
          ..roomScenesId = roomEntityDtos.roomScenesId
          ..roomRoutinesId = roomEntityDtos.roomRoutinesId
          ..roomBindingsId = roomEntityDtos.roomBindingsId
          ..roomMostUsedBy = roomEntityDtos.roomMostUsedBy
          ..roomPermissions = roomEntityDtos.roomPermissions
          ..roomTypes = roomEntityDtos.roomTypes;
        rommsHiveList.add(roomsHiveModel);
      }

      await roomsBox?.close();
      roomsBox = await Hive.openBox<RoomsHiveModel>(roomsBoxName);

      await roomsBox?.clear();
      await roomsBox?.addAll(rommsHiveList);

      await roomsBox?.close();
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
    // TODO: implement saveHubEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<LocalDbFailures, Unit>> saveVendorLoginCredentials({
    required LoginEntityAbstract loginEntityAbstract,
  }) async {
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
    } else if (loginEntityAbstract is GenericLifxLoginDE) {
      saveLifxVendorCredentials(
        lifxLoginDE: loginEntityAbstract,
        vendorCredentialsBoxName: lifxVendorCredentialsBoxName,
      );
    } else if (loginEntityAbstract is GenericEspHomeLoginDE) {
      saveEspHomeVendorCredentials(
        espHomeLoginDE: loginEntityAbstract,
        vendorCredentialsBoxName: espHomeVendorCredentialsBoxName,
      );
    } else if (loginEntityAbstract is GenericXiaomiMiLoginDE) {
      saveXiaomiMiVendorCredentials(
        xiaomiMiLoginDE: loginEntityAbstract,
        vendorCredentialsBoxName: xiaomiMiVendorCredentialsBoxName,
      );
    } else if (loginEntityAbstract is GenericEwelinkLoginDE) {
      saveEwelinkVendorCredentials(
        ewelinkLoginDE: loginEntityAbstract,
        vendorCredentialsBoxName: ewelinkVendorCredentialsBoxName,
      );
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
    try {
      await remotePipesBox?.close();
      remotePipesBox =
          await Hive.openBox<RemotePipesHiveModel>(remotePipesBoxName);
      final RemotePipesHiveModel remotePipesHiveModel = RemotePipesHiveModel()
        ..domainName = remotePipesDomainName;

      if (remotePipesBox!.isNotEmpty) {
        await remotePipesBox!.putAt(0, remotePipesHiveModel);
      } else {
        remotePipesBox!.add(remotePipesHiveModel);
      }

      await remotePipesBox?.close();
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
    try {
      final Box<TuyaVendorCredentialsHiveModel> tuyaVendorCredentialsBox =
          await Hive.openBox<TuyaVendorCredentialsHiveModel>(
        vendorCredentialsBoxName,
      );

      final TuyaVendorCredentialsHiveModel tuyaVendorCredentialsModel =
          TuyaVendorCredentialsHiveModel()
            ..senderUniqueId = tuyaLoginDE.senderUniqueId.getOrCrash()
            ..tuyaUserName = tuyaLoginDE.tuyaUserName.getOrCrash()
            ..tuyaUserPassword = tuyaLoginDE.tuyaUserPassword.getOrCrash()
            ..tuyaCountryCode = tuyaLoginDE.tuyaCountryCode.getOrCrash()
            ..tuyaBizType = tuyaLoginDE.tuyaBizType.getOrCrash()
            ..tuyaRegion = tuyaLoginDE.tuyaRegion.getOrCrash()
            ..loginVendor = tuyaLoginDE.loginVendor.getOrCrash();

      if (tuyaVendorCredentialsBox.isNotEmpty) {
        await tuyaVendorCredentialsBox.putAt(0, tuyaVendorCredentialsModel);
      } else {
        tuyaVendorCredentialsBox.add(tuyaVendorCredentialsModel);
      }

      await tuyaVendorCredentialsBox.close();
      logger.i(
        'Tuya vendor credentials saved to local storage with the user name: '
        '${tuyaLoginDE.tuyaUserName.getOrCrash()}',
      );
    } catch (e) {
      logger.e('Error saving Tuya vendor credentials to local storage');
      return left(const LocalDbFailures.unexpected());
    }
    return right(unit);
  }

  Future<Either<LocalDbFailures, Unit>> saveLifxVendorCredentials({
    required GenericLifxLoginDE lifxLoginDE,
    required String vendorCredentialsBoxName,
  }) async {
    try {
      final Box<LifxVendorCredentialsHiveModel> lifxVendorCredentialsBox =
          await Hive.openBox<LifxVendorCredentialsHiveModel>(
        vendorCredentialsBoxName,
      );

      final LifxVendorCredentialsHiveModel lifxVendorCredentialsModel =
          LifxVendorCredentialsHiveModel()
            ..senderUniqueId = lifxLoginDE.senderUniqueId.getOrCrash()
            ..lifxApiKey = lifxLoginDE.lifxApiKey.getOrCrash();

      if (lifxVendorCredentialsBox.isNotEmpty) {
        await lifxVendorCredentialsBox.putAt(0, lifxVendorCredentialsModel);
      } else {
        lifxVendorCredentialsBox.add(lifxVendorCredentialsModel);
      }

      await lifxVendorCredentialsBox.close();
      logger.i(
        'Lifx vendor credentials saved to local storage',
      );
    } catch (e) {
      logger.e('Error saving Lifx vendor credentials to local storage');
      return left(const LocalDbFailures.unexpected());
    }
    return right(unit);
  }

  Future<Either<LocalDbFailures, Unit>> saveEspHomeVendorCredentials({
    required GenericEspHomeLoginDE espHomeLoginDE,
    required String vendorCredentialsBoxName,
  }) async {
    try {
      final Box<EspHomeVendorCredentialsHiveModel> espHomeVendorCredentialsBox =
          await Hive.openBox<EspHomeVendorCredentialsHiveModel>(
        vendorCredentialsBoxName,
      );

      final EspHomeVendorCredentialsHiveModel espHomeVendorCredentialsModel =
          EspHomeVendorCredentialsHiveModel()
            ..senderUniqueId = espHomeLoginDE.senderUniqueId.getOrCrash()
            ..espHomeDevicePass = espHomeLoginDE.espHomeDevicePass.getOrCrash();

      if (espHomeVendorCredentialsBox.isNotEmpty) {
        await espHomeVendorCredentialsBox.putAt(
            0, espHomeVendorCredentialsModel);
      } else {
        espHomeVendorCredentialsBox.add(espHomeVendorCredentialsModel);
      }

      await espHomeVendorCredentialsBox.close();
      logger.i(
        'ESPHome vendor credentials saved to local storage',
      );
    } catch (e) {
      logger.e('Error saving ESPHome vendor credentials to local storage');
      return left(const LocalDbFailures.unexpected());
    }
    return right(unit);
  }

  Future<Either<LocalDbFailures, Unit>> saveXiaomiMiVendorCredentials({
    required GenericXiaomiMiLoginDE xiaomiMiLoginDE,
    required String vendorCredentialsBoxName,
  }) async {
    try {
      final Box<XiaomiMiVendorCredentialsHiveModel>
          xiaomiMiVendorCredentialsBox =
          await Hive.openBox<XiaomiMiVendorCredentialsHiveModel>(
        vendorCredentialsBoxName,
      );

      final XiaomiMiVendorCredentialsHiveModel xiaomiMiVendorCredentialsModel =
          XiaomiMiVendorCredentialsHiveModel()
            ..senderUniqueId = xiaomiMiLoginDE.senderUniqueId.getOrCrash()
            ..xiaomiMiAccountEmail =
                xiaomiMiLoginDE.xiaomiMiAccountEmail.getOrCrash()
            ..xiaomiMiAccountPass =
                xiaomiMiLoginDE.xiaomiMiAccountPass.getOrCrash();

      if (xiaomiMiVendorCredentialsBox.isNotEmpty) {
        await xiaomiMiVendorCredentialsBox.putAt(
            0, xiaomiMiVendorCredentialsModel);
      } else {
        xiaomiMiVendorCredentialsBox.add(xiaomiMiVendorCredentialsModel);
      }

      await xiaomiMiVendorCredentialsBox.close();
      logger.i(
        'Xiaomi Mi vendor credentials saved to local storage',
      );
    } catch (e) {
      logger.e('Error saving Xiaomi Mi vendor credentials to local storage');
      return left(const LocalDbFailures.unexpected());
    }
    return right(unit);
  }

  Future<Either<LocalDbFailures, Unit>> saveEwelinkVendorCredentials({
    required GenericEwelinkLoginDE ewelinkLoginDE,
    required String vendorCredentialsBoxName,
  }) async {
    try {
      final Box<EwelinkVendorCredentialsHiveModel> ewelinkVendorCredentialsBox =
          await Hive.openBox<EwelinkVendorCredentialsHiveModel>(
        vendorCredentialsBoxName,
      );

      final EwelinkVendorCredentialsHiveModel ewelinkVendorCredentialsModel =
          EwelinkVendorCredentialsHiveModel()
            ..senderUniqueId = ewelinkLoginDE.senderUniqueId.getOrCrash()
            ..ewelinkAccountEmail =
                ewelinkLoginDE.ewelinkAccountEmail.getOrCrash()
            ..ewelinkAccountPass =
                ewelinkLoginDE.ewelinkAccountPass.getOrCrash();

      if (ewelinkVendorCredentialsBox.isNotEmpty) {
        await ewelinkVendorCredentialsBox.putAt(
            0, ewelinkVendorCredentialsModel);
      } else {
        ewelinkVendorCredentialsBox.add(ewelinkVendorCredentialsModel);
      }

      await ewelinkVendorCredentialsBox.close();
      logger.i(
        'EweLink vendor credentials saved to local storage',
      );
    } catch (e) {
      logger.e('Error saving EweLink vendor credentials to local storage');
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
    final List<SceneCbjEntity> scenes = <SceneCbjEntity>[];

    try {
      await scenesBox?.close();

      scenesBox = await Hive.openBox<ScenesHiveModel>(scenesBoxName);

      final List<ScenesHiveModel> scenesHiveModelFromDb =
          scenesBox!.values.toList().cast<ScenesHiveModel>();

      await scenesBox?.close();

      for (final ScenesHiveModel sceneHive in scenesHiveModelFromDb) {
        final SceneCbjEntity sceneEntity = SceneCbjDtos.fromJson(
          jsonDecode(sceneHive.scenesStringJson) as Map<String, dynamic>,
        ).toDomain();

        scenes.add(
          sceneEntity.copyWith(
            entityStateGRPC: SceneCbjDeviceStateGRPC(
              EntityStateGRPC.waitingInComp.toString(),
            ),
          ),
        );
      }
      return right(scenes);
    } catch (e) {
      logger.e('Local DB hive error while getting scenes: $e');
    }
    return left(const LocalDbFailures.unexpected());
  }

  @override
  Future<Either<LocalDbFailures, List<RoutineCbjEntity>>>
      getRoutinesFromDb() async {
    final List<RoutineCbjEntity> routines = <RoutineCbjEntity>[];

    try {
      await routinesBox?.close();
      routinesBox = await Hive.openBox<RoutinesHiveModel>(routinesBoxName);

      final List<RoutinesHiveModel> routinesHiveModelFromDb =
          routinesBox!.values.toList().cast<RoutinesHiveModel>();

      await routinesBox?.close();

      for (final RoutinesHiveModel routineHive in routinesHiveModelFromDb) {
        final RoutineCbjEntity routineEntity = RoutineCbjDtos.fromJson(
          jsonDecode(routineHive.routinesStringJson) as Map<String, dynamic>,
        ).toDomain();

        routines.add(
          routineEntity.copyWith(
            entityStateGRPC: RoutineCbjDeviceStateGRPC(
              EntityStateGRPC.waitingInComp.toString(),
            ),
          ),
        );
      }
      return right(routines);
    } catch (e) {
      logger.e('Local DB hive error while getting routines: $e');
    }
    return left(const LocalDbFailures.unexpected());
  }

  @override
  Future<Either<LocalDbFailures, List<BindingCbjEntity>>>
      getBindingsFromDb() async {
    final List<BindingCbjEntity> bindings = <BindingCbjEntity>[];

    try {
      await bindingsBox?.close();
      bindingsBox = await Hive.openBox<BindingsHiveModel>(bindingsBoxName);

      final List<BindingsHiveModel> bindingsHiveModelFromDb =
          bindingsBox!.values.toList().cast<BindingsHiveModel>();

      await bindingsBox?.close();

      for (final BindingsHiveModel bindingHive in bindingsHiveModelFromDb) {
        final BindingCbjEntity bindingEntity = BindingCbjDtos.fromJson(
          jsonDecode(bindingHive.bindingsStringJson) as Map<String, dynamic>,
        ).toDomain();

        bindings.add(
          bindingEntity.copyWith(
            entityStateGRPC: BindingCbjDeviceStateGRPC(
              EntityStateGRPC.waitingInComp.toString(),
            ),
          ),
        );
      }
      return right(bindings);
    } catch (e) {
      logger.e('Local DB hive error while getting bindings: $e');
    }
    return left(const LocalDbFailures.unexpected());
  }

  @override
  Future<Either<LocalDbFailures, Unit>> saveScenes({
    required List<SceneCbjEntity> sceneList,
  }) async {
    try {
      final List<ScenesHiveModel> scenesHiveList = [];

      final List<String> scenesListStringJson = List<String>.from(
        sceneList.map((e) => jsonEncode(e.toInfrastructure().toJson())),
      );

      for (final String scenesEntityDtosJsonString in scenesListStringJson) {
        final ScenesHiveModel scenesHiveModel = ScenesHiveModel()
          ..scenesStringJson = scenesEntityDtosJsonString;
        scenesHiveList.add(scenesHiveModel);
      }

      await scenesBox?.close();
      scenesBox = await Hive.openBox<ScenesHiveModel>(scenesBoxName);

      await scenesBox?.clear();
      await scenesBox?.addAll(scenesHiveList);

      await scenesBox?.close();
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
    try {
      final List<RoutinesHiveModel> routinesHiveList = [];

      final List<String> routinesListStringJson = List<String>.from(
        routineList.map((e) => jsonEncode(e.toInfrastructure().toJson())),
      );

      for (final String routinesEntityDtosJsonString
          in routinesListStringJson) {
        final RoutinesHiveModel routinesHiveModel = RoutinesHiveModel()
          ..routinesStringJson = routinesEntityDtosJsonString;
        routinesHiveList.add(routinesHiveModel);
      }

      await routinesBox?.close();
      routinesBox = await Hive.openBox<RoutinesHiveModel>(routinesBoxName);

      await routinesBox?.clear();
      await routinesBox?.addAll(routinesHiveList);

      await routinesBox?.close();
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
    try {
      final List<BindingsHiveModel> bindingsHiveList = [];

      final List<String> bindingsListStringJson = List<String>.from(
        bindingList.map((e) => jsonEncode(e.toInfrastructure().toJson())),
      );

      for (final String bindingsEntityDtosJsonString
          in bindingsListStringJson) {
        final BindingsHiveModel bindingsHiveModel = BindingsHiveModel()
          ..bindingsStringJson = bindingsEntityDtosJsonString;
        bindingsHiveList.add(bindingsHiveModel);
      }

      await bindingsBox?.close();

      bindingsBox = await Hive.openBox<BindingsHiveModel>(bindingsBoxName);

      await bindingsBox?.clear();
      await bindingsBox?.addAll(bindingsHiveList);

      await bindingsBox?.close();
      logger.i('Bindings got saved to local storage');
    } catch (e) {
      logger.e('Error saving Bindings to local storage\n$e');
      return left(const LocalDbFailures.unexpected());
    }

    return right(unit);
  }
}
