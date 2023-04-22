import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/generic_printer_device/generic_printer_entity.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:dartz/dartz.dart';

class HpPrinterEntity extends GenericPrinterDE {
  HpPrinterEntity({
    required super.uniqueId,
    required super.entityUniqueId,
    required super.cbjEntityName,
    required super.entityOriginalName,
    required super.deviceOriginalName,
    required super.stateMassage,
    required super.senderDeviceOs,
    required super.senderDeviceModel,
    required super.senderId,
    required super.compUuid,
    required super.entityStateGRPC,
    required super.powerConsumption,
    required super.deviceUniqueId,
    required super.devicePort,
    required super.deviceLastKnownIp,
    required super.deviceHostName,
    required super.deviceMdns,
    required super.devicesMacAddress,
    required super.entityKey,
    required super.requestTimeStamp,
    required super.lastResponseFromDeviceTimeStamp,
    required super.deviceCbjUniqueId,
    required super.printerSwitchState,
  }) : super(
          deviceVendor: DeviceVendor(VendorsAndServices.hp.toString()),
        );

  factory HpPrinterEntity.fromGeneric(GenericPrinterDE genericDevice) {
    return HpPrinterEntity(
      uniqueId: genericDevice.uniqueId,
      entityUniqueId: genericDevice.entityUniqueId,
      cbjEntityName: genericDevice.cbjEntityName,
      entityOriginalName: genericDevice.entityOriginalName,
      deviceOriginalName: genericDevice.deviceOriginalName,
      stateMassage: genericDevice.stateMassage,
      senderDeviceOs: genericDevice.senderDeviceOs,
      senderDeviceModel: genericDevice.senderDeviceModel,
      senderId: genericDevice.senderId,
      compUuid: genericDevice.compUuid,
      entityStateGRPC: genericDevice.entityStateGRPC,
      powerConsumption: genericDevice.powerConsumption,
      deviceUniqueId: genericDevice.deviceUniqueId,
      devicePort: genericDevice.devicePort,
      deviceLastKnownIp: genericDevice.deviceLastKnownIp,
      deviceHostName: genericDevice.deviceHostName,
      deviceMdns: genericDevice.deviceMdns,
      devicesMacAddress: genericDevice.devicesMacAddress,
      entityKey: genericDevice.entityKey,
      requestTimeStamp: genericDevice.requestTimeStamp,
      lastResponseFromDeviceTimeStamp:
          genericDevice.lastResponseFromDeviceTimeStamp,
      deviceCbjUniqueId: genericDevice.deviceCbjUniqueId,
      printerSwitchState: genericDevice.printerSwitchState,
    );
  }

  static const List<String> mdnsTypes = [
    '_ipp._tcp',
  ];

  @override
  Future<Either<CoreFailure, Unit>> executeDeviceAction({
    required DeviceEntityAbstract newEntity,
  }) async {
    // logger.i('Currently printer does not support any action');
    // entityStateGRPC = EntityState(EntityStateGRPC.ack.toString());
    //
    // getIt<IMqttServerRepository>().postSmartDeviceToAppMqtt(
    //   entityFromTheHub: this,
    // );

    // entityStateGRPC = EntityState(EntityStateGRPC.newStateFailed.toString());
    // getIt<IMqttServerRepository>().postSmartDeviceToAppMqtt(
    //   entityFromTheHub: this,
    // );

    return right(unit);
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOnPrinter() async {
    return right(unit);
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOffPrinter() async {
    return right(unit);
  }
}
