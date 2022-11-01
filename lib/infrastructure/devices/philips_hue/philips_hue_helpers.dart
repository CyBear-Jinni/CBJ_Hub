import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/generic_rgbw_light_device/generic_rgbw_light_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/philips_hue/philips_hue_device_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/philips_hue/philips_hue_e26/philips_hue_e26_entity.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:yeedart/yeedart.dart';

class PhilipsHueHelpers {
  static DeviceEntityAbstract? addDiscoverdDevice({
    required DiscoveryResponse philipsHueDevice,
    required CoreUniqueId? uniqueDeviceId,
  }) {
    CoreUniqueId uniqueDeviceIdTemp;

    if (uniqueDeviceId != null) {
      uniqueDeviceIdTemp = uniqueDeviceId;
    } else {
      uniqueDeviceIdTemp = CoreUniqueId();
    }
    final PhilipsHueE26Entity philipsHueDE = PhilipsHueE26Entity(
      uniqueId: uniqueDeviceIdTemp,
      vendorUniqueId:
          VendorUniqueId.fromUniqueString(philipsHueDevice.id.toString()),
      defaultName: DeviceDefaultName(
        philipsHueDevice.name != ''
            ? philipsHueDevice.name
            : 'PhilipsHue test 2',
      ),
      deviceStateGRPC: DeviceState(DeviceStateGRPC.ack.toString()),
      senderDeviceOs: DeviceSenderDeviceOs('philips_hue'),
      senderDeviceModel: DeviceSenderDeviceModel('1SE'),
      senderId: DeviceSenderId(),
      compUuid: DeviceCompUuid('34asdfrsd23gggg'),
      deviceMdnsName: DeviceMdnsName('yeelink-light-colora_miap9C52'),
      lastKnownIp: DeviceLastKnownIp(philipsHueDevice.address.address),
      stateMassage: DeviceStateMassage('Hello World'),
      powerConsumption: DevicePowerConsumption('0'),
      philipsHuePort: PhilipsHuePort(philipsHueDevice.port.toString()),
      lightSwitchState:
          GenericRgbwLightSwitchState(philipsHueDevice.powered.toString()),
      lightColorTemperature: GenericRgbwLightColorTemperature(
        philipsHueDevice.colorTemperature.toString(),
      ),
      lightBrightness:
          GenericRgbwLightBrightness(philipsHueDevice.brightness.toString()),
      lightColorAlpha: GenericRgbwLightColorAlpha('1.0'),
      lightColorHue: GenericRgbwLightColorHue('0.0'),
      lightColorSaturation: GenericRgbwLightColorSaturation('1.0'),
      lightColorValue: GenericRgbwLightColorValue('1.0'),
    );

    return philipsHueDE;

    // TODO: Add if device type does not supported return null
    // logger.i(
    //   'Please add new philips device type ${philipsHueDevice.model}',
    // );
    // return null;
  }
}
