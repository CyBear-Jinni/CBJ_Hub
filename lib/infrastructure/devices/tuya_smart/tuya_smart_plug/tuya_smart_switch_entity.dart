import 'dart:async';

import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/device_type_enums.dart';
import 'package:cbj_hub/domain/generic_devices/generic_smart_plug_device/generic_switch_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_smart_plug_device/generic_switch_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/tuya_smart/tuya_smart_device_validators.dart';
import 'package:cbj_hub/infrastructure/devices/tuya_smart/tuya_smart_remote_api/cloudtuya.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/utils.dart';
import 'package:dartz/dartz.dart';
import 'package:yeedart/yeedart.dart';

class TuyaSmartPlugEntity extends GenericSmartPlugDE {
  TuyaSmartPlugEntity({
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
    required GenericSmartPlugState smartPlugState,
    required this.cloudTuya,
  }) : super(
          uniqueId: uniqueId,
          vendorUniqueId: vendorUniqueId,
          defaultName: defaultName,
          smartPlugState: smartPlugState,
          deviceStateGRPC: deviceStateGRPC,
          stateMassage: stateMassage,
          senderDeviceOs: senderDeviceOs,
          senderDeviceModel: senderDeviceModel,
          senderId: senderId,
          deviceVendor: DeviceVendor(VendorsAndServices.tuyaSmart.toString()),
          compUuid: compUuid,
          powerConsumption: powerConsumption,
        );

  /// TuyaSmart package object require to close previews request before new one
  Device? tuyaSmartPackageObject;

  /// Will be the cloud api reference, can be Tuya or Jinvoo Smart or Smart Life
  CloudTuya cloudTuya;

  @override
  Future<Either<CoreFailure, Unit>> executeDeviceAction({
    required DeviceEntityAbstract newEntity,
  }) async {
    if (newEntity is! GenericSmartPlugDE) {
      return left(
        const CoreFailure.actionExcecuter(
          failedValue: 'Not the correct type',
        ),
      );
    }

    try {
      if (newEntity.smartPlugState!.getOrCrash() !=
              smartPlugState!.getOrCrash() ||
          deviceStateGRPC.getOrCrash() != DeviceStateGRPC.ack.toString()) {
        final DeviceActions? actionToPreform = EnumHelper.stringToDeviceAction(
          newEntity.smartPlugState!.getOrCrash(),
        );

        if (actionToPreform == DeviceActions.on) {
          (await turnOnLight()).fold(
            (l) {
              logger.e('Error turning Tuya plug on\n$l');
              throw l;
            },
            (r) {
              logger.i('Tuya plug turn on success');
            },
          );
        } else if (actionToPreform == DeviceActions.off) {
          (await turnOffLight()).fold(
            (l) {
              logger.e('Error turning Tuya off\n$l');
              throw l;
            },
            (r) {
              logger.i('Tuya plug turn off success');
            },
          );
        } else {
          logger.w(
            'actionToPreform is not set correctly on Tuya Plug',
          );
        }
      }
      deviceStateGRPC = DeviceState(DeviceStateGRPC.ack.toString());
      return right(unit);
    } catch (e) {
      deviceStateGRPC = DeviceState(DeviceStateGRPC.newStateFailed.toString());
      return left(const CoreFailure.unexpected());
    }
  }

  Future<Either<CoreFailure, Unit>> turnOnLight() async {
    smartPlugState = GenericSmartPlugState(DeviceActions.on.toString());
    try {
      final String requestResponse = await cloudTuya.turnOn(
        vendorUniqueId.getOrCrash(),
      );
      return tuyaResponseToCyBearJinniSucessFailure(requestResponse);
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }

  Future<Either<CoreFailure, Unit>> turnOffLight() async {
    smartPlugState = GenericSmartPlugState(DeviceActions.off.toString());

    try {
      final String requestResponse = await cloudTuya.turnOff(
        vendorUniqueId.getOrCrash(),
      );
      return tuyaResponseToCyBearJinniSucessFailure(requestResponse);
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }
}
