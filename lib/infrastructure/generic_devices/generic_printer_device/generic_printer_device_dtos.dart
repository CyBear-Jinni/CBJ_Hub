import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/generic_printer_device/generic_printer_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_printer_device/generic_printer_value_objects.dart';
import 'package:cbj_hub/infrastructure/generic_devices/abstract_device/device_entity_dto_abstract.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'generic_printer_device_dtos.freezed.dart';
part 'generic_printer_device_dtos.g.dart';

@freezed
abstract class GenericPrinterDeviceDtos
    implements _$GenericPrinterDeviceDtos, DeviceEntityDtoAbstract {
  factory GenericPrinterDeviceDtos({
    // @JsonKey(ignore: true)
    required String id,
    required String vendorUniqueId,
    required String? defaultName,
    required String? entityStateGRPC,
    required String? senderDeviceOs,
    required String? senderDeviceModel,
    required String? senderId,
    required String? printerSwitchState,
    required String? lastKnownIp,
    required String? entityTypes,
    required String? compUuid,
    required String? deviceVendor,
    String? deviceDtoClass,
    String? stateMassage,

    // required ServerTimestampConverter() FieldValue serverTimeStamp,
  }) = _GenericPrinterDeviceDtos;

  GenericPrinterDeviceDtos._();

  factory GenericPrinterDeviceDtos.fromDomain(
    GenericPrinterDE genericPrinterDE,
  ) {
    return GenericPrinterDeviceDtos(
      deviceDtoClass: (GenericPrinterDeviceDtos).toString(),
      id: genericPrinterDE.uniqueId.getOrCrash(),
      vendorUniqueId: genericPrinterDE.vendorUniqueId.getOrCrash(),
      defaultName: genericPrinterDE.defaultName.getOrCrash(),
      entityStateGRPC: genericPrinterDE.entityStateGRPC.getOrCrash(),
      stateMassage: genericPrinterDE.stateMassage.getOrCrash(),
      senderDeviceOs: genericPrinterDE.senderDeviceOs.getOrCrash(),
      senderDeviceModel: genericPrinterDE.senderDeviceModel.getOrCrash(),
      senderId: genericPrinterDE.senderId.getOrCrash(),
      printerSwitchState: genericPrinterDE.printerSwitchState!.getOrCrash(),
      lastKnownIp: genericPrinterDE.lastKnownIp!.getOrCrash(),
      entityTypes: genericPrinterDE.entityTypes.getOrCrash(),
      compUuid: genericPrinterDE.compUuid.getOrCrash(),
      deviceVendor: genericPrinterDE.deviceVendor.getOrCrash(),
      // serverTimeStamp: FieldValue.serverTimestamp(),
    );
  }

  factory GenericPrinterDeviceDtos.fromJson(Map<String, dynamic> json) =>
      _$GenericPrinterDeviceDtosFromJson(json);

  @override
  final String deviceDtoClassInstance = (GenericPrinterDeviceDtos).toString();

  @override
  DeviceEntityAbstract toDomain() {
    return GenericPrinterDE(
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
      printerSwitchState: GenericPrinterSwitchState(printerSwitchState),
      lastKnownIp: DeviceLastKnownIp(lastKnownIp),
    );
  }
}
