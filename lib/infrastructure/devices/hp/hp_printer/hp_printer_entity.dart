import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/generic_printer_device/generic_printer_entity.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:dartz/dartz.dart';

class HpPrinterEntity extends GenericPrinterDE {
  HpPrinterEntity({
    required super.uniqueId,
    required super.vendorUniqueId,
    required super.defaultName,
    required super.deviceStateGRPC,
    required super.stateMassage,
    required super.senderDeviceOs,
    required super.senderDeviceModel,
    required super.senderId,
    required super.compUuid,
    required super.powerConsumption,
    required super.printerSwitchState,
    required this.deviceMdnsName,
    required this.devicePort,
    required super.lastKnownIp,
  }) : super(
          deviceVendor: DeviceVendor(VendorsAndServices.hp.toString()),
        );

  static const List<String> mdnsTypes = [
    '_ipp._tcp',
  ];

  DeviceMdnsName deviceMdnsName;

  DevicePort devicePort;

  @override
  Future<Either<CoreFailure, Unit>> executeDeviceAction({
    required DeviceEntityAbstract newEntity,
  }) async {
    // logger.i('Currently printer does not support any action');
    // deviceStateGRPC = DeviceState(DeviceStateGRPC.ack.toString());
    //
    // getIt<IMqttServerRepository>().postSmartDeviceToAppMqtt(
    //   entityFromTheHub: this,
    // );

    // deviceStateGRPC = DeviceState(DeviceStateGRPC.newStateFailed.toString());
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
