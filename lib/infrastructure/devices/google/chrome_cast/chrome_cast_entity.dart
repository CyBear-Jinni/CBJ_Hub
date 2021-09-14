import 'dart:async';

import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/device_type_enums.dart';
import 'package:cbj_hub/domain/generic_devices/generic_rgbw_light_device/generic_rgbw_light_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_smart_tv/generic_smart_tv_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_smart_tv/generic_smart_tv_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/google/google_device_value_objects.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:dartz/dartz.dart';
import 'package:cbj_hub/utils.dart';

class ChromeCastEntity extends GenericSmartTvDE {
  ChromeCastEntity({
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
    required GenericSmartTvSwitchState smartTvSwitchState,
    required this.googleDeviceId,
    required this.googlePort,
    this.deviceMdnsName,
    this.lastKnownIp,
  }) : super(
          uniqueId: uniqueId,
          defaultName: defaultName,
          roomId: roomId,
          smartTvSwitchState: smartTvSwitchState,
          roomName: roomName,
          deviceStateGRPC: deviceStateGRPC,
          stateMassage: stateMassage,
          senderDeviceOs: senderDeviceOs,
          senderDeviceModel: senderDeviceModel,
          senderId: senderId,
          deviceVendor: DeviceVendor(VendorsAndServices.google.toString()),
          compUuid: compUuid,
          powerConsumption: powerConsumption,
        );

  /// Google device unique id that came withe the device
  GoogleDeviceId? googleDeviceId;

  /// Google communication port
  GooglePort? googlePort;

  DeviceLastKnownIp? lastKnownIp;

  DeviceMdnsName? deviceMdnsName;

  /// Please override the following methods
  @override
  Future<Either<CoreFailure, Unit>> executeDeviceAction(
      DeviceEntityAbstract newEntity) async {
    if (newEntity is! GenericRgbwLightDE) {
      return left(const CoreFailure.actionExcecuter(
          failedValue: 'Not the correct type'));
    }

    if (newEntity.lightSwitchState!.getOrCrash() !=
        smartTvSwitchState!.getOrCrash()) {
      final DeviceActions? actionToPreform = EnumHelper.stringToDeviceAction(
          newEntity.lightSwitchState!.getOrCrash());

      if (actionToPreform.toString() != smartTvSwitchState!.getOrCrash()) {
        if (actionToPreform == DeviceActions.on) {
          (await turnOnLight()).fold(
              (l) => logger.e('Error turning chrome cast light on'),
              (r) => print('Light turn on success'));
        } else if (actionToPreform == DeviceActions.off) {
          (await turnOffLight()).fold(
              (l) => logger.e('Error turning chrome cast light off'),
              (r) => print('Light turn off success'));
        } else {
          logger.e('actionToPreform is not set correctly on Chrome Cast');
        }
      }
    }

    return right(unit);
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOnLight() async {
    try {} catch (e) {
      return left(const CoreFailure.unexpected());
    }
    return left(const CoreFailure.unexpected());
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOffLight() async {
    try {} catch (e) {
      return left(const CoreFailure.unexpected());
    }
    return left(const CoreFailure.unexpected());
  }
}
