import 'dart:async';
import 'dart:convert';

import 'package:cbj_hub/domain/app_communication/i_app_communication_repository.dart';
import 'package:cbj_hub/infrastructure/app_communication/app_communication_repository.dart';
import 'package:cbj_hub/utils.dart';
import 'package:cbj_integrations_controller/infrastructure/devices/device_helper/device_helper.dart';
import 'package:cbj_integrations_controller/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_integrations_controller/infrastructure/generic_devices/abstract_device/device_entity_dto_abstract.dart';
import 'package:cbj_integrations_controller/infrastructure/generic_devices/generic_ping_device/generic_ping_device_dtos.dart';
import 'package:cbj_integrations_controller/infrastructure/generic_devices/generic_ping_device/generic_ping_entity.dart';
import 'package:cbj_integrations_controller/infrastructure/room/room_entity_dtos.dart';
import 'package:cbj_integrations_controller/infrastructure/routines/routine_cbj_dtos.dart';
import 'package:cbj_integrations_controller/infrastructure/scenes/scene_cbj_dtos.dart';
import 'package:grpc/grpc.dart';
import 'package:rxdart/rxdart.dart';

class RemotePipesClient {
  static ClientChannel? channel;
  static CbjHubClient? stub;
  static Timer? grpcKeepAlive;

  // createStreamWithRemotePipes
  ///  Turn smart device on
  static Future<void> createStreamWithHub(
    String addressToHub,
    int hubPort,
  ) async {
    channel = await _createCbjHubClient(addressToHub, hubPort);
    stub = CbjHubClient(channel!);

    ResponseStream<ClientStatusRequests> response;

    grpcDartKeepAliveWorkaround(HubRequestsToApp.streamRequestsToApp);

    try {
      response = stub!.hubTransferEntities(
        /// Transfer all requests from hub to the remote pipes->app
        HubRequestsToApp.streamRequestsToApp.map((dynamic entityDtoToSend) {
          if (entityDtoToSend is DeviceEntityDtoAbstract) {
            if (entityDtoToSend is! GenericPingDeviceDtos) {
              grpcDartKeepAliveWorkaround(HubRequestsToApp.streamRequestsToApp);
            }
            return RequestsAndStatusFromHub(
              sendingType: SendingType.entityType,
              allRemoteCommands:
                  DeviceHelper.convertDtoToJsonString(entityDtoToSend),
            );
          } else if (entityDtoToSend is RoomEntityDtos) {
            return RequestsAndStatusFromHub(
              sendingType: SendingType.roomType,
              allRemoteCommands: jsonEncode(entityDtoToSend.toJson()),
            );
          } else if (entityDtoToSend is SceneCbjDtos) {
            return RequestsAndStatusFromHub(
              sendingType: SendingType.sceneType,
              allRemoteCommands: jsonEncode(entityDtoToSend.toJson()),
            );
          } else if (entityDtoToSend is RoutineCbjDtos) {
            return RequestsAndStatusFromHub(
              sendingType: SendingType.routineType,
              allRemoteCommands: jsonEncode(entityDtoToSend.toJson()),
            );
          } else {
            logger.w('Not sure what type to send');
            return RequestsAndStatusFromHub(
              sendingType: SendingType.undefinedType,
            );
          }
        }).handleError((error) {
          logger.e('Stream have error $error');
        }),
      );

      /// All responses from the app->remote pipes going int the hub
      IAppCommunicationRepository.instance.getFromApp(
        request: response,
        requestUrl: addressToHub,
        isRemotePipes: true,
      );
    } catch (e) {
      logger.e('Caught error: $e');
      await channel?.terminate();
    }
  }

  /// Workaround until gRPC dart implement keep alive
  /// https://github.com/grpc/grpc-dart/issues/157
  static Future<void> grpcDartKeepAliveWorkaround(
    BehaviorSubject<dynamic> sendRequest,
  ) async {
    grpcKeepAlive?.cancel();
    final GenericPingDE genericEmptyDE = GenericPingDE.empty();
    grpcKeepAlive = Timer.periodic(const Duration(minutes: 9), (Timer t) {
      logger.t('Ping device to Remote Pipes');
      sendRequest.add(genericEmptyDE.toInfrastructure());
    });
  }

  static Future<ClientChannel> _createCbjHubClient(
    String deviceIp,
    int hubPort,
  ) async {
    await channel?.terminate();
    return ClientChannel(
      deviceIp,
      port: hubPort,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
  }
}
