import 'dart:async';

import 'package:cbj_hub/domain/app_communication/i_app_communication_repository.dart';
import 'package:cbj_hub/infrastructure/app_communication/app_communication_repository.dart';
import 'package:cbj_hub/infrastructure/devices/device_helper/device_helper.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/infrastructure/generic_devices/abstract_device/device_entity_dto_abstract.dart';
import 'package:cbj_hub/injection.dart';
import 'package:grpc/grpc.dart';
import 'package:cbj_hub/utils.dart';

class RemotePipesClient {
  static ClientChannel? channel;
  static CbjHubClient? stub;

  // createStreamWithRemotePipes
  ///  Turn smart device on
  static Future<void> createStreamWithHub(
      String addressToHub, int hubPort) async {
    channel = await _createCbjHubClient(addressToHub, hubPort);
    stub = CbjHubClient(channel!);

    ResponseStream<ClientStatusRequests> response;

    try {
      response = stub!.hubTransferDevices(
        /// Transfer all requests from hub to the remote pipes->app
        HubRequestsToApp.streamRequestsToApp
            .map((DeviceEntityDtoAbstract deviceEntityDto) =>
                RequestsAndStatusFromHub(
                  sendingType: SendingType.deviceType,
                  allRemoteCommands:
                      DeviceHelper.convertDtoToJsonString(deviceEntityDto),
                ))
            .handleError((error) => logger.e('Stream have error $error')),
      );

      /// Trigger to send all devices from hub to app using the
      /// HubRequestsToApp stream
      AppCommunicationRepository.sendAllDevicesToHubRequestsStream();

      /// All responses from the app->remote pipes going int the hub
      getIt<IAppCommunicationRepository>().getFromApp(response);
    } catch (e) {
      logger.e('Caught error: $e');
      await channel?.shutdown();
    }
  }

  static Future<ClientChannel> _createCbjHubClient(
      String deviceIp, int hubPort) async {
    await channel?.shutdown();
    return ClientChannel(deviceIp,
        port: hubPort,
        options:
            const ChannelOptions(credentials: ChannelCredentials.insecure()));
  }
}
