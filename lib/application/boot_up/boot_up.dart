import 'package:cbj_hub/application/connector/connector.dart';
import 'package:cbj_integrations_controller/domain/rooms/i_saved_rooms_repo.dart';
import 'package:cbj_integrations_controller/domain/scene/i_scene_cbj_repository.dart';
import 'package:cbj_integrations_controller/initialize_integrations_controller.dart';

class BootUp {
  BootUp() {
    setup();
  }

  static Future<void> setup() async {
    // Return all saved rooms
    await ISavedRoomsRepo.instance.getAllRooms();

    await ISceneCbjRepository.instance.getAllScenesAsMap();

    await setupIntegrationsController();

    Connector.startConnector();
  }
}
