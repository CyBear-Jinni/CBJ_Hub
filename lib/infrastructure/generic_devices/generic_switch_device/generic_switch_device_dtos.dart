import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/generic_light_device/generic_light_value_objects.dart';
import 'package:cbj_hub/domain/generic_devices/generic_switch_device/generic_switch_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_switch_device/generic_switch_value_objects.dart';
import 'package:cbj_hub/infrastructure/generic_devices/abstract_device/device_entity_dto_abstract.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'generic_switch_device_dtos.freezed.dart';
part 'generic_switch_device_dtos.g.dart';

@freezed
abstract class GenericSwitchDeviceDtos
    implements _$GenericSwitchDeviceDtos, DeviceEntityDtoAbstract {
  factory GenericSwitchDeviceDtos({
    // @JsonKey(ignore: true)
    String? deviceDtoClass,
    String? id,
    required String? defaultName,
    required String? roomId,
    required String? roomName,
    required String? deviceStateGRPC,
    String? stateMassage,
    required String? senderDeviceOs,
    required String? senderDeviceModel,
    required String? senderId,
    required String? switchState,
    required String? deviceTypes,
    required String? compUuid,
    required String? deviceVendor

    // required ServerTimestampConverter() FieldValue serverTimeStamp,
    ,
  }) = _GenericSwitchDeviceDtos;

  GenericSwitchDeviceDtos._();

  factory GenericSwitchDeviceDtos.fromDomain(GenericSwitchDE genericSwitchDe) {
    return GenericSwitchDeviceDtos(
      deviceDtoClass: (GenericSwitchDeviceDtos).toString(),
      id: genericSwitchDe.uniqueId.getOrCrash(),
      defaultName: genericSwitchDe.defaultName.getOrCrash(),
      roomId: genericSwitchDe.roomId.getOrCrash(),
      roomName: genericSwitchDe.roomName.getOrCrash(),
      deviceStateGRPC: genericSwitchDe.deviceStateGRPC.getOrCrash(),
      stateMassage: genericSwitchDe.stateMassage.getOrCrash(),
      senderDeviceOs: genericSwitchDe.senderDeviceOs.getOrCrash(),
      senderDeviceModel: genericSwitchDe.senderDeviceModel.getOrCrash(),
      senderId: genericSwitchDe.senderId.getOrCrash(),
      switchState: genericSwitchDe.switchState!.getOrCrash(),
      deviceTypes: genericSwitchDe.deviceTypes.getOrCrash(),
      compUuid: genericSwitchDe.compUuid.getOrCrash(),
      deviceVendor: genericSwitchDe.deviceVendor.getOrCrash(),
      // serverTimeStamp: FieldValue.serverTimestamp(),
    );
  }

  factory GenericSwitchDeviceDtos.fromJson(Map<String, dynamic> json) =>
      _$GenericSwitchDeviceDtosFromJson(json);

  @override
  final String deviceDtoClassInstance = (GenericSwitchDeviceDtos).toString();

  @override
  DeviceEntityAbstract toDomain() {
    return GenericSwitchDE(
      uniqueId: CoreUniqueId.fromUniqueString(id),
      defaultName: DeviceDefaultName(defaultName),
      roomId: CoreUniqueId.fromUniqueString(roomId),
      roomName: DeviceRoomName(roomName),
      deviceStateGRPC: DeviceState(deviceStateGRPC),
      stateMassage: DeviceStateMassage(stateMassage),
      senderDeviceOs: DeviceSenderDeviceOs(senderDeviceOs),
      senderDeviceModel: DeviceSenderDeviceModel(senderDeviceModel),
      senderId: DeviceSenderId.fromUniqueString(senderId),
      deviceVendor: DeviceVendor(deviceVendor),
      compUuid: DeviceCompUuid(compUuid),
      switchState: GenericSwitchState(switchState),
    );
  }
}

// class ServerTimestampConverter implements JsonConverter<FieldValue, Object> {
//   const ServerTimestampConverter();
//
//   @override
//   FieldValue fromJson(Object json) {
//     return FieldValue.serverTimestamp();
//   }
//
//   @override
//   Object toJson(FieldValue fieldValue) => fieldValue;
// }
