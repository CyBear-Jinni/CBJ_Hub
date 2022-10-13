import 'dart:convert';
import 'dart:io';

import 'package:cbj_hub/domain/app_communication/i_app_communication_repository.dart';
import 'package:cbj_hub/infrastructure/app_communication/app_communication_repository.dart';
import 'package:cbj_hub/infrastructure/devices/device_helper/device_helper.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/proto_gen_date.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/infrastructure/generic_devices/abstract_device/device_entity_dto_abstract.dart';
import 'package:cbj_hub/infrastructure/room/room_entity_dtos.dart';
import 'package:cbj_hub/infrastructure/routines/routine_cbj_dtos.dart';
import 'package:cbj_hub/infrastructure/scenes/scene_cbj_dtos.dart';
import 'package:cbj_hub/injection.dart';
import 'package:cbj_hub/utils.dart';
import 'package:grpc/service_api.dart';

/// Server to get and send information to the app
class HubAppServer extends CbjHubServiceBase {
  /// The app call this method and getting stream of all the changes of the
  /// internet devices
  Stream<MapEntry<String, String>> streamOfChanges() async* {}

  @override
  Stream<RequestsAndStatusFromHub> clientTransferDevices(
    ServiceCall call,
    Stream<ClientStatusRequests> request,
  ) async* {
    try {
      logger.v('Got new Client');

      getIt<IAppCommunicationRepository>().getFromApp(
        request: request,
        requestUrl: 'Error, Hub does not suppose to have request URL',
        isRemotePipes: false,
      );

      yield* HubRequestsToApp.streamRequestsToApp.map((dynamic entityDto) {
        if (entityDto is DeviceEntityDtoAbstract) {
          return RequestsAndStatusFromHub(
            sendingType: SendingType.deviceType,
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
      deviceName: 'cbj Hub',
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
  Stream<ClientStatusRequests> hubTransferDevices(
    ServiceCall call,
    Stream<RequestsAndStatusFromHub> request,
  ) async* {
    // TODO: implement registerHub
    throw UnimplementedError();
  }
}
