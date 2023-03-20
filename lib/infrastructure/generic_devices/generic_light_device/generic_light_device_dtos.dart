import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/generic_light_device/generic_light_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_light_device/generic_light_value_objects.dart';
import 'package:cbj_hub/infrastructure/generic_devices/abstract_device/device_entity_dto_abstract.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'generic_light_device_dtos.freezed.dart';
part 'generic_light_device_dtos.g.dart';

@freezed
abstract class GenericLightDeviceDtos
    implements _$GenericLightDeviceDtos, DeviceEntityDtoAbstract {
  factory GenericLightDeviceDtos({
    // @JsonKey(ignore: true)
    required String id,
    required String vendorUniqueId,
    required String? defaultName,
    required String? entityStateGRPC,
    required String? senderDeviceOs,
    required String? senderDeviceModel,
    required String? senderId,
    required String? lightSwitchState,
    required String? entityTypes,
    required String? compUuid,
    required String? deviceVendor,
    String? deviceDtoClass,
    String? stateMassage,

    // required ServerTimestampConverter() FieldValue serverTimeStamp,
  }) = _GenericLightDeviceDtos;

  GenericLightDeviceDtos._();

  factory GenericLightDeviceDtos.fromDomain(GenericLightDE genericLightDE) {
    return GenericLightDeviceDtos(
      deviceDtoClass: (GenericLightDeviceDtos).toString(),
      id: genericLightDE.uniqueId.getOrCrash(),
      vendorUniqueId: genericLightDE.vendorUniqueId.getOrCrash(),
      defaultName: genericLightDE.defaultName.getOrCrash(),
      entityStateGRPC: genericLightDE.entityStateGRPC.getOrCrash(),
      stateMassage: genericLightDE.stateMassage.getOrCrash(),
      senderDeviceOs: genericLightDE.senderDeviceOs.getOrCrash(),
      senderDeviceModel: genericLightDE.senderDeviceModel.getOrCrash(),
      senderId: genericLightDE.senderId.getOrCrash(),
      lightSwitchState: genericLightDE.lightSwitchState!.getOrCrash(),
      entityTypes: genericLightDE.entityTypes.getOrCrash(),
      compUuid: genericLightDE.compUuid.getOrCrash(),
      deviceVendor: genericLightDE.deviceVendor.getOrCrash(),
      // serverTimeStamp: FieldValue.serverTimestamp(),
    );
  }

  factory GenericLightDeviceDtos.fromJson(Map<String, dynamic> json) =>
      _$GenericLightDeviceDtosFromJson(json);

  @override
  final String deviceDtoClassInstance = (GenericLightDeviceDtos).toString();

  @override
  DeviceEntityAbstract toDomain() {
    return GenericLightDE(
      uniqueId: CoreUniqueId.fromUniqueString(id),
      vendorUniqueId: VendorUniqueId.fromUniqueString(vendorUniqueId),
      defaultName: DeviceDefaultName(defaultName),
      entityStateGRPC: EntityState(entityStateGRPC),
      stateMassage: DeviceStateMassage(stateMassage),
      senderDeviceOs: DeviceSenderDeviceOs(senderDeviceOs),
      senderDeviceModel: DeviceSenderDeviceModel(senderDeviceModel),
      senderId: DeviceSenderId.fromUniqueString(senderId),
      deviceVendor: DeviceVendor(deviceVendor),
      compUuid: DeviceCompUuid(compUuid),
      lightSwitchState: GenericLightSwitchState(lightSwitchState),
    );
  }
}
