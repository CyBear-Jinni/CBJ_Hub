import 'dart:async';
import 'dart:io';

import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/device_type_enums.dart';
import 'package:cbj_hub/domain/generic_devices/generic_rgbw_light_device/generic_rgbw_light_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_rgbw_light_device/generic_rgbw_light_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/yeelight/yeelight_device_value_objects.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:yeedart/yeedart.dart';
import 'package:cbj_hub/utils.dart';

class Yeelight1SeEntity extends GenericRgbwLightDE {
  Yeelight1SeEntity({
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
    required GenericRgbwLightSwitchState lightSwitchState,
    required GenericRgbwLightColorTemperature lightColorTemperature,
    required GenericRgbwLightBrightness lightBrightness,
    required GenericRgbwLightColorAlpha lightColorAlpha,
    required GenericRgbwLightColorHue lightColorHue,
    required GenericRgbwLightColorSaturation lightColorSaturation,
    required GenericRgbwLightColorValue lightColorValue,
    required this.yeelightDeviceId,
    required this.yeelightPort,
    this.deviceMdnsName,
    this.lastKnownIp,
  }) : super(
          uniqueId: uniqueId,
          defaultName: defaultName,
          roomId: roomId,
          lightSwitchState: lightSwitchState,
          roomName: roomName,
          deviceStateGRPC: deviceStateGRPC,
          stateMassage: stateMassage,
          senderDeviceOs: senderDeviceOs,
          senderDeviceModel: senderDeviceModel,
          senderId: senderId,
          deviceVendor: DeviceVendor(VendorsAndServices.yeelight.toString()),
          compUuid: compUuid,
          powerConsumption: powerConsumption,
          lightColorTemperature: lightColorTemperature,
          lightBrightness: lightBrightness,
          lightColorAlpha: lightColorAlpha,
          lightColorHue: lightColorHue,
          lightColorSaturation: lightColorSaturation,
          lightColorValue: lightColorValue,
        );

  /// Yeelight device unique id that came withe the device
  YeelightDeviceId? yeelightDeviceId;

  /// Yeelight communication port
  YeelightPort? yeelightPort;

  DeviceLastKnownIp? lastKnownIp;

  DeviceMdnsName? deviceMdnsName;

  /// Yeelight package object require to close previews request before new one
  Device? yeelightPackageObject;

  /// Please override the following methods
  @override
  Future<Either<CoreFailure, Unit>> executeDeviceAction(
    DeviceEntityAbstract newEntity,
  ) async {
    if (newEntity is! GenericRgbwLightDE) {
      return left(
        const CoreFailure.actionExcecuter(
          failedValue: 'Not the correct type',
        ),
      );
    }

    if (newEntity.lightSwitchState!.getOrCrash() !=
        lightSwitchState!.getOrCrash()) {
      final DeviceActions? actionToPreform = EnumHelper.stringToDeviceAction(
        newEntity.lightSwitchState!.getOrCrash(),
      );

      if (actionToPreform.toString() != lightSwitchState!.getOrCrash()) {
        if (actionToPreform == DeviceActions.on) {
          (await turnOnLight()).fold(
            (l) => logger.e('Error turning yeelight light on'),
            (r) => print('Light turn on success'),
          );
        } else if (actionToPreform == DeviceActions.off) {
          (await turnOffLight()).fold(
            (l) => logger.e('Error turning yeelight light off'),
            (r) => print('Light turn off success'),
          );
        } else {
          logger.e('actionToPreform is not set correctly on Yeelight 1SE');
        }
      }
    }

    if (newEntity.lightColorAlpha.getOrCrash() !=
            lightColorAlpha.getOrCrash() ||
        newEntity.lightColorHue.getOrCrash() != lightColorHue.getOrCrash() ||
        newEntity.lightColorSaturation.getOrCrash() !=
            lightColorSaturation.getOrCrash() ||
        newEntity.lightColorValue.getOrCrash() !=
            lightColorValue.getOrCrash()) {
      (await changeColorTemperature(
        lightColorAlphaNewValue: newEntity.lightColorAlpha.getOrCrash(),
        lightColorHueNewValue: newEntity.lightColorHue.getOrCrash(),
        lightColorSaturationNewValue:
            newEntity.lightColorSaturation.getOrCrash(),
        lightColorValueNewValue: newEntity.lightColorValue.getOrCrash(),
      ))
          .fold(
        (l) => logger.e('Error changing yeelight light color'),
        (r) => print('Light changed color successfully'),
      );
    }

    return right(unit);
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOnLight() async {
    lightSwitchState = GenericRgbwLightSwitchState(DeviceActions.on.toString());
    try {
      try {
        yeelightPackageObject?.disconnect();

        yeelightPackageObject = Device(
          address: InternetAddress(lastKnownIp!.getOrCrash()),
          port: int.parse(yeelightPort!.getOrCrash()),
        );

        await yeelightPackageObject!.turnOn();
        yeelightPackageObject!.disconnect();

        return right(unit);
      } catch (e) {
        await Future.delayed(const Duration(milliseconds: 150));

        final responses = await Yeelight.discover();

        final response = responses.firstWhereOrNull(
          (element) => element.id.toString() == yeelightDeviceId!.getOrCrash(),
        );
        if (response == null) {
          print('Device cant be discovered');
          return left(const CoreFailure.unexpected());
        }
        yeelightPackageObject?.disconnect();

        yeelightPackageObject =
            Device(address: response.address, port: response.port!);
        lastKnownIp = DeviceLastKnownIp(response.address.address);
        yeelightPort = YeelightPort(response.port!.toString());

        await yeelightPackageObject!.turnOn();
        yeelightPackageObject!.disconnect();

        return right(unit);
      }
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOffLight() async {
    lightSwitchState =
        GenericRgbwLightSwitchState(DeviceActions.off.toString());

    try {
      try {
        yeelightPackageObject?.disconnect();

        yeelightPackageObject = Device(
          address: InternetAddress(lastKnownIp!.getOrCrash()),
          port: int.parse(yeelightPort!.getOrCrash()),
        );

        await yeelightPackageObject!.turnOff();
        yeelightPackageObject!.disconnect();

        return right(unit);
      } catch (e) {
        await Future.delayed(const Duration(milliseconds: 150));
        final responses = await Yeelight.discover();

        final response = responses.firstWhereOrNull(
          (element) => element.id.toString() == yeelightDeviceId!.getOrCrash(),
        );
        if (response == null) {
          print('Device cant be discovered');

          return left(const CoreFailure.unexpected());
        }

        yeelightPackageObject?.disconnect();

        yeelightPackageObject =
            Device(address: response.address, port: response.port!);

        lastKnownIp = DeviceLastKnownIp(response.address.address);
        yeelightPort = YeelightPort(response.port!.toString());

        await yeelightPackageObject!.turnOff();
        yeelightPackageObject!.disconnect();

        return right(unit);
      }
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }

  /// Please override the following methods
  Future<Either<CoreFailure, Unit>> adjustBrightness(String brightness) async {
    // lightBrightness = GenericRgbwLightBrightness();

    try {
      try {
        yeelightPackageObject?.disconnect();

        yeelightPackageObject = Device(
          address: InternetAddress(lastKnownIp!.getOrCrash()),
          port: int.parse(yeelightPort!.getOrCrash()),
        );

        await yeelightPackageObject!.adjustBrightness(
          percentage: int.parse(lightBrightness.getOrCrash()),
          duration: const Duration(seconds: 50),
        );

        yeelightPackageObject!.disconnect();

        return right(unit);
      } catch (e) {
        yeelightPackageObject?.disconnect();

        await Future.delayed(const Duration(milliseconds: 150));

        final responses = await Yeelight.discover();

        final response = responses.firstWhereOrNull(
          (element) => element.id.toString() == yeelightDeviceId!.getOrCrash(),
        );
        if (response == null) {
          print('Device cant be discovered');
          return left(const CoreFailure.unexpected());
        }

        yeelightPackageObject =
            Device(address: response.address, port: response.port!);
        lastKnownIp = DeviceLastKnownIp(response.address.address);
        yeelightPort = YeelightPort(response.port!.toString());

        yeelightPackageObject!.adjustBrightness(
          percentage: int.parse(lightBrightness.getOrCrash()),
          duration: const Duration(seconds: 50),
        );

        yeelightPackageObject?.disconnect();

        return right(unit);
      }
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }

  @override
  Future<Either<CoreFailure, Unit>> changeColorTemperature({
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
      try {
        yeelightPackageObject?.disconnect();

        yeelightPackageObject = Device(
          address: InternetAddress(lastKnownIp!.getOrCrash()),
          port: int.parse(yeelightPort!.getOrCrash()),
        );

        // await device.setColorTemperature(
        //   colorTemperature: int.parse(
        //     lightColorTemperature!.getOrCrash(),
        //   ),
        // );
        await yeelightPackageObject!.setHSV(
          hue: double.parse(lightColorHueNewValue).toInt(),
          saturation: int.parse(
            lightColorSaturationNewValue.substring(2, 4),
          ),
        );
        yeelightPackageObject!.disconnect();

        return right(unit);
      } catch (e) {
        yeelightPackageObject?.disconnect();

        await Future.delayed(const Duration(milliseconds: 150));

        final responses = await Yeelight.discover();

        final response = responses.firstWhereOrNull(
          (element) => element.id.toString() == yeelightDeviceId!.getOrCrash(),
        );
        if (response == null) {
          print('Device cant be discovered');
          return left(const CoreFailure.unexpected());
        }

        yeelightPackageObject =
            Device(address: response.address, port: response.port!);
        lastKnownIp = DeviceLastKnownIp(response.address.address);
        yeelightPort = YeelightPort(response.port!.toString());

        // await device.setColorTemperature(
        //   colorTemperature: int.parse(
        //     lightColorTemperature!.getOrCrash(),
        //   ),
        // );

        await yeelightPackageObject!.setHSV(
          hue: int.parse(lightColorHueNewValue),
          saturation: int.parse(lightColorSaturationNewValue),
        );

        yeelightPackageObject?.disconnect();

        return right(unit);
      }
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }
}
