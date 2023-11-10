import 'dart:io';

import 'package:cbj_hub/application/boot_up/boot_up.dart';
import 'package:cbj_hub/infrastructure/cbj_web_server/cbj_web_server_repository.dart';
import 'package:cbj_hub/infrastructure/mqtt_server/mqtt_server_repository.dart';
import 'package:cbj_integrations_controller/infrastructure/bindings/binding_repository.dart';
import 'package:cbj_integrations_controller/infrastructure/local_db/local_db_hive_repository.dart';
import 'package:cbj_integrations_controller/infrastructure/node_red/node_red_repository.dart';
import 'package:cbj_integrations_controller/infrastructure/room/saved_rooms_repo.dart';
import 'package:cbj_integrations_controller/infrastructure/routines/routine_repository.dart';
import 'package:cbj_integrations_controller/infrastructure/saved_devices/saved_devices_repo.dart';
import 'package:cbj_integrations_controller/infrastructure/scenes/scene_repository.dart';
import 'package:cbj_integrations_controller/infrastructure/shared_variables.dart';
import 'package:cbj_integrations_controller/infrastructure/system_commands/system_commands_manager_d.dart';
import 'package:cbj_integrations_controller/initialize_integrations_controller.dart';
import 'package:cbj_integrations_controller/injection.dart';
import 'package:network_tools/network_tools.dart';

Future<void> main(List<String> arguments) async {
  configureNetworkTools('network_tools_db');

  setInstancesOfRepos(arguments.firstOrNull ?? Directory.current.path);
  // arguments[0] is the location of the project
  await initializeIntegrationsController(
    projectRootDirectoryPath: arguments.firstOrNull ?? Directory.current.path,
    env: Env.devPc,
  );

  await BootUp.setup();
}

/// All instances of Repos
void setInstancesOfRepos(String projectRootDirectoryPath) {
  SystemCommandsManager();
  MqttServerRepository();
  CbjWebServerRepository();
  SavedRoomsRepo();
  SavedDevicesRepo();
  RoutineCbjRepository();
  HiveRepository();
  NodeRedRepository();
  BindingCbjRepository();
  SceneCbjRepository();
  SharedVariables(projectRootDirectoryPath);
}
