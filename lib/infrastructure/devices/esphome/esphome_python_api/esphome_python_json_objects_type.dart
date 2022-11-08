import 'dart:convert';

import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/infrastructure/devices/esphome/esphome_python_api/esphome_python_api_device_types/esphome_python_api_light_info_object_type.dart';
import 'package:cbj_hub/utils.dart';

class EsphomePythonJsonObjectsType {
  static DeviceEntityAbstract? getDeviceAsAbstractIfExist({
    required String address,
    required String mDnsName,
    required String? port,
    required String currentType,
    required String deviceJson,
  }) {
    DeviceEntityAbstract? deviceEntityAbstract;
    try {
      final dynamic jsonDecodeOutput = json.decode(deviceJson);
      final Map<String, dynamic> deviceJsonMap =
          jsonDecodeOutput as Map<String, dynamic>;

      if (currentType == 'LightInfo') {
        final EsphomePythonApiLightInfoObjectType lightObject =
            EsphomePythonApiLightInfoObjectType.fromJson(deviceJsonMap);
        deviceEntityAbstract = lightObject.toEspHomeLightEntity(
          address: address,
          mDnsName: mDnsName,
          port: port,
        );
      }
      // else if (currentType == 'SwitchInfo') {
      //   final EsphomePythonApiSwitchInfoObjectType switchObject =
      //       EsphomePythonApiSwitchInfoObjectType.fromJson(deviceJsonMap);
      //   deviceEntityAbstract = switchObject.toEspHomeSwitchEntity(
      //     address: address,
      //     mDnsName: mDnsName,
      //     port: port,
      //   );
      // }
      // else if (currentType == 'BinarySensorInfo') {
      //   logger.v('Esphome BinarySensorInfo is currently not supported');
      // }
      else {
        logger
            .v('Esphome entity type is currently not supported: $currentType');
      }
    } catch (e) {
      logger.e(
        'Error converting esphome python device to esphome dart device\n$e',
      );
    }

    return deviceEntityAbstract;
  }
}
