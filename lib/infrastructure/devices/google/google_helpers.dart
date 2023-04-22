import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/generic_smart_tv/generic_smart_tv_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/google/chrome_cast/chrome_cast_entity.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';

class GoogleHelpers {
  static List<DeviceEntityAbstract> addDiscoverdDevice({
    required String mDnsName,
    required String ip,
    required String port,
    required CoreUniqueId? uniqueDeviceId,
  }) {
    CoreUniqueId uniqueDeviceIdTemp;

    if (uniqueDeviceId != null) {
      uniqueDeviceIdTemp = uniqueDeviceId;
    } else {
      uniqueDeviceIdTemp = CoreUniqueId();
    }

    final ChromeCastEntity googleDE = ChromeCastEntity(
      uniqueId: uniqueDeviceIdTemp,
      entityUniqueId: EntityUniqueId(mDnsName),
      cbjEntityName: CbjEntityName('Chromecast'),
      entityOriginalName: EntityOriginalName('Chromecast'),
      deviceOriginalName: DeviceOriginalName('Chromecast'),
      entityStateGRPC: EntityState(EntityStateGRPC.ack.toString()),
      senderDeviceOs: DeviceSenderDeviceOs('Android'),
      senderDeviceModel: DeviceSenderDeviceModel('1SE'),
      senderId: DeviceSenderId(),
      compUuid: DeviceCompUuid('34asdfrsd23gggg'),
      deviceMdnsName: DeviceMdns(mDnsName),
      lastKnownIp: DeviceLastKnownIp(ip),
      stateMassage: DeviceStateMassage('Hello World'),
      powerConsumption: DevicePowerConsumption('0'),
      smartTvSwitchState: GenericSmartTvSwitchState(
        EntityActions.actionNotSupported.toString(),
      ),
      deviceUniqueId: DeviceUniqueId('0'),
      devicePort: DevicePort(port),
      deviceLastKnownIp: DeviceLastKnownIp('0'),
      deviceHostName: DeviceHostName('0'),
      deviceMdns: DeviceMdns('0'),
      devicesMacAddress: DevicesMacAddress('0'),
      entityKey: EntityKey('0'),
      requestTimeStamp: RequestTimeStamp('0'),
      lastResponseFromDeviceTimeStamp: LastResponseFromDeviceTimeStamp('0'),
      deviceCbjUniqueId: CoreUniqueId(),
    );

    return [googleDE];
  }
}
