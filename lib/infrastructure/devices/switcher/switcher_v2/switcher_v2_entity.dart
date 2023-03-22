import 'dart:async';

import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/device_type_enums.dart';
import 'package:cbj_hub/domain/generic_devices/generic_boiler_device/generic_boiler_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_boiler_device/generic_boiler_value_objects.dart';
import 'package:cbj_hub/domain/mqtt_server/i_mqtt_server_repository.dart';
import 'package:cbj_hub/infrastructure/devices/switcher/switcher_api/switcher_api_object.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/injection.dart';
import 'package:cbj_hub/utils.dart';
import 'package:dartz/dartz.dart';

class SwitcherV2Entity extends GenericBoilerDE {
  SwitcherV2Entity({
    required super.uniqueId,
    required super.entityUniqueId,
    required super.cbjEntityName,
    required super.entityOriginalName,
    required super.deviceOriginalName,
    required super.entityStateGRPC,
    required super.stateMassage,
    required super.senderDeviceOs,
    required super.senderDeviceModel,
    required super.senderId,
    required super.compUuid,
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
    required super.boilerSwitchState,
  }) : super(
          deviceVendor:
              DeviceVendor(VendorsAndServices.switcherSmartHome.toString()),
        ) {
    switcherObject = SwitcherApiObject(
      deviceType: SwitcherDevicesTypes.switcherV2Esp,
      deviceId: entityUniqueId.getOrCrash(),
      switcherIp: deviceLastKnownIp.getOrCrash(),
      switcherName: cbjEntityName.getOrCrash()!,
      macAddress: devicesMacAddress.getOrCrash(),
      powerConsumption: powerConsumption.getOrCrash(),
    );
  }

  factory SwitcherV2Entity.fromGeneric(GenericBoilerDE genericDevice) {
    return SwitcherV2Entity(
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
      deviceCbjUniqueId: genericDevice.deviceCbjUniqueId,
      boilerSwitchState: genericDevice.boilerSwitchState,
    );
  }

  /// Switcher package object require to close previews request before new one
  SwitcherApiObject? switcherObject;

  String? autoShutdown;
  String? electricCurrent;
  String? lastDataUpdate;
  String? macAddress;
  String? remainingTime;

  /// Please override the following methods
  @override
  Future<Either<CoreFailure, Unit>> executeDeviceAction({
    required DeviceEntityAbstract newEntity,
  }) async {
    if (newEntity is! GenericBoilerDE) {
      return left(
        const CoreFailure.actionExcecuter(
          failedValue: 'Not the correct type',
        ),
      );
    }

    try {
      if (newEntity.entityStateGRPC.getOrCrash() !=
          DeviceStateGRPC.ack.toString()) {
        if (newEntity.boilerSwitchState!.getOrCrash() !=
            boilerSwitchState!.getOrCrash()) {
          final DeviceActions? actionToPreform =
              EnumHelperCbj.stringToDeviceAction(
            newEntity.boilerSwitchState!.getOrCrash(),
          );

          if (actionToPreform == DeviceActions.on) {
            (await turnOnBoiler()).fold(
              (l) {
                logger.e('Error turning boiler on');
                throw l;
              },
              (r) {
                logger.i('Boiler turn on success');
              },
            );
          } else if (actionToPreform == DeviceActions.off) {
            (await turnOffBoiler()).fold(
              (l) {
                logger.e('Error turning boiler off');
                throw l;
              },
              (r) {
                logger.i('Boiler turn off success');
              },
            );
          } else {
            logger.e('actionToPreform is not set correctly on Switcher V2');
          }
        }
        entityStateGRPC = EntityState(DeviceStateGRPC.ack.toString());

        getIt<IMqttServerRepository>().postSmartDeviceToAppMqtt(
          entityFromTheHub: this,
        );
      }
      return right(unit);
    } catch (e) {
      entityStateGRPC = EntityState(DeviceStateGRPC.newStateFailed.toString());

      getIt<IMqttServerRepository>().postSmartDeviceToAppMqtt(
        entityFromTheHub: this,
      );

      return left(const CoreFailure.unexpected());
    }
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOnBoiler() async {
    boilerSwitchState = GenericBoilerSwitchState(DeviceActions.on.toString());

    try {
      await switcherObject!.turnOn();
      // TODO: Add a way to get switch value to improve code and test new
      // TODO: response state from the hub
      // await switcherObject.getSocket();
      return right(unit);
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOffBoiler() async {
    boilerSwitchState = GenericBoilerSwitchState(DeviceActions.off.toString());

    try {
      await switcherObject!.turnOff();

      return right(unit);
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }
}
