import 'dart:async';

import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/device_type_enums.dart';
import 'package:cbj_hub/domain/generic_devices/generic_light_device/generic_light_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_light_with_brightness_device/generic_light_with_brightness_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_light_with_brightness_device/generic_light_with_brightness_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/philips_hue/philips_hue_api/philips_hue_api_light.dart';
import 'package:cbj_hub/infrastructure/devices/philips_hue/philips_hue_device_value_objects.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/utils.dart';
import 'package:dartz/dartz.dart';
import 'package:yeedart/yeedart.dart';

class PhilipsHueE26Entity extends GenericLightWithBrightnessDE {
  PhilipsHueE26Entity({
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
    required super.lightBrightness,
    required this.philipsHueApiLight,
    required this.philipsHuePort,
    this.deviceMdnsName,
    this.lastKnownIp,
  }) : super(
          deviceVendor: DeviceVendor(
            VendorsAndServices.philipsHue.toString(),
          ),
        );

  /// PhilipsHue communication port
  PhilipsHuePort? philipsHuePort;

  DeviceLastKnownIp? lastKnownIp;

  DeviceMdnsName? deviceMdnsName;

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
          deviceStateGRPC.getOrCrash() != DeviceStateGRPC.ack.toString()) {
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
    lightSwitchState =
        GenericLightWithBrightnessSwitchState(DeviceActions.on.toString());

    try {
      await philipsHueApiLight.turnLightOn(vendorUniqueId.getOrCrash());

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
      await philipsHueApiLight.turnLightOff(vendorUniqueId.getOrCrash());

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
      vendorUniqueId.getOrCrash(),
      brightnessInt,
    );

    return left(
      const CoreFailure.actionExcecuter(
        failedValue: 'Action does not exist',
      ),
    );
  }
}
