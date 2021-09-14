import 'dart:async';

import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/device_type_enums.dart';
import 'package:cbj_hub/domain/generic_devices/generic_rgbw_light_device/generic_rgbw_light_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_rgbw_light_device/generic_rgbw_light_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/philips_hue/philips_hue_device_value_objects.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:dartz/dartz.dart';
import 'package:yeedart/yeedart.dart';
import 'package:cbj_hub/utils.dart';

class PhilipsHueE26Entity extends GenericRgbwLightDE {
  PhilipsHueE26Entity({
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
    required GenericRgbwLightColorAlpha lightColorAlpha,
    required GenericRgbwLightColorHue lightColorHue,
    required GenericRgbwLightColorSaturation lightColorSaturation,
    required GenericRgbwLightColorValue lightColorValue,
    required this.philips_hueDeviceId,
    required this.philips_huePort,
    this.deviceMdnsName,
    this.lastKnownIp,
    required GenericRgbwLightColorTemperature lightColorTemperature,
    required GenericRgbwLightBrightness lightBrightness,
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
          // TODO: change when implementing philips hue
          deviceVendor: DeviceVendor(
              VendorsAndServices.vendorsAndServicesNotSupported.toString()),
          compUuid: compUuid,
          powerConsumption: powerConsumption,
          lightColorTemperature: lightColorTemperature,
          lightBrightness: lightBrightness,
          lightColorAlpha: lightColorAlpha,
          lightColorHue: lightColorHue,
          lightColorSaturation: lightColorSaturation,
          lightColorValue: lightColorValue,
        );

  /// PhilipsHue device unique id that came withe the device
  PhilipsHueDeviceId? philips_hueDeviceId;

  /// PhilipsHue communication port
  PhilipsHuePort? philips_huePort;

  DeviceLastKnownIp? lastKnownIp;

  DeviceMdnsName? deviceMdnsName;

  /// PhilipsHue package object require to close previews request before new one
  Device? philips_huePackageObject;

  /// Please override the following methods
  @override
  Future<Either<CoreFailure, Unit>> executeDeviceAction(
      DeviceEntityAbstract newEntity) async {
    if (newEntity is! GenericRgbwLightDE) {
      return left(const CoreFailure.actionExcecuter(
          failedValue: 'Not the correct type'));
    }

    if (newEntity.lightSwitchState!.getOrCrash() !=
        lightSwitchState!.getOrCrash()) {
      final DeviceActions? actionToPreform = EnumHelper.stringToDeviceAction(
          newEntity.lightSwitchState!.getOrCrash());

      if (actionToPreform.toString() != lightSwitchState!.getOrCrash()) {
        if (actionToPreform == DeviceActions.on) {
          (await turnOnLight()).fold(
              (l) => logger.e('Error turning philips_hue light on'),
              (r) => print('Light turn on success'));
        } else if (actionToPreform == DeviceActions.off) {
          (await turnOffLight()).fold(
              (l) => logger.e('Error turning philips_hue light off'),
              (r) => print('Light turn off success'));
        } else {
          logger.e('actionToPreform is not set correctly on PhilipsHue E26');
        }
      }
    }

    return right(unit);
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOnLight() async {
    lightSwitchState = GenericRgbwLightSwitchState(DeviceActions.on.toString());
    try {
      return left(const CoreFailure.unexpected());
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOffLight() async {
    lightSwitchState =
        GenericRgbwLightSwitchState(DeviceActions.off.toString());
    try {
      return left(const CoreFailure.unexpected());
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }

  @override
  Future<Either<CoreFailure, Unit>> adjustBrightness(String brightness) async {
    print('Please override this method in the non generic implementation');
    return left(
      const CoreFailure.actionExcecuter(
        failedValue: 'Action does not exist',
      ),
    );
  }

  @override
  Future<Either<CoreFailure, Unit>> changeColorTemperature({
    required String lightColorAlphaNewValue,
    required String lightColorHueNewValue,
    required String lightColorSaturationNewValue,
    required String lightColorValueNewValue,
  }) async {
    print('Please override this method in the non generic implementation');
    return left(
      const CoreFailure.actionExcecuter(
        failedValue: 'Action does not exist',
      ),
    );
  }
}
