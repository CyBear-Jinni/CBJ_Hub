import 'dart:async';

import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/device_type_enums.dart';
import 'package:cbj_hub/domain/generic_devices/generic_rgbw_light_device/generic_rgbw_light_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_rgbw_light_device/generic_rgbw_light_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/tuya_smart/tuya_smart_device_validators.dart';
import 'package:cbj_hub/infrastructure/devices/tuya_smart/tuya_smart_remote_api/cloudtuya.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/utils.dart';
import 'package:dartz/dartz.dart';

class TuyaSmartJbtA70RgbcwWfEntity extends GenericRgbwLightDE {
  TuyaSmartJbtA70RgbcwWfEntity({
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
    required super.lightColorTemperature,
    required super.lightBrightness,
    required super.lightColorAlpha,
    required super.lightColorHue,
    required super.lightColorSaturation,
    required super.lightColorValue,
    required this.cloudTuya,
  }) : super(
          deviceVendor: DeviceVendor(VendorsAndServices.tuyaSmart.toString()),
        );

  /// Will be the cloud api reference, can be Tuya or Jinvoo Smart or Smart Life
  CloudTuya cloudTuya;

  /// Please override the following methods
  @override
  Future<Either<CoreFailure, Unit>> executeDeviceAction({
    required DeviceEntityAbstract newEntity,
  }) async {
    if (newEntity is! GenericRgbwLightDE) {
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
              logger.e('Error turning Tuya light on\n$l');
              throw l;
            },
            (r) {
              logger.d('Tuya light turn on success');
              deviceStateGRPC = DeviceState(DeviceStateGRPC.ack.toString());
            },
          );
        } else if (actionToPreform == DeviceActions.off) {
          (await turnOffLight()).fold(
            (l) {
              logger.e('Error turning Tuya light off\n$l');
              throw l;
            },
            (r) {
              logger.d('Tuya light turn off success');
              deviceStateGRPC = DeviceState(DeviceStateGRPC.ack.toString());
            },
          );
        } else {
          logger.w(
            'actionToPreform is not set correctly on TuyaSmart'
            ' JbtA70RgbcwWfEntity',
          );
        }
      }

      if (newEntity.lightColorTemperature.getOrCrash() !=
              lightColorTemperature.getOrCrash() ||
          deviceStateGRPC.getOrCrash() != DeviceStateGRPC.ack.toString()) {
        (await changeColorTemperature(
          lightColorTemperatureNewValue:
              newEntity.lightColorTemperature.getOrCrash(),
        ))
            .fold(
          (l) {
            logger.e('Error changing Tuya temperature\n$l');
            throw l;
          },
          (r) {
            logger.i('Tuya changed temperature successfully');
          },
        );
      }

      if (newEntity.lightColorAlpha.getOrCrash() !=
              lightColorAlpha.getOrCrash() ||
          newEntity.lightColorHue.getOrCrash() != lightColorHue.getOrCrash() ||
          newEntity.lightColorSaturation.getOrCrash() !=
              lightColorSaturation.getOrCrash() ||
          newEntity.lightColorValue.getOrCrash() !=
              lightColorValue.getOrCrash() ||
          deviceStateGRPC.getOrCrash() != DeviceStateGRPC.ack.toString()) {
        (await changeColorHsv(
          lightColorAlphaNewValue: newEntity.lightColorAlpha.getOrCrash(),
          lightColorHueNewValue: newEntity.lightColorHue.getOrCrash(),
          lightColorSaturationNewValue:
              newEntity.lightColorSaturation.getOrCrash(),
          lightColorValueNewValue: newEntity.lightColorValue.getOrCrash(),
        ))
            .fold(
          (l) {
            logger.e('Error changing Tuya light color\n$l');
            throw l;
          },
          (r) {
            logger.i('Light changed color successfully');
          },
        );
      }

      if (newEntity.lightBrightness.getOrCrash() !=
          lightBrightness.getOrCrash()) {
        (await setBrightness(newEntity.lightBrightness.getOrCrash())).fold(
          (l) {
            logger.e('Error changing Tuya brightness\n$l');
            throw l;
          },
          (r) {
            logger.i('Tuya changed brightness successfully');
          },
        );
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
    lightSwitchState = GenericRgbwLightSwitchState(DeviceActions.on.toString());
    try {
      final String requestResponse = await cloudTuya.turnOn(
        vendorUniqueId.getOrCrash(),
      );
      return tuyaResponseToCyBearJinniSucessFailure(requestResponse);
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOffLight() async {
    lightSwitchState =
        GenericRgbwLightSwitchState(DeviceActions.off.toString());

    try {
      final String requestResponse = await cloudTuya.turnOff(
        vendorUniqueId.getOrCrash(),
      );
      return tuyaResponseToCyBearJinniSucessFailure(requestResponse);
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }

  @override
  Future<Either<CoreFailure, Unit>> setBrightness(String brightness) async {
    lightBrightness = GenericRgbwLightBrightness(brightness);

    try {
      final String requestResponse = await cloudTuya.setBrightness(
        vendorUniqueId.getOrCrash(),
        lightBrightness.getOrCrash(),
      );
      return tuyaResponseToCyBearJinniSucessFailure(requestResponse);
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }

  @override
  Future<Either<CoreFailure, Unit>> changeColorTemperature({
    required String lightColorTemperatureNewValue,
  }) async {
    lightColorTemperature =
        GenericRgbwLightColorTemperature(lightColorTemperatureNewValue);

    try {
      final String requestResponse = await cloudTuya.setColorTemperature(
        deviceId: vendorUniqueId.getOrCrash(),
        newTemperature: lightColorTemperatureNewValue,
      );
      return tuyaResponseToCyBearJinniSucessFailure(requestResponse);
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }

  @override
  Future<Either<CoreFailure, Unit>> changeColorHsv({
    required String lightColorAlphaNewValue,
    required String lightColorHueNewValue,
    required String lightColorSaturationNewValue,
    required String lightColorValueNewValue,
  }) async {
    lightColorAlpha = GenericRgbwLightColorAlpha(lightColorAlphaNewValue);
    lightColorHue = GenericRgbwLightColorHue(lightColorHueNewValue);
    lightColorSaturation =
        GenericRgbwLightColorSaturation(lightColorSaturationNewValue);
    lightColorValue = GenericRgbwLightColorValue(lightColorValueNewValue);

    try {
      final String requestResponse = await cloudTuya.setColorHsv(
        deviceId: vendorUniqueId.getOrCrash(),
        hue: lightColorHue.getOrCrash(),
        saturation: lightColorSaturation.getOrCrash(),
        brightness: lightBrightness.getOrCrash(),
      );
      return tuyaResponseToCyBearJinniSucessFailure(requestResponse);
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }
}
