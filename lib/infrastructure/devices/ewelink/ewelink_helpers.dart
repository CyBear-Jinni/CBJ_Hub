import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/generic_switch_device/generic_switch_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/ewelink/ewelink_switch/ewelink_switch_entity.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:dart_ewelink_api/dart_ewelink_api.dart';

class EwelinkHelpers {
  static List<DeviceEntityAbstract> addDiscoverdDevice(
    EwelinkDevice ewelinkDevice,
  ) {
    final List<DeviceEntityAbstract> deviceEntityAbstractList = [];

    if (ewelinkDevice.type == 'a9') {
      deviceEntityAbstractList.add(
        EwelinkSwitchEntity(
          uniqueId: CoreUniqueId(),
          entityUniqueId: EntityUniqueId(ewelinkDevice.deviceid),
          cbjEntityName: CbjEntityName(ewelinkDevice.name),
          entityOriginalName: EntityOriginalName(ewelinkDevice.name),
          deviceOriginalName: DeviceOriginalName(ewelinkDevice.name),
          stateMassage: DeviceStateMassage('ok'),
          senderDeviceOs: DeviceSenderDeviceOs('EweLink'),
          senderDeviceModel: DeviceSenderDeviceModel(ewelinkDevice.type),
          senderId: DeviceSenderId(),
          deviceUniqueId: DeviceUniqueId(ewelinkDevice.deviceid),
          devicePort: DevicePort(''),
          deviceLastKnownIp: DeviceLastKnownIp(''),
          deviceHostName: DeviceHostName('0'),
          deviceMdns: DeviceMdns('0'),
          compUuid: DeviceCompUuid('empty'),
          powerConsumption: DevicePowerConsumption('0'),
          devicesMacAddress: DevicesMacAddress('0'),
          // TODO: Fix because we can't use the outlet number from entityUniqueId
          entityKey: EntityKey('1'),
          requestTimeStamp: RequestTimeStamp('0'),
          lastResponseFromDeviceTimeStamp: LastResponseFromDeviceTimeStamp('0'),
          deviceCbjUniqueId: CoreUniqueId(),
          switchState: GenericSwitchSwitchState('off'),
          entityStateGRPC: EntityState(EntityStateGRPC.ack.toString()),
        ),
      );
    } else if (ewelinkDevice.type == '10') {
      if (ewelinkDevice.params.switches == null) {
        return deviceEntityAbstractList;
      }

      final List<Map<String, dynamic>> mapOfSwitches =
          ewelinkDevice.params.switches!;

      final Map<String, dynamic>? possibleTags =
          ewelinkDevice.tags?.entityNames;

      for (int i = 0; i < mapOfSwitches.length - 1; i++) {
        final Map<String, dynamic> switchParam = mapOfSwitches[i];
        final String outletNumber = (switchParam['outlet'] as int).toString();

        String tagName = '${ewelinkDevice.name} outlet $outletNumber';

        if (possibleTags != null) {
          if (i <= possibleTags.length - 1) {
            tagName = possibleTags[i.toString()] as String;
          } else {
            // Device can have multiple switches, the device is purpose for 4
            // switches inside of it even if this is a unit of 2.
            // So we return only switch with names because unused switches on the
            // device does not have name (tag)
            continue;
          }
        } else {
          // Devices without tags at all are legit and will be added only once
        }

        deviceEntityAbstractList.add(
          EwelinkSwitchEntity(
            uniqueId: CoreUniqueId(),
            // TODO: This is temp fix, if there are multiple outlet with the
            //  same number for example 0 then only the last one will be
            //  displayed without this fix as they are not unique enough and get
            // override somewhere in the process.
            entityUniqueId:
                EntityUniqueId('${ewelinkDevice.deviceid}-$outletNumber'),
            cbjEntityName: CbjEntityName(
              tagName,
            ),
            entityOriginalName: EntityOriginalName(
              tagName,
            ),
            deviceOriginalName: DeviceOriginalName(ewelinkDevice.name),
            stateMassage: DeviceStateMassage('ok'),
            senderDeviceOs: DeviceSenderDeviceOs('EweLink'),
            senderDeviceModel: DeviceSenderDeviceModel(ewelinkDevice.type),
            senderId: DeviceSenderId(),
            deviceUniqueId: DeviceUniqueId(ewelinkDevice.deviceid),
            devicePort: DevicePort(''),
            deviceLastKnownIp: DeviceLastKnownIp(''),
            deviceHostName: DeviceHostName('0'),
            deviceMdns: DeviceMdns('0'),
            compUuid: DeviceCompUuid('empty'),
            powerConsumption: DevicePowerConsumption('0'),
            devicesMacAddress: DevicesMacAddress('0'),
            // TODO: Fix because we can't use the outlet number from entityUniqueId
            entityKey: EntityKey(outletNumber),
            requestTimeStamp: RequestTimeStamp('0'),
            lastResponseFromDeviceTimeStamp:
                LastResponseFromDeviceTimeStamp('0'),
            deviceCbjUniqueId: CoreUniqueId(),
            switchState:
                GenericSwitchSwitchState(switchParam['switch'] as String),
            entityStateGRPC: EntityState(EntityStateGRPC.ack.toString()),
          ),
        );
        if (possibleTags == null) {
          break;
        }
      }
    }
    return deviceEntityAbstractList;
  }
}
