import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/generic_blinds_device/generic_blinds_value_objects.dart';
import 'package:cbj_hub/domain/generic_devices/generic_boiler_device/generic_boiler_value_objects.dart';
import 'package:cbj_hub/domain/generic_devices/generic_smart_plug_device/generic_smart_plug_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/switcher/switcher_api/switcher_api_object.dart';
import 'package:cbj_hub/infrastructure/devices/switcher/switcher_runner/switcher_runner_entity.dart';
import 'package:cbj_hub/infrastructure/devices/switcher/switcher_smart_plug/switcher_smart_plug_entity.dart';
import 'package:cbj_hub/infrastructure/devices/switcher/switcher_v2/switcher_v2_entity.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/utils.dart';

class SwitcherHelpers {
  static DeviceEntityAbstract? addDiscoverdDevice({
    required SwitcherApiObject switcherDevice,
    required CoreUniqueId? uniqueDeviceId,
  }) {
    CoreUniqueId uniqueDeviceIdTemp;

    if (uniqueDeviceId != null) {
      uniqueDeviceIdTemp = uniqueDeviceId;
    } else {
      uniqueDeviceIdTemp = CoreUniqueId();
    }

    if (switcherDevice.deviceType == SwitcherDevicesTypes.switcherRunner ||
        switcherDevice.deviceType == SwitcherDevicesTypes.switcherRunnerMini) {
      EntityActions deviceActions = EntityActions.actionNotSupported;

      if (switcherDevice.deviceDirection == SwitcherDeviceDirection.up) {
        deviceActions = EntityActions.moveUp;
      } else if (switcherDevice.deviceDirection ==
          SwitcherDeviceDirection.stop) {
        deviceActions = EntityActions.stop;
      } else if (switcherDevice.deviceDirection ==
          SwitcherDeviceDirection.down) {
        deviceActions = EntityActions.moveDown;
      }

      final SwitcherRunnerEntity switcherRunnerDe = SwitcherRunnerEntity(
        uniqueId: uniqueDeviceIdTemp,
        entityUniqueId: EntityUniqueId(switcherDevice.deviceId),
        cbjEntityName: CbjEntityName(switcherDevice.switcherName),
        entityOriginalName: EntityOriginalName(switcherDevice.switcherName),
        deviceOriginalName: DeviceOriginalName(switcherDevice.switcherName),
        entityStateGRPC: EntityState(EntityStateGRPC.ack.toString()),
        senderDeviceOs: DeviceSenderDeviceOs('switcher'),
        senderDeviceModel:
            DeviceSenderDeviceModel(switcherDevice.deviceType.toString()),
        senderId: DeviceSenderId(),
        compUuid: DeviceCompUuid('34asdfrsd23gggg'),
        deviceLastKnownIp: DeviceLastKnownIp(switcherDevice.switcherIp),
        stateMassage: DeviceStateMassage('Hello World'),
        powerConsumption:
            DevicePowerConsumption(switcherDevice.powerConsumption),
        devicePort: DevicePort(switcherDevice.port.toString()),
        devicesMacAddress: DevicesMacAddress(switcherDevice.macAddress),
        blindsSwitchState: GenericBlindsSwitchState(
          deviceActions.toString(),
        ),
        deviceUniqueId: DeviceUniqueId('0'),
        deviceHostName: DeviceHostName('0'),
        deviceMdns: DeviceMdns('0'),
        entityKey: EntityKey('0'),
        requestTimeStamp: RequestTimeStamp('0'),
        lastResponseFromDeviceTimeStamp: LastResponseFromDeviceTimeStamp('0'),
        deviceCbjUniqueId: CoreUniqueId(),
      );

      return switcherRunnerDe;
    } else if (switcherDevice.deviceType == SwitcherDevicesTypes.switcherMini ||
        switcherDevice.deviceType == SwitcherDevicesTypes.switcherTouch ||
        switcherDevice.deviceType == SwitcherDevicesTypes.switcherV2Esp ||
        switcherDevice.deviceType == SwitcherDevicesTypes.switcherV2qualcomm ||
        switcherDevice.deviceType == SwitcherDevicesTypes.switcherV4) {
      EntityActions deviceActions = EntityActions.actionNotSupported;
      if (switcherDevice.deviceState == SwitcherDeviceState.on) {
        deviceActions = EntityActions.on;
      } else if (switcherDevice.deviceState == SwitcherDeviceState.off) {
        deviceActions = EntityActions.off;
      }
      final SwitcherV2Entity switcherV2De = SwitcherV2Entity(
        uniqueId: uniqueDeviceIdTemp,
        entityUniqueId: EntityUniqueId(switcherDevice.deviceId),
        cbjEntityName: CbjEntityName(switcherDevice.switcherName),
        entityOriginalName: EntityOriginalName(switcherDevice.switcherName),
        deviceOriginalName: DeviceOriginalName(switcherDevice.switcherName),
        entityStateGRPC: EntityState(EntityStateGRPC.ack.toString()),
        senderDeviceOs: DeviceSenderDeviceOs('switcher'),
        senderDeviceModel:
            DeviceSenderDeviceModel(switcherDevice.deviceType.toString()),
        senderId: DeviceSenderId(),
        compUuid: DeviceCompUuid('34asdfrsd23gggg'),
        deviceLastKnownIp: DeviceLastKnownIp(switcherDevice.switcherIp),
        stateMassage: DeviceStateMassage('Hello World'),
        powerConsumption:
            DevicePowerConsumption(switcherDevice.powerConsumption),
        boilerSwitchState: GenericBoilerSwitchState(deviceActions.toString()),
        devicePort: DevicePort(switcherDevice.port.toString()),
        devicesMacAddress: DevicesMacAddress(switcherDevice.macAddress),
        deviceUniqueId: DeviceUniqueId('0'),
        deviceHostName: DeviceHostName('0'),
        deviceMdns: DeviceMdns('0'),
        entityKey: EntityKey('0'),
        requestTimeStamp: RequestTimeStamp('0'),
        lastResponseFromDeviceTimeStamp: LastResponseFromDeviceTimeStamp('0'),
        deviceCbjUniqueId: CoreUniqueId(),
      );

      return switcherV2De;
    } else if (switcherDevice.deviceType ==
        SwitcherDevicesTypes.switcherPowerPlug) {
      EntityActions deviceActions = EntityActions.actionNotSupported;
      if (switcherDevice.deviceState == SwitcherDeviceState.on) {
        deviceActions = EntityActions.on;
      } else if (switcherDevice.deviceState == SwitcherDeviceState.off) {
        deviceActions = EntityActions.off;
      }
      final SwitcherSmartPlugEntity switcherSmartPlugDe =
          SwitcherSmartPlugEntity(
        uniqueId: uniqueDeviceIdTemp,
        entityUniqueId: EntityUniqueId(switcherDevice.deviceId),
        cbjEntityName: CbjEntityName(switcherDevice.switcherName),
        entityOriginalName: EntityOriginalName(switcherDevice.switcherName),
        deviceOriginalName: DeviceOriginalName(switcherDevice.switcherName),
        entityStateGRPC: EntityState(EntityStateGRPC.ack.toString()),
        senderDeviceOs: DeviceSenderDeviceOs('switcher'),
        senderDeviceModel:
            DeviceSenderDeviceModel(switcherDevice.deviceType.toString()),
        senderId: DeviceSenderId(),
        compUuid: DeviceCompUuid('34asdfrsd23gggg'),
        deviceLastKnownIp: DeviceLastKnownIp(switcherDevice.switcherIp),
        stateMassage: DeviceStateMassage('Hello World'),
        powerConsumption:
            DevicePowerConsumption(switcherDevice.powerConsumption),
        smartPlugState: GenericSmartPlugState(deviceActions.toString()),
        deviceUniqueId: DeviceUniqueId('0'),
        devicePort: DevicePort(switcherDevice.port.toString()),
        deviceHostName: DeviceHostName('0'),
        deviceMdns: DeviceMdns('0'),
        devicesMacAddress: DevicesMacAddress(switcherDevice.macAddress),
        entityKey: EntityKey('0'),
        requestTimeStamp: RequestTimeStamp('0'),
        lastResponseFromDeviceTimeStamp: LastResponseFromDeviceTimeStamp('0'),
        deviceCbjUniqueId: CoreUniqueId(),
      );

      return switcherSmartPlugDe;
    }

    logger.i(
      'Please add new Switcher device type ${switcherDevice.deviceType}',
    );
    return null;
  }
}
