import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/generic_smart_tv/generic_smart_tv_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/google/chrome_cast/chrome_cast_entity.dart';
import 'package:cbj_hub/infrastructure/devices/google/google_device_value_objects.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:yeedart/yeedart.dart';

class GoogleHelpers {
  static DeviceEntityAbstract addDiscoverdDevice(
    DiscoveryResponse googleDevice,
  ) {
    final ChromeCastEntity googleDE = ChromeCastEntity(
      uniqueId: CoreUniqueId(),
      vendorUniqueId:
          VendorUniqueId.fromUniqueString(googleDevice.id.toString()),
      defaultName: DeviceDefaultName('Google test 2'),
      deviceStateGRPC: DeviceState(DeviceStateGRPC.ack.toString()),
      senderDeviceOs: DeviceSenderDeviceOs('Android'),
      senderDeviceModel: DeviceSenderDeviceModel('1SE'),
      senderId: DeviceSenderId(),
      compUuid: DeviceCompUuid('34asdfrsd23gggg'),
      deviceMdnsName: DeviceMdnsName('ChromeCastDevice'),
      lastKnownIp: DeviceLastKnownIp(googleDevice.address.address),
      stateMassage: DeviceStateMassage('Hello World'),
      powerConsumption: DevicePowerConsumption('0'),
      googlePort: GooglePort(googleDevice.port.toString()),
      smartTvSwitchState: GenericSmartTvSwitchState(
        DeviceActions.actionNotSupported.toString(),
      ),
    );

    return googleDE;
  }
}
