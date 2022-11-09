import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/infrastructure/devices/esphome/esphome_python_api/esphome_python_json_objects_type.dart';
import 'package:cbj_hub/infrastructure/system_commands/system_commands_manager_d.dart';
import 'package:cbj_hub/injection.dart';
import 'package:cbj_hub/utils.dart';
import 'package:python_shell/python_shell.dart';

class EspHomePythonApi {
  static List<String> requeiredPythonPackages = ['aioesphomeapi'];

  static PythonShell? _shell;

  static Future<PythonShell> getShell() async {
    if (_shell != null) {
      return _shell!;
    }

    _shell = PythonShell(PythonShellConfig());
    await _shell!.initialize();
    return _shell!;
  }

  static Future<List<DeviceEntityAbstract>> getAllEntities({
    required String address,
    required String mDnsName,
    required String port,
  }) async {
    const String devicePassword = 'MyPassword';
    final List<DeviceEntityAbstract> devicesList = [];

    try {
      await getShell();

      final instance = ShellManager.getInstance("default");
      instance.installRequires(requeiredPythonPackages);

      String? currentType;

      final ShellListener shellListener = ShellListener(
        onMessage: (String message) {
          if (currentType != null) {
            final DeviceEntityAbstract? convertedDevice =
                EsphomePythonJsonObjectsType.getDeviceAsAbstractIfExist(
              currentType: currentType!,
              deviceJson: message,
              address: address,
              mDnsName: mDnsName,
              port: port,
            );
            if (convertedDevice != null) {
              devicesList.add(convertedDevice);
            }
            currentType = null;
          } else {
            currentType = message;
          }
        },
        onComplete: () {
          logger.v('EspHome device scan done');
        },
        onError: (object, stackTrace) {
          logger.v('EspHome device scan error $object\n$stackTrace');
        },
      );

      await instance.runFile(
        '${await getIt<SystemCommandsManager>().getProjectFilesLocation()}/lib/infrastructure/devices/esphome/esphome_python_api/esphome_python_files/get_esphome_entities.py',
        listener: shellListener,
        arguments: [
          address,
          port,
          devicePassword,
        ],
        echo: false,
      );
    } catch (e) {
      logger.e('Error while getting all ESPHome entities\n$e');
    }
    return devicesList;
  }

  static Future<void> turnOnOffLightEntity({
    required String address,
    required String port,
    required String deviceKey,
    required String newState,
  }) async {
    const String devicePassword = 'MyPassword';

    await getShell();

    final instance = ShellManager.getInstance("default");
    instance.installRequires(requeiredPythonPackages);

    final ShellListener shellListener = ShellListener(
      onMessage: (String message) {},
      onComplete: () {
        logger.v('EspHome device scan done');
      },
      onError: (object, stackTrace) {
        logger.v('EspHome device scan error $object\n$stackTrace');
      },
    );

    await instance.runFile(
      '${await getIt<SystemCommandsManager>().getProjectFilesLocation()}/lib/infrastructure/devices/esphome/esphome_python_api/esphome_python_files/turn_on_off_light_entity_esphome_devices.py',
      listener: shellListener,
      arguments: [
        address,
        port,
        devicePassword,
        deviceKey,
        newState,
      ],
      echo: false,
    );
  }

  static Future<void> turnOnOffSwitchEntity({
    required String address,
    required String port,
    required String deviceKey,
    required String newState,
  }) async {
    const String devicePassword = 'MyPassword';

    await getShell();

    final instance = ShellManager.getInstance("default");
    instance.installRequires(requeiredPythonPackages);

    final ShellListener shellListener = ShellListener(
      onMessage: (String message) {},
      onComplete: () {
        logger.v('EspHome device scan done');
      },
      onError: (object, stackTrace) {
        logger.v('EspHome device scan error $object\n$stackTrace');
      },
    );

    await instance.runFile(
      '${await getIt<SystemCommandsManager>().getProjectFilesLocation()}/lib/infrastructure/devices/esphome/esphome_python_api/esphome_python_files/turn_on_off_switch_entity_esphome_devices.py',
      listener: shellListener,
      arguments: [
        address,
        port,
        devicePassword,
        deviceKey,
        newState,
      ],
      echo: false,
    );
  }
}
