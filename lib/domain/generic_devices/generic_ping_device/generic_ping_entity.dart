import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/generic_ping_device/generic_ping_value_objects.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/infrastructure/generic_devices/abstract_device/device_entity_dto_abstract.dart';
import 'package:cbj_hub/infrastructure/generic_devices/generic_ping_device/generic_ping_device_dtos.dart';
import 'package:cbj_hub/utils.dart';
import 'package:dartz/dartz.dart';

/// Abstract smart GenericPing that exist inside a computer, the
/// implementations will be actual GenericPing like blinds pings and more
class GenericPingDE extends DeviceEntityAbstract {
  /// All public field of GenericPing entity
  GenericPingDE({
    required CoreUniqueId uniqueId,
    required CoreUniqueId roomId,
    required DeviceVendor deviceVendor,
    required DeviceDefaultName defaultName,
    required DeviceRoomName roomName,
    required DeviceState deviceStateGRPC,
    required DeviceStateMassage stateMassage,
    required DeviceSenderDeviceOs senderDeviceOs,
    required DeviceSenderDeviceModel senderDeviceModel,
    required DeviceSenderId senderId,
    required DeviceCompUuid compUuid,
    DevicePowerConsumption? powerConsumption,
    required this.pingSwitchState,
  }) : super(
          uniqueId: uniqueId,
          defaultName: defaultName,
          roomId: roomId,
          deviceTypes: DeviceType(DeviceTypes.typeNotSupported.toString()),
          deviceVendor: deviceVendor,
          deviceStateGRPC: deviceStateGRPC,
          compUuid: compUuid,
          roomName: roomName,
          senderDeviceModel: senderDeviceModel,
          senderDeviceOs: senderDeviceOs,
          senderId: senderId,
          stateMassage: stateMassage,
        );

  /// Ping instance of GenericPingEntity
  factory GenericPingDE.empty() => GenericPingDE(
        uniqueId: CoreUniqueId(),
        defaultName: DeviceDefaultName('Ping device'),
        roomId: CoreUniqueId.newDevicesRoom(),
        roomName: DeviceRoomName('Discovered'),
        deviceStateGRPC: DeviceState(DeviceStateGRPC.pingNow.toString()),
        senderDeviceOs: DeviceSenderDeviceOs('Hub'),
        senderDeviceModel: DeviceSenderDeviceModel('Hub'),
        stateMassage: DeviceStateMassage('Test'),
        senderId: DeviceSenderId(),
        deviceVendor: DeviceVendor(
          VendorsAndServices.vendorsAndServicesNotSupported.toString(),
        ),
        compUuid: DeviceCompUuid('Test'),
        powerConsumption: DevicePowerConsumption('Test'),
        pingSwitchState: GenericPingSwitchState(DeviceActions.off.toString()),
      );

  /// State of the ping on/off
  GenericPingSwitchState? pingSwitchState;

  //
  // /// Will return failure if any of the fields failed or return unit if fields
  // /// have legit values
  Option<CoreFailure<dynamic>> get failureOption =>
      defaultName.value.fold((f) => some(f), (_) => none());
  //
  // return body.failureOrUnit
  //     .andThen(todos.failureOrUnit)
  //     .andThen(
  //       todos
  //           .getOrCrash()
  //           // Getting the failureOption from the TodoItem ENTITY - NOT a failureOrUnit from a VALUE OBJECT
  //           .map((todoItem) => todoItem.failureOption)
  //           .filter((o) => o.isSome())
  //           // If we can't get the 0th element, the list is ping. In such a case, it's valid.
  //           .getOrElse(0, (_) => none())
  //           .fold(() => right(unit), (f) => left(f)),
  //     )
  //     .fold((f) => some(f), (_) => none());
  // }

  @override
  String getDeviceId() {
    return uniqueId.getOrCrash()!;
  }

  @override
  DeviceEntityDtoAbstract toInfrastructure() {
    return GenericPingDeviceDtos(
      deviceDtoClass: (GenericPingDeviceDtos).toString(),
      id: uniqueId.getOrCrash(),
      defaultName: defaultName.getOrCrash(),
      roomId: roomId.getOrCrash(),
      roomName: roomName.getOrCrash(),
      deviceStateGRPC: deviceStateGRPC.getOrCrash(),
      stateMassage: stateMassage.getOrCrash(),
      senderDeviceOs: senderDeviceOs.getOrCrash(),
      senderDeviceModel: senderDeviceModel.getOrCrash(),
      senderId: senderId.getOrCrash(),
      deviceTypes: deviceTypes.getOrCrash(),
      compUuid: compUuid.getOrCrash(),
      pingSwitchState: pingSwitchState!.getOrCrash(),
      deviceVendor: deviceVendor.getOrCrash(),
      // serverTimeStamp: FieldValue.serverTimestamp(),
    );
  }

  /// Please override the following methods
  @override
  Future<Either<CoreFailure, Unit>> executeDeviceAction(
    DeviceEntityAbstract newEntity,
  ) async {
    logger.w('Please override this method in the non generic implementation');
    return left(
      const CoreFailure.actionExcecuter(
        failedValue: 'Action does not exist',
      ),
    );
  }

  /// Please override the following methods
  Future<Either<CoreFailure, Unit>> turnOnPing() async {
    logger.w('Please override this method in the non generic implementation');
    return left(
      const CoreFailure.actionExcecuter(
        failedValue: 'Action does not exist',
      ),
    );
  }

  /// Please override the following methods
  Future<Either<CoreFailure, Unit>> turnOffPing() async {
    logger.w('Please override this method in the non generic implementation');
    return left(
      const CoreFailure.actionExcecuter(
        failedValue: 'Action does not exist',
      ),
    );
  }
}
