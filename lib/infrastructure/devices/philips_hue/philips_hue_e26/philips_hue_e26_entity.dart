import 'dart:async';

import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/device_type_enums.dart';
import 'package:cbj_hub/domain/generic_devices/generic_dimmable_light_device/generic_dimmable_light_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_dimmable_light_device/generic_dimmable_light_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/philips_hue/philips_hue_api/philips_hue_api_light.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/utils.dart';
import 'package:dartz/dartz.dart';
import 'package:yeedart/yeedart.dart';

class PhilipsHueE26Entity extends GenericDimmableLightDE {
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

  factory PhilipsHueE26Entity.fromGeneric(
    GenericDimmableLightDE genericDevice,
  ) {
    return PhilipsHueE26Entity(
      uniqueId: genericDevice.uniqueId,
      entityUniqueId: genericDevice.entityUniqueId,
      cbjEntityName: genericDevice.cbjEntityName,
      entityOriginalName: genericDevice.entityOriginalName,
      deviceOriginalName: genericDevice.deviceOriginalName,
      stateMassage: genericDevice.stateMassage,
      senderDeviceOs: genericDevice.senderDeviceOs,
      senderDeviceModel: genericDevice.senderDeviceModel,
      senderId: genericDevice.senderId,
      compUuid: genericDevice.compUuid,
      entityStateGRPC: genericDevice.entityStateGRPC,
      powerConsumption: genericDevice.powerConsumption,
      deviceUniqueId: genericDevice.deviceUniqueId,
      devicePort: genericDevice.devicePort,
      deviceLastKnownIp: genericDevice.deviceLastKnownIp,
      deviceHostName: genericDevice.deviceHostName,
      deviceMdns: genericDevice.deviceMdns,
      devicesMacAddress: genericDevice.devicesMacAddress,
      entityKey: genericDevice.entityKey,
      requestTimeStamp: genericDevice.requestTimeStamp,
      lastResponseFromDeviceTimeStamp:
          genericDevice.lastResponseFromDeviceTimeStamp,
      lightSwitchState: genericDevice.lightSwitchState,
      deviceCbjUniqueId: genericDevice.deviceCbjUniqueId,
      lightBrightness: genericDevice.lightBrightness,

      /// TODO: Save and pull philips hub generated user name
      /// (created in phillips_hue_helpers.dart)
      philipsHueApiLight: PhilipsHueApiLight(
        ipAdress: genericDevice.deviceLastKnownIp.getOrCrash(),
        username: '',
      ),
    );
  }

  /// PhilipsHue package object require to close previews request before new one
  Device? philipsHuePackageObject;

  PhilipsHueApiLight philipsHueApiLight;

  /// Please override the following methods
  @override
  Future<Either<CoreFailure, Unit>> executeDeviceAction({
    required DeviceEntityAbstract newEntity,
  }) async {
    if (newEntity is! GenericDimmableLightDE) {
      return left(
        const CoreFailure.actionExcecuter(
          failedValue: 'Not the correct type',
        ),
      );
    }

    try {
      if (newEntity.lightSwitchState!.getOrCrash() !=
              lightSwitchState!.getOrCrash() ||
          entityStateGRPC.getOrCrash() != EntityStateGRPC.ack.toString()) {
        final EntityActions? actionToPreform =
            EnumHelperCbj.stringToDeviceAction(
          newEntity.lightSwitchState!.getOrCrash(),
        );

        if (actionToPreform == EntityActions.on) {
          (await turnOnLight()).fold(
            (l) {
              logger.e('Error turning philips_hue light on');
              throw l;
            },
            (r) {
              logger.i('Philips Hue light turn on success');
            },
          );
        } else if (actionToPreform == EntityActions.off) {
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

      if (newEntity.lightBrightness.getOrCrash() !=
          lightBrightness.getOrCrash()) {
        (await setBrightness(newEntity.lightBrightness.getOrCrash())).fold(
          (l) {
            logger.e('Error changing Phillips hue e26 brightness\n$l');
            throw l;
          },
          (r) {
            logger.i('Phillips hue e26 changed brightness successfully');
          },
        );
      }
      entityStateGRPC = EntityState(EntityStateGRPC.ack.toString());

      // getIt<IMqttServerRepository>().postSmartDeviceToAppMqtt(
      //   entityFromTheHub: this,
      // );
      return right(unit);
    } catch (e) {
      entityStateGRPC = EntityState(EntityStateGRPC.newStateFailed.toString());
      // getIt<IMqttServerRepository>().postSmartDeviceToAppMqtt(
      //   entityFromTheHub: this,
      // );
      return left(const CoreFailure.unexpected());
    }
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOnLight() async {
    lightSwitchState =
        GenericDimmableLightSwitchState(EntityActions.on.toString());

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
        GenericDimmableLightSwitchState(EntityActions.off.toString());

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

    lightBrightness = GenericDimmableLightBrightness(brightnessInt.toString());

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
