import 'dart:async';

import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/device_type_enums.dart';
import 'package:cbj_hub/domain/generic_devices/generic_blinds_device/generic_blinds_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_blinds_device/generic_blinds_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/switcher/switcher_api/switcher_api_object.dart';
import 'package:cbj_hub/infrastructure/devices/switcher/switcher_device_value_objects.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:dartz/dartz.dart';
import 'package:cbj_hub/utils.dart';

class SwitcherRunnerEntity extends GenericBlindsDE {
  SwitcherRunnerEntity({
    required CoreUniqueId uniqueId,
    required CoreUniqueId roomId,
    required DeviceDefaultName defaultName,
    required DeviceRoomName roomName,
    required DeviceState deviceStateGRPC,
    required DeviceStateMassage stateMassage,
    required DeviceSenderDeviceOs senderDeviceOs,
    required DeviceSenderDeviceModel senderDeviceModel,
    required DeviceSenderId senderId,
    required DeviceCompUuid compUuid,
    required DevicePowerConsumption powerConsumption,
    required GenericBlindsSwitchState blindsSwitchState,
    required this.switcherMacAddress,
    required this.switcherDeviceId,
    required this.lastKnownIp,
    this.switcherPort,
  }) : super(
          uniqueId: uniqueId,
          defaultName: defaultName,
          roomId: roomId,
          roomName: roomName,
          deviceStateGRPC: deviceStateGRPC,
          stateMassage: stateMassage,
          senderDeviceOs: senderDeviceOs,
          senderDeviceModel: senderDeviceModel,
          senderId: senderId,
          deviceVendor: DeviceVendor(VendorsAndServices.switcher.toString()),
          compUuid: compUuid,
          powerConsumption: powerConsumption,
          blindsSwitchState: blindsSwitchState,
        ) {
    if (switcherPort == null) {
      switcherPort =
          SwitcherPort(SwitcherApiObject.SWITCHER_TCP_PORT2.toString());
    }
    switcherObject = SwitcherApiObject(
        deviceType: SwitcherDevicesTypes.switcherRunner,
        deviceId: switcherDeviceId.getOrCrash(),
        switcherIp: lastKnownIp.getOrCrash(),
        switcherName: defaultName.getOrCrash()!,
        macAddress: switcherMacAddress.getOrCrash(),
        powerConsumption: powerConsumption.getOrCrash(),
        port: int.parse(switcherPort!.getOrCrash()));
  }

  /// Switcher device unique id that came withe the device
  SwitcherDeviceId switcherDeviceId;
  SwitcherMacAddress switcherMacAddress;

  /// Switcher communication port
  SwitcherPort? switcherPort;

  DeviceLastKnownIp lastKnownIp;

  /// Switcher package object require to close previews request before new one
  SwitcherApiObject? switcherObject;

  String? autoShutdown;
  String? electricCurrent;
  String? lastDataUpdate;
  String? macAddress;
  String? remainingTime;

  /// Please override the following methods
  @override
  Future<Either<CoreFailure, Unit>> executeDeviceAction(
      DeviceEntityAbstract newEntity) async {
    if (newEntity is! GenericBlindsDE) {
      return left(const CoreFailure.actionExcecuter(
          failedValue: 'Not the correct type'));
    }

    if (newEntity.blindsSwitchState!.getOrCrash() !=
        blindsSwitchState!.getOrCrash()) {
      final DeviceActions? actionToPreform = EnumHelper.stringToDeviceAction(
          newEntity.blindsSwitchState!.getOrCrash());

      if (actionToPreform.toString() != blindsSwitchState!.getOrCrash()) {
        if (actionToPreform == DeviceActions.moveUp) {
          (await moveUpBlinds()).fold(
              (l) => logger.e('Error turning blinds up'),
              (r) => print('Blinds up success'));
        } else if (actionToPreform == DeviceActions.stop) {
          (await stopBlinds()).fold((l) => logger.e('Error stopping blinds '),
              (r) => print('Blinds stop success'));
        } else if (actionToPreform == DeviceActions.moveDown) {
          (await moveDownBlinds()).fold(
              (l) => logger.e('Error turning blinds down'),
              (r) => print('Blinds down success'));
        } else {
          logger.e('actionToPreform is not set correctly on Switcher Runner');
        }
      }
    }

    return right(unit);
  }

  @override
  Future<Either<CoreFailure, Unit>> moveUpBlinds() async {
    blindsSwitchState =
        GenericBlindsSwitchState(DeviceActions.moveUp.toString());

    try {
      await switcherObject!.setPosition(pos: 100);
      return right(unit);
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }

  @override
  Future<Either<CoreFailure, Unit>> stopBlinds() async {
    blindsSwitchState = GenericBlindsSwitchState(DeviceActions.stop.toString());

    // TODO: Implement stop function for switcher blinds

    try {
      // await switcherObject!.stopBlinds();
      return right(unit);
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }

  @override
  Future<Either<CoreFailure, Unit>> moveDownBlinds() async {
    blindsSwitchState =
        GenericBlindsSwitchState(DeviceActions.moveDown.toString());

    try {
      await switcherObject!.setPosition();
      return right(unit);
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
    return left(const CoreFailure.unexpected());
  }
}
