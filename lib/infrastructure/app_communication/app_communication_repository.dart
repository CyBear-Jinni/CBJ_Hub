import 'dart:async';
import 'dart:convert';

import 'package:cbj_hub/domain/app_communication/i_app_communication_repository.dart';
import 'package:cbj_hub/domain/core/value_objects.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/generic_empty_device/generic_empty_entity.dart';
import 'package:cbj_hub/domain/mqtt_server/i_mqtt_server_repository.dart';
import 'package:cbj_hub/domain/remote_pipes/remote_pipes_entity.dart';
import 'package:cbj_hub/domain/room/room_entity.dart';
import 'package:cbj_hub/domain/rooms/i_saved_rooms_repo.dart';
import 'package:cbj_hub/domain/routine/i_routine_cbj_repository.dart';
import 'package:cbj_hub/domain/routine/routine_cbj_entity.dart';
import 'package:cbj_hub/domain/routine/value_objects_routine_cbj.dart';
import 'package:cbj_hub/domain/saved_devices/i_saved_devices_repo.dart';
import 'package:cbj_hub/domain/scene/i_scene_cbj_repository.dart';
import 'package:cbj_hub/domain/scene/scene_cbj_entity.dart';
import 'package:cbj_hub/domain/scene/value_objects_scene_cbj.dart';
import 'package:cbj_hub/domain/vendors/login_abstract/login_entity_abstract.dart';
import 'package:cbj_hub/infrastructure/app_communication/hub_app_server.dart';
import 'package:cbj_hub/infrastructure/devices/device_helper/device_helper.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/infrastructure/generic_devices/abstract_device/device_entity_dto_abstract.dart';
import 'package:cbj_hub/infrastructure/generic_vendors_login/vendor_helper.dart';
import 'package:cbj_hub/infrastructure/remote_pipes/remote_pipes_client.dart';
import 'package:cbj_hub/infrastructure/remote_pipes/remote_pipes_dtos.dart';
import 'package:cbj_hub/infrastructure/room/room_entity_dtos.dart';
import 'package:cbj_hub/infrastructure/routines/routine_cbj_dtos.dart';
import 'package:cbj_hub/infrastructure/scenes/scene_cbj_dtos.dart';
import 'package:cbj_hub/injection.dart';
import 'package:cbj_hub/utils.dart';
import 'package:grpc/grpc.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:rxdart/rxdart.dart';

@LazySingleton(as: IAppCommunicationRepository)
class AppCommunicationRepository extends IAppCommunicationRepository {
  AppCommunicationRepository() {
    if (currentEnv == Env.prod) {
      hubPort = 50055;
    } else {
      hubPort = 60055;
    }
    startLocalServer();
  }

  /// Port to connect to the cbj hub, will change according to the current
  /// running environment
  late int hubPort;

  Future startLocalServer() async {
    final server = Server([HubAppServer()]);
    await server.serve(port: hubPort);
    logger.i('Hub Server listening for apps clients on port ${server.port}...');
  }

  @override
  Future<void> startRemotePipesConnection(String remotePipesDomain) async {
    const int remotePipesPort = 50056;
    RemotePipesClient.createStreamWithHub(
      remotePipesDomain,
      // 'homeservice-one-service.default.g.com',
      remotePipesPort,
    );
    await Future.delayed(const Duration(minutes: 1));
    RemotePipesClient.createStreamWithHub(
      remotePipesDomain,
      // 'homeservice-one-service.default.g.com',
      remotePipesPort,
    );

    // Here for easy find and local testing
    // RemotePipesClient.createStreamWithHub('127.0.0.1', 50056);
    logger.i(
      'Creating connection with remote pipes to the domain $remotePipesDomain'
      ' on port $remotePipesPort',
    );
  }

  @override
  Future<void> startRemotePipesWhenThereIsConnectionToWww(
    String remotePipesDomain,
  ) async {
    while (true) {
      final bool result = await InternetConnectionChecker().hasConnection;
      if (result) {
        break;
      }
      await Future.delayed(const Duration(minutes: 2));
    }
    logger.i('Internet detected, will try to reconnect to Remote Pipes');
    startRemotePipesConnection(remotePipesDomain);
  }

  @override
  void sendToApp(Stream<MqttPublishMessage> dataToSend) {
    dataToSend.listen((MqttPublishMessage event) async {
      logger.i('Got hub requests to app');

      (await getIt<ISavedDevicesRepo>().getAllDevices())
          .forEach((String id, deviceEntityToSend) {
        final DeviceEntityDtoAbstract deviceDtoAbstract =
            DeviceHelper.convertDomainToDto(deviceEntityToSend);
        HubRequestsToApp.streamRequestsToApp.sink.add(deviceDtoAbstract);
      });

      (await getIt<ISceneCbjRepository>().getAllScenesAsMap())
          .forEach((key, value) {
        HubRequestsToApp.streamRequestsToApp.sink.add(value.toInfrastructure());
      });
    });
  }

  @override
  Future<void> getFromApp({
    required Stream<ClientStatusRequests> request,
    required String requestUrl,
    required bool isRemotePipes,
  }) async {
    request.listen((event) async {
      logger.i('Got From App');

      if (event.sendingType == SendingType.deviceType) {
        final DeviceEntityAbstract deviceEntityFromApp =
            DeviceHelper.convertJsonStringToDomain(event.allRemoteCommands);

        deviceEntityFromApp.entityStateGRPC =
            EntityState(DeviceStateGRPC.waitingInComp.toString());

        getIt<IMqttServerRepository>().postToHubMqtt(
          entityFromTheApp: deviceEntityFromApp,
          gotFromApp: true,
        );
      } else if (event.sendingType == SendingType.roomType) {
        final RoomEntity roomEntityFromApp = RoomEntityDtos.fromJson(
          jsonDecode(event.allRemoteCommands) as Map<String, dynamic>,
        ).toDomain();

        getIt<ISavedRoomsRepo>().saveAndActiveRoomToDb(
          roomEntity: roomEntityFromApp,
        );

        getIt<IMqttServerRepository>().postToHubMqtt(
          entityFromTheApp: roomEntityFromApp,
          gotFromApp: true,
        );
      } else if (event.sendingType == SendingType.vendorLoginType) {
        final LoginEntityAbstract loginEntityFromApp =
            VendorHelper.convertJsonStringToDomain(event.allRemoteCommands);

        getIt<ISavedDevicesRepo>()
            .saveAndActivateVendorLoginCredentialsDomainToDb(
          loginEntity: loginEntityFromApp,
        );
      } else if (event.sendingType == SendingType.firstConnection) {
        AppCommunicationRepository.sendAllRoomsFromHubRequestsStream();
        AppCommunicationRepository.sendAllDevicesFromHubRequestsStream();
        AppCommunicationRepository.sendAllScenesFromHubRequestsStream();
      } else if (event.sendingType == SendingType.remotePipesInformation) {
        final Map<String, dynamic> jsonDecoded =
            jsonDecode(event.allRemoteCommands) as Map<String, dynamic>;

        final RemotePipesEntity remotePipes =
            RemotePipesDtos.fromJson(jsonDecoded).toDomain();

        getIt<ISavedDevicesRepo>()
            .saveAndActivateRemotePipesDomainToDb(remotePipes: remotePipes);
      } else if (event.sendingType == SendingType.sceneType) {
        final Map<String, dynamic> jsonSceneFromJsonString =
            jsonDecode(event.allRemoteCommands) as Map<String, dynamic>;

        final SceneCbjEntity sceneCbj =
            SceneCbjDtos.fromJson(jsonSceneFromJsonString).toDomain();

        final String sceneStateGrpcTemp =
            sceneCbj.entityStateGRPC.getOrCrash()!;

        sceneCbj.copyWith(
          entityStateGRPC: SceneCbjDeviceStateGRPC(
            DeviceStateGRPC.waitingInComp.toString(),
          ),
        );

        if (sceneStateGrpcTemp == DeviceStateGRPC.addingNewScene.toString()) {
          getIt<ISceneCbjRepository>().addNewSceneAndSaveInDb(sceneCbj);
        } else {
          getIt<ISceneCbjRepository>().activateScene(sceneCbj);
        }
      } else if (event.sendingType == SendingType.routineType) {
        final Map<String, dynamic> jsonRoutineFromJsonString =
            jsonDecode(event.allRemoteCommands) as Map<String, dynamic>;

        final RoutineCbjEntity routineCbj =
            RoutineCbjDtos.fromJson(jsonRoutineFromJsonString).toDomain();

        final String routineStateGrpcTemp =
            routineCbj.entityStateGRPC.getOrCrash()!;

        routineCbj.copyWith(
          entityStateGRPC: RoutineCbjDeviceStateGRPC(
            DeviceStateGRPC.waitingInComp.toString(),
          ),
        );

        if (routineStateGrpcTemp ==
            DeviceStateGRPC.addingNewRoutine.toString()) {
          getIt<IRoutineCbjRepository>()
              .addNewRoutineAndSaveItToLocalDb(routineCbj);
        } else {
          // For a way to active it manually
          // getIt<IRoutineCbjRepository>().activateRoutine(routineCbj);
        }
      } else {
        logger.w('Request from app does not support this sending device type');
      }
    }).onError((error) {
      if (error is GrpcError && error.code == 1) {
        logger.v('Client have disconnected');
      } else if (error is GrpcError && error.code == 14) {
        final String errorMessage = error.message!;

        if (error.message == null || !isRemotePipes) {
          logger.e('Client stream error without message\n$error');
        } else if (!errorMessage.contains('errorCode: 0')) {
          logger.i('Closing last stream\n$error');
        }

        /// Request reached the internet but the didn't arrive to remote pipes
        /// service
        else if (!errorMessage.contains('errno = -2')) {
          logger.e(
            'Remote Pipes service does not exist, check URL\n'
            '$error',
          );
        }

        /// Request didn't reached the internet
        else if (!errorMessage.contains('errno = -3')) {
          logger.w(
            'Device does not have network\n'
            '$error',
          );
          startRemotePipesWhenThereIsConnectionToWww(requestUrl);
        } else {
          logger.e(
            'Un none errno number\n'
            '$error',
          );
        }
      } else {
        if (error is GrpcError &&
            isRemotePipes &&
            error.message != null &&
            !error.message!.contains('errorCode: 0')) {
          logger.i('Client stream got terminated to create new one\n$error');
          startRemotePipesWhenThereIsConnectionToWww(requestUrl);
        } else {
          logger.e('Client stream error\n$error');
        }
      }
    });
  }

  /// Trigger to send all rooms from hub to app using the
  /// HubRequestsToApp stream
  static Future<void> sendAllRoomsFromHubRequestsStream() async {
    final Map<String, RoomEntity> allRooms =
        await getIt<ISavedRoomsRepo>().getAllRooms();

    if (allRooms.isNotEmpty) {
      allRooms.map((String id, RoomEntity d) {
        HubRequestsToApp.streamRequestsToApp.sink.add(d.toInfrastructure());
        return MapEntry(id, jsonEncode(d.toInfrastructure().toJson()));
      });
    } else {
      logger.w("Can't find rooms in the  local DB");
    }
  }

  /// Trigger to send all devices from hub to app using the
  /// HubRequestsToApp stream
  static Future<void> sendAllDevicesFromHubRequestsStream() async {
    final Map<String, DeviceEntityAbstract> allDevices =
        await getIt<ISavedDevicesRepo>().getAllDevices();

    final Map<String, RoomEntity> allRooms =
        await getIt<ISavedRoomsRepo>().getAllRooms();

    if (allRooms.isNotEmpty) {
      /// The delay fix this issue in gRPC for some reason
      /// https://github.com/grpc/grpc-dart/issues/558
      allRooms.map((String id, RoomEntity d) {
        HubRequestsToApp.streamRequestsToApp.sink.add(d.toInfrastructure());
        return MapEntry(id, jsonEncode(d.toInfrastructure().toJson()));
      });

      allDevices.map((String id, DeviceEntityAbstract d) {
        HubRequestsToApp.streamRequestsToApp.sink.add(d.toInfrastructure());
        return MapEntry(id, DeviceHelper.convertDomainToJsonString(d));
      });
    } else {
      logger.w("Can't find smart devices in the local DB, sending empty");
      final DeviceEntityAbstract emptyDevice = GenericEmptyDE.empty();
      HubRequestsToApp.streamRequestsToApp.sink
          .add(emptyDevice.toInfrastructure());
    }
  }

  /// Trigger to send all scenes from hub to app using the
  /// HubRequestsToApp stream
  static Future<void> sendAllScenesFromHubRequestsStream() async {
    final Map<String, SceneCbjEntity> allScenes =
        await getIt<ISceneCbjRepository>().getAllScenesAsMap();

    if (allScenes.isNotEmpty) {
      allScenes.map((String id, SceneCbjEntity d) {
        HubRequestsToApp.streamRequestsToApp.sink.add(d.toInfrastructure());
        return MapEntry(id, jsonEncode(d.toInfrastructure().toJson()));
      });
    } else {
      logger.w("Can't find any scenes in the local DB, sending empty");
      final SceneCbjEntity emptyScene = SceneCbjEntity(
        uniqueId: UniqueId(),
        name: SceneCbjName('Empty'),
        backgroundColor: SceneCbjBackgroundColor(000.toString()),
        image: SceneCbjBackgroundImage(null),
        iconCodePoint: SceneCbjIconCodePoint(null),
        automationString: SceneCbjAutomationString(null),
        nodeRedFlowId: SceneCbjNodeRedFlowId(null),
        firstNodeId: SceneCbjFirstNodeId(null),
        lastDateOfExecute: SceneCbjLastDateOfExecute(null),
        entityStateGRPC:
            SceneCbjDeviceStateGRPC(DeviceStateGRPC.ack.toString()),
        senderDeviceModel: SceneCbjSenderDeviceModel(null),
        senderDeviceOs: SceneCbjSenderDeviceOs(null),
        senderId: SceneCbjSenderId(null),
        compUuid: SceneCbjCompUuid(null),
        stateMassage: SceneCbjStateMassage(null),
      );
      HubRequestsToApp.streamRequestsToApp.sink
          .add(emptyScene.toInfrastructure());
    }
  }
}

/// Connect all streams from the internet devices into one stream that will be
/// send to mqtt broker to update devices states
class HubRequestsToApp {
  static BehaviorSubject<dynamic> streamRequestsToApp =
      BehaviorSubject<dynamic>();
}

/// Requests and updates from app to the hub
class AppRequestsToHub {
  /// Stream controller of the requests from the hub
  static final appRequestsToHubStreamController =
      StreamController<RequestsAndStatusFromHub>();

  /// Stream of the requests from the hub
  static Stream<RequestsAndStatusFromHub> get appRequestsToHubStream =>
      appRequestsToHubStreamController.stream;
}
