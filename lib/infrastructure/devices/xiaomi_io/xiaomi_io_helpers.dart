import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/generic_rgbw_light_device/generic_rgbw_light_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/xiaomi_io/xiaomi_io_device_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/xiaomi_io/xiaomi_io_gpx3021gl/xiaomi_io_gpx3021gl_entity.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:yeedart/yeedart.dart';

class XiaomiIoHelpers {
  static DeviceEntityAbstract? addDiscoverdDevice({
    required DiscoveryResponse xiaomiIoDevice,
    required CoreUniqueId? uniqueDeviceId,
  }) {
    CoreUniqueId uniqueDeviceIdTemp;

    if (uniqueDeviceId != null) {
      uniqueDeviceIdTemp = uniqueDeviceId;
    } else {
      uniqueDeviceIdTemp = CoreUniqueId();
    }

    final XiaomiIoGpx4021GlEntity xiaomiIoDE = XiaomiIoGpx4021GlEntity(
      uniqueId: uniqueDeviceIdTemp,
      vendorUniqueId:
          VendorUniqueId.fromUniqueString(xiaomiIoDevice.id.toString()),
      defaultName: DeviceDefaultName(
        xiaomiIoDevice.name != '' ? xiaomiIoDevice.name : 'XiaomiIo test 2',
      ),
      deviceStateGRPC: DeviceState(DeviceStateGRPC.ack.toString()),
      senderDeviceOs: DeviceSenderDeviceOs('xiaomi_io'),
      senderDeviceModel: DeviceSenderDeviceModel('1SE'),
      senderId: DeviceSenderId(),
      compUuid: DeviceCompUuid('34asdfrsd23gggg'),
      deviceMdnsName: DeviceMdnsName('yeelink-light-colora_miap9C52'),
      lastKnownIp: DeviceLastKnownIp(xiaomiIoDevice.address.address),
      stateMassage: DeviceStateMassage('Hello World'),
      powerConsumption: DevicePowerConsumption('0'),
      xiaomiIoDeviceId: XiaomiIoDeviceId(xiaomiIoDevice.id.toString()),
      xiaomiIoPort: XiaomiIoPort(xiaomiIoDevice.port.toString()),
      lightSwitchState:
          GenericRgbwLightSwitchState(xiaomiIoDevice.powered.toString()),
      lightColorTemperature: GenericRgbwLightColorTemperature(
        xiaomiIoDevice.colorTemperature.toString(),
      ),
      lightBrightness:
          GenericRgbwLightBrightness(xiaomiIoDevice.brightness.toString()),
      lightColorAlpha: GenericRgbwLightColorAlpha('1.0'),
      lightColorHue: GenericRgbwLightColorHue('0.0'),
      lightColorSaturation: GenericRgbwLightColorSaturation('1.0'),
      lightColorValue: GenericRgbwLightColorValue('1.0'),
    );

    return xiaomiIoDE;

    // TODO: Add if device type does not supported return null
    // logger.i(
    //   'Please add new Xiaomi device type ${xiaomiIoDevice.model}',
    // );
    // return null;
  }
}
