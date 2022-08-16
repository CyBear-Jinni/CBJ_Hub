import 'package:cbj_hub/application/connector/connector.dart';
import 'package:cbj_hub/domain/cbj_web_server/i_cbj_web_server_repository.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/mqtt_server/i_mqtt_server_repository.dart';
import 'package:cbj_hub/domain/rooms/i_saved_rooms_repo.dart';
import 'package:cbj_hub/domain/saved_devices/i_saved_devices_repo.dart';
import 'package:cbj_hub/domain/scene/i_scene_cbj_repository.dart';
import 'package:cbj_hub/infrastructure/devices/companies_connector_conjector.dart';
import 'package:cbj_hub/injection.dart';

class BootUp {
  BootUp() {
    setup();
  }

  static Future<void> setup() async {
    // Return all saved rooms
    final ISavedRoomsRepo savedRoomsRepo = getIt<ISavedRoomsRepo>();
    final ISceneCbjRepository savedScenesRepo = getIt<ISceneCbjRepository>();

    await savedRoomsRepo.getAllRooms();

    await savedScenesRepo.getAllScenesAsMap();

    // Return all saved devices
    final ISavedDevicesRepo savedDevicesRepo = getIt<ISavedDevicesRepo>();

    final Map<String, DeviceEntityAbstract> allDevices =
        await savedDevicesRepo.getAllDevices();

    CompaniesConnectorConjector.addAllDevicesToItsRepos(allDevices);

    CompaniesConnectorConjector.searchAllMdnsDevicesAndSetThemUp();

    // TODO: ping command does not have the permission under snap.
    // Bring back from comment after cbj-hub snap get the permission out of the box
    // https://forum.snapcraft.io/t/request-auto-connect-firewall-control-or-network-control-or-network-observe-for-cbj-hub/31222
    CompaniesConnectorConjector.searchPingableDevicesAndSetThemUpByHostName();

    getIt<IMqttServerRepository>();

    getIt<ICbjWebServerRepository>();

    Connector.startConnector();
  }
}
