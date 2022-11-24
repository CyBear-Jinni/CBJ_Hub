import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/infrastructure/devices/esphome/esphome_python_api/esphome_python_api.dart';

class EspHomeHelpers {
  static Future<List<DeviceEntityAbstract>> addDiscoverdEntities({
    required String address,
    required String mDnsName,
    String port = '6053',
  }) async {
    final List<DeviceEntityAbstract> deviceEntityList =
        await EspHomePythonApi.getAllEntities(
      address: address,
      mDnsName: mDnsName,
      port: port,
    );

    return deviceEntityList;
  }
}
