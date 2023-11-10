import 'dart:convert';
import 'dart:io';

import 'package:cbj_hub/domain/app_communication/i_app_communication_repository.dart';
import 'package:cbj_hub/infrastructure/app_communication/app_communication_repository.dart';
import 'package:cbj_hub/utils.dart';
import 'package:cbj_integrations_controller/infrastructure/devices/device_helper/device_helper.dart';
import 'package:cbj_integrations_controller/infrastructure/gen/cbj_hub_server/proto_gen_date.dart';
import 'package:cbj_integrations_controller/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_integrations_controller/infrastructure/generic_devices/abstract_device/device_entity_dto_abstract.dart';
import 'package:cbj_integrations_controller/infrastructure/room/room_entity_dtos.dart';
import 'package:cbj_integrations_controller/infrastructure/routines/routine_cbj_dtos.dart';
import 'package:cbj_integrations_controller/infrastructure/scenes/scene_cbj_dtos.dart';
import 'package:grpc/service_api.dart';

/// Server to get and send information to the app
class HubAppServer extends CbjHubServiceBase {
  @override
  Stream<RequestsAndStatusFromHub> clientTransferEntities(
    ServiceCall call,
    Stream<ClientStatusRequests> request,
  ) async* {
    try {
      logger.t('Got new Client');

      IAppCommunicationRepository.instance.getFromApp(
        request: request,
        requestUrl: 'Error, Hub does not suppose to have request URL',
        isRemotePipes: false,
      );

      yield* HubRequestsToApp.streamRequestsToApp.map((dynamic entityDto) {
        if (entityDto is DeviceEntityDtoAbstract) {
          return RequestsAndStatusFromHub(
            sendingType: SendingType.entityType,
            allRemoteCommands: DeviceHelper.convertDtoToJsonString(entityDto),
          );
        } else if (entityDto is RoomEntityDtos) {
          return RequestsAndStatusFromHub(
            sendingType: SendingType.roomType,
            allRemoteCommands: jsonEncode(entityDto.toJson()),
          );
        } else if (entityDto is SceneCbjDtos) {
          return RequestsAndStatusFromHub(
            sendingType: SendingType.sceneType,
            allRemoteCommands: jsonEncode(entityDto.toJson()),
          );
        } else if (entityDto is RoutineCbjDtos) {
          return RequestsAndStatusFromHub(
            sendingType: SendingType.routineType,
            allRemoteCommands: jsonEncode(entityDto.toJson()),
          );
        } else {
          return RequestsAndStatusFromHub(
            sendingType: SendingType.undefinedType,
            allRemoteCommands: '',
          );
        }
      }).handleError((error) => logger.e('Stream have error $error'));
    } catch (e) {
      logger.e('Hub server error $e');
    }
  }

  @override
  Future<CompHubInfo> getCompHubInfo(
    ServiceCall call,
    CompHubInfo request,
  ) async {
    logger.i('Hub info got requested');

    final CbjHubIno cbjHubIno = CbjHubIno(
      entityName: 'cbj Hub',
      protoLastGenDate: hubServerProtocGenDate,
      dartSdkVersion: Platform.version,
    );

    final CompHubSpecs compHubSpecs = CompHubSpecs(
      compOs: Platform.operatingSystem,
    );

    final CompHubInfo compHubInfo = CompHubInfo(
      cbjInfo: cbjHubIno,
      compSpecs: compHubSpecs,
    );
    return compHubInfo;
  }

  @override
  Stream<ClientStatusRequests> hubTransferEntities(
    ServiceCall call,
    Stream<RequestsAndStatusFromHub> request,
  ) async* {
    // TODO: implement registerHub
    throw UnimplementedError();
  }
}
