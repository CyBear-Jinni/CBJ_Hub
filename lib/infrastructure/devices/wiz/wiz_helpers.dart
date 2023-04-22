import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';

class WizHelpers {
  static DeviceEntityAbstract? addDiscoverdDevice({
    // required WizBulb wizDevice,
    required CoreUniqueId? uniqueDeviceId,
  }) {
    // CoreUniqueId uniqueDeviceIdTemp;
    //
    // if (uniqueDeviceId != null) {
    //   uniqueDeviceIdTemp = uniqueDeviceId;
    // } else {
    //   uniqueDeviceIdTemp = CoreUniqueId();
    // }
    return null;
    // final WizWhiteEntity wizDE = WizWhiteEntity(
    //   uniqueId: uniqueDeviceIdTemp,
    //   entityUniqueId: EntityUniqueId.fromUniqueString(wizDevice.id),
    //   cbjEntityName: CbjEntityName(
    //     wizDevice.label != '' ? wizDevice.label : 'Wiz test 2',
    //   ),
    //   entityStateGRPC: EntityState(EntityStateGRPC.ack.toString()),
    //   senderDeviceOs: DeviceSenderDeviceOs('Wiz'),
    //   senderDeviceModel: DeviceSenderDeviceModel('Cloud'),
    //   senderId: DeviceSenderId(),
    //   compUuid: DeviceCompUuid(wizDevice.uuid),
    //   stateMassage: DeviceStateMassage('Hello World'),
    //   powerConsumption: DevicePowerConsumption('0'),
    //   lightSwitchState: GenericLightSwitchState(
    //     (wizDevice.power == WizPower.on).toString(),
    //   ),
    // );

    // return wizDE;

    // TODO: Add if device type does not supported return null
    // logger.i(
    //   'Please add new philips device type Bulb ${wizDevice.label}',
    // );
    // return null;
  }
}
