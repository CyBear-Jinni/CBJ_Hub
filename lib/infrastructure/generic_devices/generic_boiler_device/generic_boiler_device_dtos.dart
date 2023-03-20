import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/generic_boiler_device/generic_boiler_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_boiler_device/generic_boiler_value_objects.dart';
import 'package:cbj_hub/infrastructure/generic_devices/abstract_device/device_entity_dto_abstract.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'generic_boiler_device_dtos.freezed.dart';
part 'generic_boiler_device_dtos.g.dart';

@freezed
abstract class GenericBoilerDeviceDtos
    implements _$GenericBoilerDeviceDtos, DeviceEntityDtoAbstract {
  factory GenericBoilerDeviceDtos({
    // @JsonKey(ignore: true)
    required String id,
    required String vendorUniqueId,
    required String? defaultName,
    required String? entityStateGRPC,
    required String? senderDeviceOs,
    required String? senderDeviceModel,
    required String? senderId,
    required String? boilerSwitchState,
    required String? entityTypes,
    required String? compUuid,
    required String? deviceVendor,
    String? deviceDtoClass,
    String? stateMassage,

    // required ServerTimestampConverter() FieldValue serverTimeStamp,
  }) = _GenericBoilerDeviceDtos;

  GenericBoilerDeviceDtos._();

  factory GenericBoilerDeviceDtos.fromDomain(GenericBoilerDE genericBoilerDE) {
    return GenericBoilerDeviceDtos(
      deviceDtoClass: (GenericBoilerDeviceDtos).toString(),
      id: genericBoilerDE.uniqueId.getOrCrash(),
      vendorUniqueId: genericBoilerDE.vendorUniqueId.getOrCrash(),
      defaultName: genericBoilerDE.defaultName.getOrCrash(),
      entityStateGRPC: genericBoilerDE.entityStateGRPC.getOrCrash(),
      stateMassage: genericBoilerDE.stateMassage.getOrCrash(),
      senderDeviceOs: genericBoilerDE.senderDeviceOs.getOrCrash(),
      senderDeviceModel: genericBoilerDE.senderDeviceModel.getOrCrash(),
      senderId: genericBoilerDE.senderId.getOrCrash(),
      boilerSwitchState: genericBoilerDE.boilerSwitchState!.getOrCrash(),
      entityTypes: genericBoilerDE.entityTypes.getOrCrash(),
      compUuid: genericBoilerDE.compUuid.getOrCrash(),
      deviceVendor: genericBoilerDE.deviceVendor.getOrCrash(),
      // serverTimeStamp: FieldValue.serverTimestamp(),
    );
  }

  factory GenericBoilerDeviceDtos.fromJson(Map<String, dynamic> json) =>
      _$GenericBoilerDeviceDtosFromJson(json);

  @override
  final String deviceDtoClassInstance = (GenericBoilerDeviceDtos).toString();

  @override
  DeviceEntityAbstract toDomain() {
    return GenericBoilerDE(
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
      boilerSwitchState: GenericBoilerSwitchState(boilerSwitchState),
    );
  }
}
