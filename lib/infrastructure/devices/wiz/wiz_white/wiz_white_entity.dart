import 'dart:async';

import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/device_type_enums.dart';
import 'package:cbj_hub/domain/generic_devices/generic_light_device/generic_light_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_light_device/generic_light_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/wiz/wiz_device_value_objects.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/utils.dart';
import 'package:dartz/dartz.dart';

class WizWhiteEntity extends GenericLightDE {
  WizWhiteEntity({
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
    required super.lightSwitchState,
  }) : super(
          deviceVendor: DeviceVendor(VendorsAndServices.wiz.toString()),
        );

  WizPort? wizPort;

  /// Please override the following methods
  @override
  Future<Either<CoreFailure, Unit>> executeDeviceAction({
    required DeviceEntityAbstract newEntity,
  }) async {
    if (newEntity is! GenericLightDE) {
      return left(
        const CoreFailure.actionExcecuter(
          failedValue: 'Not the correct type',
        ),
      );
    }

    try {
      if (newEntity.lightSwitchState!.getOrCrash() !=
              lightSwitchState!.getOrCrash() ||
          deviceStateGRPC.getOrCrash() != DeviceStateGRPC.ack.toString()) {
        final DeviceActions? actionToPreform =
            EnumHelperCbj.stringToDeviceAction(
          newEntity.lightSwitchState!.getOrCrash(),
        );

        if (actionToPreform == DeviceActions.on) {
          (await turnOnLight()).fold((l) {
            logger.e('Error turning Wiz light on');
            throw l;
          }, (r) {
            logger.i('Wiz light turn on success');
          });
        } else if (actionToPreform == DeviceActions.off) {
          (await turnOffLight()).fold((l) {
            logger.e('Error turning Wiz light off');
            throw l;
          }, (r) {
            logger.i('Wiz light turn off success');
          });
        } else {
          logger.w('actionToPreform is not set correctly on Wiz White');
        }
      }
      deviceStateGRPC = DeviceState(DeviceStateGRPC.ack.toString());
      // getIt<IMqttServerRepository>().postSmartDeviceToAppMqtt(
      //   entityFromTheHub: this,
      // );
      return right(unit);
    } catch (e) {
      deviceStateGRPC = DeviceState(DeviceStateGRPC.newStateFailed.toString());
      // getIt<IMqttServerRepository>().postSmartDeviceToAppMqtt(
      //   entityFromTheHub: this,
      // );
      return left(const CoreFailure.unexpected());
    }
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOnLight() async {
    lightSwitchState = GenericLightSwitchState(DeviceActions.on.toString());
    try {
      // final setStateBodyResponse =
      //     await WizConnectorConjector.wizClient?.setState(
      //   // Selector.id(vendorUniqueId.getOrCrash()),
      //   power: 'on',
      //   fast: true,
      // );
      // if (setStateBodyResponse == null) {
      //   throw 'setStateBodyResponse is null';
      // }
      //
      // return right(unit);
    } catch (e) {
      // As we are using the fast = true the response is always
      // WizHttpException Error
      return left(const CoreFailure.unexpected());
    }
    return left(const CoreFailure.unexpected());
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOffLight() async {
    lightSwitchState = GenericLightSwitchState(DeviceActions.off.toString());

    try {
      // final setStateBodyResponse =
      //     await WizConnectorConjector.wizClient?.setState(
      // Selector.id(vendorUniqueId.getOrCrash()),
      //   power: 'off',
      //   fast: true,
      // );
      // if (setStateBodyResponse == null) {
      //   throw 'setStateBodyResponse is null';
      // }
      // return right(unit);
    } catch (e) {
      // As we are using the fast = true the response is always
      // WizHttpException Error
      return left(const CoreFailure.unexpected());
    }
    return left(const CoreFailure.unexpected());
  }
}
