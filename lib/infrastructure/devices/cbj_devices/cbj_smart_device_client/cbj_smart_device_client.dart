import 'dart:async';

import 'package:cbj_hub/infrastructure/gen/cbj_smart_device_server/protoc_as_dart/cbj_smart_device_server.pbgrpc.dart';
import 'package:cbj_hub/infrastructure/shared_variables.dart';
import 'package:cbj_hub/injection.dart';
import 'package:cbj_hub/utils.dart';
import 'package:grpc/grpc.dart';
import 'package:network_tools/network_tools.dart';

class CbjSmartDeviceClient {
  CbjSmartDeviceClient() {
    if (currentEnv == Env.prod) {
      smartDevicePort = 50054;
    } else {
      smartDevicePort = 50054;
      // hubPort = 60054;
    }
  }

  /// Port to connect to the cbj hub, will change according to the current
  /// running environment
  static int smartDevicePort = 50054;
  static ClientChannel? channel;
  static CbjSmartDeviceConnectionsClient? smartDeviceClient;

  static Future<List<CbjSmartDeviceInfo?>> getCbjSmartDeviceHostDevicesInfo(
    ActiveHost activeHost,
  ) async {
    await channel?.terminate();

    channel =
        await _createCbjSmartDeviceClient(activeHost.address, smartDevicePort);

    smartDeviceClient = CbjSmartDeviceConnectionsClient(channel!);

    try {
      final CbjCompSmartDeviceInfo response =
          await smartDeviceClient!.getCompInfo(CbjCommendStatus());
      final List<CbjSmartDeviceInfo> smartDevicesList =
          response.smartDevicesInComp;
      return smartDevicesList;
    } catch (e) {
      logger.e('Caught error while stream with cbj smart device\n$e');
      await channel?.shutdown();
    }
    return [];
  }

  static Future<ClientChannel> _createCbjSmartDeviceClient(
    String deviceIp,
    int hubPort,
  ) async {
    await channel?.shutdown();
    return ClientChannel(
      deviceIp,
      port: hubPort,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
  }

  // TODO: Change in the future that the smart device will publish itself using mdns
  static Future<ActiveHost?> checkIfDeviceIsCbjSmartDevice(
    String deviceIp,
  ) async {
    final String? subnet = await getIt<SharedVariables>().getIps();

    if (subnet == null) {
      return null;
    }

    final ActiveHost? activeHost = await PortScanner.connectToPort(
      address: subnet,
      port: smartDevicePort,
      // TODO: maybe value can be lower
      timeout: const Duration(milliseconds: 2000),
      activeHostsController: StreamController<ActiveHost>(),
    );
    return activeHost;
  }

  static Future<CbjCommendStatus?> suspendCbjSmartDeviceHostDevice(
    String address,
    String cbjDeviceId,
  ) async {
    await channel?.terminate();

    channel = await _createCbjSmartDeviceClient(address, smartDevicePort);

    smartDeviceClient = CbjSmartDeviceConnectionsClient(channel!);

    try {
      final CbjCommendStatus response = await smartDeviceClient!
          .suspendComputer(CbjSmartDeviceInfo(id: cbjDeviceId));

      return response;
    } catch (e) {
      logger.e('Caught error while suspending cbj smart device\n$e');
      await channel?.shutdown();
    }
    return null;
  }

  static Future<CbjCommendStatus?> shutDownCbjSmartDeviceHostDevice(
    String address,
    String cbjDeviceId,
  ) async {
    await channel?.terminate();

    channel = await _createCbjSmartDeviceClient(address, smartDevicePort);

    smartDeviceClient = CbjSmartDeviceConnectionsClient(channel!);

    try {
      final CbjCommendStatus response = await smartDeviceClient!
          .shutdownComputer(CbjSmartDeviceInfo(id: cbjDeviceId));

      return response;
    } catch (e) {
      logger.e('Caught error while shut down cbj smart device\n$e');
      await channel?.shutdown();
    }
    return null;
  }
}
