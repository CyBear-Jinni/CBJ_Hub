import 'dart:async';

import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/device_type_enums.dart';
import 'package:cbj_hub/domain/generic_devices/generic_light_device/generic_light_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_light_with_brightness_device/generic_light_with_brightness_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_light_with_brightness_device/generic_light_with_brightness_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/philips_hue/philips_hue_api/philips_hue_api_light.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/utils.dart';
import 'package:dartz/dartz.dart';
import 'package:yeedart/yeedart.dart';

class PhilipsHueE26Entity extends GenericLightWithBrightnessDE {
  PhilipsHueE26Entity({
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
    required super.lightSwitchState,
    required super.lightBrightness,
    required this.philipsHueApiLight,
    this.philipsHuePackageObject,
  }) : super(
          deviceVendor: DeviceVendor(
            VendorsAndServices.philipsHue.toString(),
          ),
        );

  /// PhilipsHue package object require to close previews request before new one
  Device? philipsHuePackageObject;

  PhilipsHueApiLight philipsHueApiLight;

  /// Please override the following methods
  @override
  Future<Either<CoreFailure, Unit>> executeDeviceAction({
    required DeviceEntityAbstract newEntity,
  }) async {
    // TODO: Fix line not working with GenericLightWithBrightnessDE
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
          entityStateGRPC.getOrCrash() != DeviceStateGRPC.ack.toString()) {
        final DeviceActions? actionToPreform =
            EnumHelperCbj.stringToDeviceAction(
          newEntity.lightSwitchState!.getOrCrash(),
        );

        if (actionToPreform == DeviceActions.on) {
          (await turnOnLight()).fold(
            (l) {
              logger.e('Error turning philips_hue light on');
              throw l;
            },
            (r) {
              logger.i('Philips Hue light turn on success');
            },
          );
        } else if (actionToPreform == DeviceActions.off) {
          (await turnOffLight()).fold(
            (l) {
              logger.e('Error turning philips_hue light off');
              throw l;
            },
            (r) {
              logger.i('Philips Hue light turn off success');
            },
          );
        } else {
          logger.w('actionToPreform is not set correctly on PhilipsHue E26');
        }
      }
      entityStateGRPC = EntityState(DeviceStateGRPC.ack.toString());

      // getIt<IMqttServerRepository>().postSmartDeviceToAppMqtt(
      //   entityFromTheHub: this,
      // );
      return right(unit);
    } catch (e) {
      entityStateGRPC = EntityState(DeviceStateGRPC.newStateFailed.toString());
      // getIt<IMqttServerRepository>().postSmartDeviceToAppMqtt(
      //   entityFromTheHub: this,
      // );
      return left(const CoreFailure.unexpected());
    }
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOnLight() async {
    lightSwitchState =
        GenericLightWithBrightnessSwitchState(DeviceActions.on.toString());

    try {
      await philipsHueApiLight.turnLightOn(entityUniqueId.getOrCrash());

      return right(unit);
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOffLight() async {
    lightSwitchState =
        GenericLightWithBrightnessSwitchState(DeviceActions.off.toString());

    try {
      await philipsHueApiLight.turnLightOff(entityUniqueId.getOrCrash());

      return right(unit);
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }

  @override
  Future<Either<CoreFailure, Unit>> setBrightness(String brightness) async {
    final int? brightnessInt = int.tryParse(brightness);
    if (brightnessInt == null) {
      return left(
        const CoreFailure.actionExcecuter(
          failedValue: "brightnessInt can't be converted to int",
        ),
      );
    }

    lightBrightness =
        GenericLightWithBrightnessBrightness(brightnessInt.toString());

    await philipsHueApiLight.setLightBrightness(
      entityUniqueId.getOrCrash(),
      brightnessInt,
    );

    return left(
      const CoreFailure.actionExcecuter(
        failedValue: 'Action does not exist',
      ),
    );
  }
}
