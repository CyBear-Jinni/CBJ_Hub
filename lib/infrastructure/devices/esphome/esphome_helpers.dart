import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/infrastructure/devices/esphome/esphome_python_api/esphome_python_api.dart';
import 'package:cbj_hub/infrastructure/system_commands/system_commands_manager_d.dart';
import 'package:cbj_hub/injection.dart';
import 'package:compute/compute.dart';

class EspHomeHelpers {
  static Future<List<DeviceEntityAbstract>> addDiscoverdEntities({
    required String address,
    required String mDnsName,
    String port = '6053',
  }) async {
    final HelperEspHomeDeviceInfo helperEspHomeDeviceInfo =
        HelperEspHomeDeviceInfo(
      address: address,
      port: port,
      deviceKey: 'null',
      newState: 'null',
      mDnsName: mDnsName,
      devicePassword: 'MyPassword',
      getProjectFilesLocation:
          await getIt<SystemCommandsManager>().getProjectFilesLocation(),
    );
    final List<DeviceEntityAbstract> deviceEntityList =
        await compute(EspHomePythonApi.getAllEntities, helperEspHomeDeviceInfo);

    return deviceEntityList;
  }
}
