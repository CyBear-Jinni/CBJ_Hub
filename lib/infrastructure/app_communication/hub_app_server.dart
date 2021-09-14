import 'package:cbj_hub/domain/app_communication/i_app_communication_repository.dart';
import 'package:cbj_hub/infrastructure/app_communication/app_communication_repository.dart';
import 'package:cbj_hub/infrastructure/devices/device_helper/device_helper.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/infrastructure/generic_devices/abstract_device/device_entity_dto_abstract.dart';
import 'package:cbj_hub/injection.dart';
import 'package:grpc/service_api.dart';
import 'package:cbj_hub/utils.dart';

/// Server to get and send information to the app
class HubAppServer extends CbjHubServiceBase {
  /// The app call this method and getting stream of all the changes of the
  /// internet devices
  Stream<MapEntry<String, String>> streamOfChanges() async* {}

  @override
  Stream<RequestsAndStatusFromHub> clientTransferDevices(
      ServiceCall call, Stream<ClientStatusRequests> request) async* {
    try {
      print('Got new Client');

      getIt<IAppCommunicationRepository>().getFromApp(request);

      // For the app to receive all current devices
      AppCommunicationRepository.sendAllDevicesToHubRequestsStream();

      yield* HubRequestsToApp.streamRequestsToApp
          .map((DeviceEntityDtoAbstract deviceEntityDto) =>
              RequestsAndStatusFromHub(
                sendingType: SendingType.deviceType,
                allRemoteCommands:
                    DeviceHelper.convertDtoToJsonString(deviceEntityDto),
              ))
          .handleError((error) => logger.e('Stream have error $error'));
    } catch (e) {
      logger.e('Hub server error $e');
    }
  }

  @override
  Stream<ClientStatusRequests> hubTransferDevices(
      ServiceCall call, Stream<RequestsAndStatusFromHub> request) async* {
    // TODO: implement registerHub
    throw UnimplementedError();
  }
}
