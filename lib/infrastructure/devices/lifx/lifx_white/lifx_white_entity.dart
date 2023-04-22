import 'dart:async';

import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/device_type_enums.dart';
import 'package:cbj_hub/domain/generic_devices/generic_dimmable_light_device/generic_dimmable_light_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_dimmable_light_device/generic_dimmable_light_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/lifx/lifx_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/injection.dart';
import 'package:cbj_hub/utils.dart';
import 'package:dartz/dartz.dart';
import 'package:lifx_http_api/lifx_http_api.dart';

class LifxWhiteEntity extends GenericDimmableLightDE {
  LifxWhiteEntity({
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
  }) : super(
          deviceVendor: DeviceVendor(VendorsAndServices.lifx.toString()),
        );

  factory LifxWhiteEntity.fromGeneric(GenericDimmableLightDE genericDevice) {
    return LifxWhiteEntity(
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
    );
  }

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
          (await turnOnLight()).fold((l) {
            logger.e('Error turning Lifx light on');
            throw l;
          }, (r) {
            logger.i('Lifx light turn on success');
          });
        } else if (actionToPreform == EntityActions.off) {
          (await turnOffLight()).fold((l) {
            logger.e('Error turning Lifx light off');
            throw l;
          }, (r) {
            logger.i('Lifx light turn off success');
          });
        } else {
          logger.w('actionToPreform is not set correctly on Lifx White');
        }
      }

      if (newEntity.lightBrightness.getOrCrash() !=
          lightBrightness.getOrCrash()) {
        (await setBrightness(newEntity.lightBrightness.getOrCrash())).fold(
          (l) {
            logger.e('Error changing Lifx brightness\n$l');
            throw l;
          },
          (r) {
            logger.i('Lifx changed brightness successfully');
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
      final setStateBodyResponse =
          await getIt<LifxConnectorConjector>().lifxClient?.setState(
                Selector.id(entityUniqueId.getOrCrash()),
                power: 'on',
                fast: true,
              );
      if (setStateBodyResponse == null) {
        throw 'setStateBodyResponse is null';
      }

      return right(unit);
    } catch (e) {
      // As we are using the fast = true the response is always
      // LifxHttpException Error
      return right(unit);
      // return left(const CoreFailure.unexpected());
    }
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOffLight() async {
    lightSwitchState =
        GenericDimmableLightSwitchState(EntityActions.off.toString());

    try {
      final setStateBodyResponse =
          await getIt<LifxConnectorConjector>().lifxClient?.setState(
                Selector.id(entityUniqueId.getOrCrash()),
                power: 'off',
                fast: true,
              );
      if (setStateBodyResponse == null) {
        throw 'setStateBodyResponse is null';
      }
      return right(unit);
    } catch (e) {
      // As we are using the fast = true the response is always
      // LifxHttpException Error
      return right(unit);
      // return left(const CoreFailure.unexpected());
    }
  }

  @override
  Future<Either<CoreFailure, Unit>> setBrightness(String brightness) async {
    lightBrightness = GenericDimmableLightBrightness(brightness);

    try {
      final setStateBodyResponse =
          await getIt<LifxConnectorConjector>().lifxClient?.setState(
                Selector.id(entityUniqueId.getOrCrash()),
                fast: true,
                brightness: lightBrightness.backToDecimalPointBrightness(),
              );
      if (setStateBodyResponse == null) {
        throw 'setStateBodyResponse is null';
      }
      return right(unit);
    } catch (e) {
      // As we are using the fast = true the response is always
      // LifxHttpException Error
      return right(unit);
      // return left(const CoreFailure.unexpected());
    }
  }
}
