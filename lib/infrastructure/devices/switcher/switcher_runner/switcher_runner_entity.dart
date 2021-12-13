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
import 'package:cbj_hub/utils.dart';
import 'package:dartz/dartz.dart';

class SwitcherRunnerEntity extends GenericBlindsDE {
  SwitcherRunnerEntity({
    required CoreUniqueId uniqueId,
    required VendorUniqueId vendorUniqueId,
    required DeviceDefaultName defaultName,
    required DeviceState deviceStateGRPC,
    required DeviceStateMassage stateMassage,
    required DeviceSenderDeviceOs senderDeviceOs,
    required DeviceSenderDeviceModel senderDeviceModel,
    required DeviceSenderId senderId,
    required DeviceCompUuid compUuid,
    required DevicePowerConsumption powerConsumption,
    required GenericBlindsSwitchState blindsSwitchState,
    required this.switcherMacAddress,
    required this.lastKnownIp,
    this.switcherPort,
  }) : super(
          uniqueId: uniqueId,
          vendorUniqueId: vendorUniqueId,
          defaultName: defaultName,
          deviceStateGRPC: deviceStateGRPC,
          stateMassage: stateMassage,
          senderDeviceOs: senderDeviceOs,
          senderDeviceModel: senderDeviceModel,
          senderId: senderId,
          deviceVendor:
              DeviceVendor(VendorsAndServices.switcherSmartHome.toString()),
          compUuid: compUuid,
          powerConsumption: powerConsumption,
          blindsSwitchState: blindsSwitchState,
        ) {
    if (switcherPort == null) {
      switcherPort =
          SwitcherPort(SwitcherApiObject.switcherTcpPort2.toString());
    }
    switcherObject = SwitcherApiObject(
      deviceType: SwitcherDevicesTypes.switcherRunner,
      deviceId: vendorUniqueId.getOrCrash(),
      switcherIp: lastKnownIp.getOrCrash(),
      switcherName: defaultName.getOrCrash()!,
      macAddress: switcherMacAddress.getOrCrash(),
      powerConsumption: powerConsumption.getOrCrash(),
      port: int.parse(switcherPort!.getOrCrash()),
    );
  }

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
  Future<Either<CoreFailure, Unit>> executeDeviceAction({
    required DeviceEntityAbstract newEntity,
  }) async {
    if (newEntity is! GenericBlindsDE) {
      return left(
        const CoreFailure.actionExcecuter(failedValue: 'Not the correct type'),
      );
    }

    if (newEntity.blindsSwitchState!.getOrCrash() !=
        blindsSwitchState!.getOrCrash()) {
      final DeviceActions? actionToPreform = EnumHelper.stringToDeviceAction(
        newEntity.blindsSwitchState!.getOrCrash(),
      );

      if (actionToPreform.toString() != blindsSwitchState!.getOrCrash()) {
        if (actionToPreform == DeviceActions.moveUp) {
          (await moveUpBlinds()).fold(
            (l) => logger.e('Error turning blinds up'),
            (r) => logger.i('Blinds up success'),
          );
        } else if (actionToPreform == DeviceActions.stop) {
          (await stopBlinds()).fold(
            (l) => logger.e('Error stopping blinds '),
            (r) => logger.i('Blinds stop success'),
          );
        } else if (actionToPreform == DeviceActions.moveDown) {
          (await moveDownBlinds()).fold(
            (l) => logger.e('Error turning blinds down'),
            (r) => logger.i('Blinds down success'),
          );
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
  }
}
