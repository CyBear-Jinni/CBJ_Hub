import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/generic_light_with_brightness_device/generic_light_with_brightness_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/philips_hue/philips_hue_api/philips_hue_api_light.dart';
import 'package:cbj_hub/infrastructure/devices/philips_hue/philips_hue_device_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/philips_hue/philips_hue_e26/philips_hue_e26_entity.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/utils.dart';
import 'package:http/http.dart';
import 'package:hue_dart/src/core/bridge.dart';
import 'package:hue_dart/src/light/light.dart';
import 'package:hue_dart/src/light/light_state.dart';

class PhilipsHueHelpers {
  static Future<List<DeviceEntityAbstract>> addDiscoverdDevice({
    required String mDnsName,
    required String? port,
    required String ip,
    required CoreUniqueId? uniqueDeviceId,
  }) async {
    CoreUniqueId uniqueDeviceIdTemp;

    if (uniqueDeviceId != null) {
      uniqueDeviceIdTemp = uniqueDeviceId;
    } else {
      uniqueDeviceIdTemp = CoreUniqueId();
    }

    final client = Client();

    //create bridge
    final bridge = Bridge(client, ip);
    final String userNameForPhilipsHueHub =
        await bridge.brideLoopToAwaitPushlinkForUserId();
    bridge.username = userNameForPhilipsHueHub;

    final List<Light> lights = await bridge.lights();

    final List<DeviceEntityAbstract> tempDeviceEntities = [];

    for (final Light light in lights) {
      final LightState? lightState = light.state;

      if (light.type != null && light.type == 'Dimmable light') {
        final PhilipsHueE26Entity philipsHueDE = PhilipsHueE26Entity(
          uniqueId: uniqueDeviceIdTemp,
          vendorUniqueId:
              VendorUniqueId.fromUniqueString(light.uniqueId.toString()),
          defaultName: DeviceDefaultName(
            light.name != null && light.name != ''
                ? light.name
                : 'PhilipsHue test 2',
          ),
          deviceStateGRPC: DeviceState(DeviceStateGRPC.ack.toString()),
          senderDeviceOs: DeviceSenderDeviceOs('philips_hue'),
          senderDeviceModel: DeviceSenderDeviceModel(light.modelId),
          senderId: DeviceSenderId(),
          compUuid: DeviceCompUuid('55asdhd23gggg'),
          deviceMdnsName: DeviceMdnsName(mDnsName),
          lastKnownIp: DeviceLastKnownIp(ip),
          stateMassage: DeviceStateMassage('Hello World'),
          powerConsumption: DevicePowerConsumption('0'),
          philipsHuePort: PhilipsHuePort(port),
          lightSwitchState: GenericLightWithBrightnessSwitchState(
            lightState != null && lightState.on != null && lightState.on == true
                ? DeviceActions.on.toString()
                : DeviceActions.off.toString(),
          ),
          lightBrightness: GenericLightWithBrightnessBrightness(
            (lightState?.brightness ?? 0).toString(),
          ),
          philipsHueApiLight: PhilipsHueApiLight(
              username: userNameForPhilipsHueHub, ipAdress: ip),
        );
        tempDeviceEntities.add(philipsHueDE);
      } else {
        logger.w('Un supported Philips Hue light type');
      }
    }

    return tempDeviceEntities;
  }
}
