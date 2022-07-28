import 'package:cbj_hub/infrastructure/devices/tuya_smart/tuya_smart_remote_api/tuya_device_abstract.dart';

class TuyaSwitch extends TuyaDeviceAbstract {
  TuyaSwitch({
    required String name,
    required String icon,
    required String id,
    required String devType,
    required String haType,
    required bool online,
    required bool state,
  }) : super(
          name: name,
          icon: icon,
          id: id,
          devType: devType,
          haType: haType,
          online: online,
          state: state,
        );

  factory TuyaSwitch.fromInternalLinkedHashMap(dynamic deviceHashMap) {
    return TuyaSwitch(
      name: deviceHashMap['name'] as String,
      icon: deviceHashMap['icon'] as String,
      id: deviceHashMap['id'] as String,
      devType: deviceHashMap['dev_type'] as String,
      haType: deviceHashMap['ha_type'] as String,
      online: deviceHashMap['data']['online'] as bool,
      state: deviceHashMap['data']['state'] == 'true',
    );
  }
}
