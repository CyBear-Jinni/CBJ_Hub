import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/generic_smart_computer_device/generic_smart_computer_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/cbj_devices/cbj_smart_device/cbj_smart_device_entity.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_smart_device_server/protoc_as_dart/cbj_smart_device_server.pbgrpc.dart';
import 'package:cbj_hub/utils.dart';

class CbjDevicesHelpers {
  static List<DeviceEntityAbstract> addDiscoverdDevice({
    required List<CbjSmartDeviceInfo?> componentsInDevice,
    required String deviceAddress,
  }) {
    final List<DeviceEntityAbstract> componentsAsSmartDevices = [];

    for (final CbjSmartDeviceInfo? smartDeviceInfo in componentsInDevice) {
      if (smartDeviceInfo == null) {
        continue;
      }
      DeviceEntityAbstract entityAbstract;

      final CbjDeviceTypes deviceType =
          smartDeviceInfo.deviceTypesActions.deviceType;
      final String deviceId = smartDeviceInfo.id;
      final String cbjEntityName = smartDeviceInfo.cbjEntityName;
      // final String deviceState = smartDeviceInfo.state;
      final String deviceStateMassage = smartDeviceInfo.stateMassage.isEmpty
          ? 'ok'
          : smartDeviceInfo.stateMassage;
      final CbjDeviceStateGRPC deviceStateGrpc =
          smartDeviceInfo.deviceTypesActions.entityStateGRPC;

      final String deviceOs = smartDeviceInfo.senderDeviceOs;
      final String deviceModel = smartDeviceInfo.senderDeviceModel;
      final String deviceSenderId = smartDeviceInfo.senderId;
      final String deviceCompUuid = smartDeviceInfo.compSpecs.compUuid;

      if (deviceType == CbjDeviceTypes.smartComputer) {
        entityAbstract = CbjSmartComputerEntity(
          uniqueId: CoreUniqueId(),
          entityUniqueId: EntityUniqueId(deviceId),
          deviceVendor: DeviceVendor(
            VendorsAndServices.cbjDevices.toString(),
          ),
          cbjEntityName: CbjEntityName(cbjEntityName),
          entityStateGRPC: EntityState(deviceStateGrpc.toString()),
          stateMassage: DeviceStateMassage(deviceStateMassage),
          senderDeviceOs: DeviceSenderDeviceOs(deviceOs),
          senderDeviceModel: DeviceSenderDeviceModel(deviceModel),
          senderId: DeviceSenderId.fromUniqueString(deviceSenderId),
          compUuid: DeviceCompUuid(deviceCompUuid),
          smartComputerSuspendState: GenericSmartComputerSuspendState(
            DeviceActions.itIsFalse.toString(),
          ),
          smartComputerShutDownState: GenericSmartComputerShutdownState(
            DeviceActions.itIsFalse.toString(),
          ),
          lastKnownIp: DeviceLastKnownIp(deviceAddress),
          entityOriginalName: EntityOriginalName(cbjEntityName),
          deviceOriginalName: DeviceOriginalName(cbjEntityName),
          powerConsumption: DevicePowerConsumption('0'),
          deviceUniqueId: DeviceUniqueId('0'),
          devicePort: DevicePort('0'),
          deviceLastKnownIp: DeviceLastKnownIp('0'),
          deviceHostName: DeviceHostName('0'),
          deviceMdns: DeviceMdns('0'),
          devicesMacAddress: DevicesMacAddress('0'),
          entityKey: EntityKey('0'),
          requestTimeStamp: RequestTimeStamp('0'),
          lastResponseFromDeviceTimeStamp: LastResponseFromDeviceTimeStamp('0'),
          deviceCbjUniqueId: CoreUniqueId(),
        );
      } else {
        logger.w('Cbj Smart Device type is not supported ${deviceType.name}');
        continue;
      }

      componentsAsSmartDevices.add(entityAbstract);
    }

    return componentsAsSmartDevices;
  }
}
