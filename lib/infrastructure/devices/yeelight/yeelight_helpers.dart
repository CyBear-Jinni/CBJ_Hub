import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/generic_rgbw_light_device/generic_rgbw_light_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/yeelight/yeelight_1se/yeelight_1se_entity.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/utils.dart';
import 'package:yeedart/yeedart.dart';

class YeelightHelpers {
  static DeviceEntityAbstract? addDiscoverdDevice({
    required DiscoveryResponse yeelightDevice,
    String? mDnsName,
  }) {
    String deviceName;
    if (yeelightDevice.name != null && yeelightDevice.name != '') {
      deviceName = yeelightDevice.name!;
    } else if (mDnsName != null) {
      deviceName = mDnsName;
    } else {
      deviceName = 'Yeelight device';
    }

    if (yeelightDevice.model == null) {
      return null;
    }

    final DeviceEntityAbstract deviceEntity;

    if (yeelightDevice.model == 'color4') {
      deviceEntity = Yeelight1SeEntity(
        uniqueId: CoreUniqueId(),
        entityUniqueId: EntityUniqueId(yeelightDevice.id.toString()),
        cbjEntityName: CbjEntityName(deviceName),
        entityOriginalName: EntityOriginalName(deviceName),
        deviceOriginalName: DeviceOriginalName(deviceName),
        entityStateGRPC: EntityState(EntityStateGRPC.ack.toString()),
        senderDeviceOs: DeviceSenderDeviceOs('yeelight'),
        senderDeviceModel: DeviceSenderDeviceModel('1SE'),
        senderId: DeviceSenderId(),
        compUuid: DeviceCompUuid('34asdfrsd23gggg'),
        deviceMdns: DeviceMdns(mDnsName ?? ''),
        deviceLastKnownIp: DeviceLastKnownIp(yeelightDevice.address.address),
        stateMassage: DeviceStateMassage('Hello World'),
        powerConsumption: DevicePowerConsumption('0'),
        devicePort: DevicePort(yeelightDevice.port.toString()),
        lightSwitchState:
            GenericRgbwLightSwitchState(yeelightDevice.powered.toString()),
        lightColorTemperature: GenericRgbwLightColorTemperature(
          yeelightDevice.colorTemperature.toString(),
        ),
        lightBrightness:
            GenericRgbwLightBrightness(yeelightDevice.brightness.toString()),
        lightColorAlpha: GenericRgbwLightColorAlpha('1.0'),
        lightColorHue: GenericRgbwLightColorHue(yeelightDevice.hue.toString()),
        lightColorSaturation: GenericRgbwLightColorSaturation(
          yeelightDevice.sat.toString(),
        ),
        lightColorValue: GenericRgbwLightColorValue('1.0'),
        deviceUniqueId: DeviceUniqueId('0'),
        deviceHostName: DeviceHostName('0'),
        devicesMacAddress: DevicesMacAddress('0'),
        entityKey: EntityKey('0'),
        requestTimeStamp: RequestTimeStamp('0'),
        lastResponseFromDeviceTimeStamp: LastResponseFromDeviceTimeStamp('0'),
        deviceCbjUniqueId: CoreUniqueId(),
      );
    } else {
      logger.i(
        'Please add new Yeelight device type ${yeelightDevice.model}',
      );
      return null;
    }

    return deviceEntity;
  }
}
