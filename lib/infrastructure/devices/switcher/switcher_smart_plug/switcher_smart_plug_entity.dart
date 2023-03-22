import 'dart:async';

import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/device_type_enums.dart';
import 'package:cbj_hub/domain/generic_devices/generic_smart_plug_device/generic_smart_plug_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_smart_plug_device/generic_smart_plug_value_objects.dart';
import 'package:cbj_hub/domain/mqtt_server/i_mqtt_server_repository.dart';
import 'package:cbj_hub/infrastructure/devices/switcher/switcher_api/switcher_api_object.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/injection.dart';
import 'package:cbj_hub/utils.dart';
import 'package:dartz/dartz.dart';

class SwitcherSmartPlugEntity extends GenericSmartPlugDE {
  SwitcherSmartPlugEntity({
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
    required super.smartPlugState,
  }) : super(
          deviceVendor:
              DeviceVendor(VendorsAndServices.switcherSmartHome.toString()),
        ) {
    switcherObject = SwitcherApiObject(
      deviceType: SwitcherDevicesTypes.switcherPowerPlug,
      deviceId: entityUniqueId.getOrCrash(),
      switcherIp: deviceLastKnownIp.getOrCrash(),
      switcherName: cbjEntityName.getOrCrash()!,
      macAddress: devicesMacAddress.getOrCrash(),
      powerConsumption: powerConsumption.getOrCrash(),
    );
  }

  factory SwitcherSmartPlugEntity.fromGeneric(
      GenericSmartPlugDE genericDevice) {
    return SwitcherSmartPlugEntity(
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
      smartPlugState: genericDevice.smartPlugState,
    );
  }

  /// Switcher package object require to close previews request before new one
  SwitcherApiObject? switcherObject;

  String? autoShutdown;
  String? electricCurrent;
  String? remainingTime;

  /// Please override the following methods
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
      if (newEntity.entityStateGRPC.getOrCrash() !=
          DeviceStateGRPC.ack.toString()) {
        if (newEntity.smartPlugState!.getOrCrash() !=
            smartPlugState!.getOrCrash()) {
          final DeviceActions? actionToPreform =
              EnumHelperCbj.stringToDeviceAction(
            newEntity.smartPlugState!.getOrCrash(),
          );

          if (actionToPreform == DeviceActions.on) {
            (await turnOnSmartPlug()).fold(
              (l) {
                logger.e('Error turning smart plug on');
                throw l;
              },
              (r) {
                logger.i('Smart plug turn on success');
              },
            );
          } else if (actionToPreform == DeviceActions.off) {
            (await turnOffSmartPlug()).fold(
              (l) {
                logger.e('Error turning smart plug off');
                throw l;
              },
              (r) {
                logger.i('Smart plug turn off success');
              },
            );
          } else {
            logger.e(
              'actionToPreform is not set correctly on Switcher Smart Plug',
            );
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
  Future<Either<CoreFailure, Unit>> turnOnSmartPlug() async {
    smartPlugState = GenericSmartPlugState(DeviceActions.on.toString());

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
  Future<Either<CoreFailure, Unit>> turnOffSmartPlug() async {
    smartPlugState = GenericSmartPlugState(DeviceActions.off.toString());

    try {
      await switcherObject!.turnOff();

      return right(unit);
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }
}
