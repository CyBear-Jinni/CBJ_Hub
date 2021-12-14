import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/generic_ping_device/generic_ping_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_ping_device/generic_ping_value_objects.dart';
import 'package:cbj_hub/infrastructure/generic_devices/abstract_device/device_entity_dto_abstract.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'generic_ping_device_dtos.freezed.dart';
part 'generic_ping_device_dtos.g.dart';

@freezed
abstract class GenericPingDeviceDtos
    implements _$GenericPingDeviceDtos, DeviceEntityDtoAbstract {
  factory GenericPingDeviceDtos({
    // @JsonKey(ignore: true)
    String? deviceDtoClass,
    required String id,
    required String vendorUniqueId,
    required String? defaultName,
    required String? deviceStateGRPC,
    String? stateMassage,
    required String? senderDeviceOs,
    required String? senderDeviceModel,
    required String? senderId,
    required String? pingSwitchState,
    required String? deviceTypes,
    required String? compUuid,
    required String? deviceVendor

    // required ServerTimestampConverter() FieldValue serverTimeStamp,
    ,
  }) = _GenericPingDeviceDtos;

  GenericPingDeviceDtos._();

  factory GenericPingDeviceDtos.fromDomain(GenericPingDE genericPingDE) {
    return GenericPingDeviceDtos(
      deviceDtoClass: (GenericPingDeviceDtos).toString(),
      id: genericPingDE.uniqueId.getOrCrash(),
      vendorUniqueId: genericPingDE.vendorUniqueId.getOrCrash(),
      defaultName: genericPingDE.defaultName.getOrCrash(),
      deviceStateGRPC: genericPingDE.deviceStateGRPC.getOrCrash(),
      stateMassage: genericPingDE.stateMassage.getOrCrash(),
      senderDeviceOs: genericPingDE.senderDeviceOs.getOrCrash(),
      senderDeviceModel: genericPingDE.senderDeviceModel.getOrCrash(),
      senderId: genericPingDE.senderId.getOrCrash(),
      pingSwitchState: genericPingDE.pingSwitchState!.getOrCrash(),
      deviceTypes: genericPingDE.deviceTypes.getOrCrash(),
      compUuid: genericPingDE.compUuid.getOrCrash(),
      deviceVendor: genericPingDE.deviceVendor.getOrCrash(),
      // serverTimeStamp: FieldValue.serverTimestamp(),
    );
  }

  factory GenericPingDeviceDtos.fromJson(Map<String, dynamic> json) =>
      _$GenericPingDeviceDtosFromJson(json);

  @override
  final String deviceDtoClassInstance = (GenericPingDeviceDtos).toString();

  @override
  DeviceEntityAbstract toDomain() {
    return GenericPingDE(
      uniqueId: CoreUniqueId.fromUniqueString(id),
      vendorUniqueId: VendorUniqueId.fromUniqueString(vendorUniqueId),
      defaultName: DeviceDefaultName(defaultName),
      deviceStateGRPC: DeviceState(deviceStateGRPC),
      stateMassage: DeviceStateMassage(stateMassage),
      senderDeviceOs: DeviceSenderDeviceOs(senderDeviceOs),
      senderDeviceModel: DeviceSenderDeviceModel(senderDeviceModel),
      senderId: DeviceSenderId.fromUniqueString(senderId),
      deviceVendor: DeviceVendor(deviceVendor),
      compUuid: DeviceCompUuid(compUuid),
      pingSwitchState: GenericPingSwitchState(pingSwitchState),
    );
  }
}
