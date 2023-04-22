import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/device_type_enums.dart';
import 'package:cbj_hub/domain/generic_devices/generic_switch_device/generic_switch_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_switch_device/generic_switch_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/ewelink/ewelink_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/injection.dart';
import 'package:cbj_hub/utils.dart';
import 'package:dartz/dartz.dart';

class EwelinkSwitchEntity extends GenericSwitchDE {
  EwelinkSwitchEntity({
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
    required super.switchState,
  }) : super(
          deviceVendor:
              DeviceVendor(VendorsAndServices.sonoffEweLink.toString()),
        );

  factory EwelinkSwitchEntity.fromGeneric(GenericSwitchDE genericDevice) {
    return EwelinkSwitchEntity(
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
      switchState: genericDevice.switchState,
    );
  }

  @override
  Future<Either<CoreFailure, Unit>> executeDeviceAction({
    required DeviceEntityAbstract newEntity,
  }) async {
    if (newEntity is! GenericSwitchDE) {
      return left(
        const CoreFailure.actionExcecuter(
          failedValue: 'Not the correct type',
        ),
      );
    }

    try {
      if (newEntity.switchState!.getOrCrash() != switchState!.getOrCrash() ||
          entityStateGRPC.getOrCrash() != EntityStateGRPC.ack.toString()) {
        final EntityActions? actionToPreform =
            EnumHelperCbj.stringToDeviceAction(
          newEntity.switchState!.getOrCrash(),
        );

        if (actionToPreform == EntityActions.on) {
          (await turnOnSwitch()).fold((l) {
            logger.e('Error turning EweLink switch on');
            throw l;
          }, (r) {
            logger.i('EweLink switch turn on success');
          });
        } else if (actionToPreform == EntityActions.off) {
          (await turnOffSwitch()).fold((l) {
            logger.e('Error turning EweLink switch off');
            throw l;
          }, (r) {
            logger.i('EweLink switch turn off success');
          });
        } else {
          logger.e('actionToPreform is not set correctly EweLink switch');
        }
      }
      entityStateGRPC = EntityState(EntityStateGRPC.ack.toString());
      // getIt<IMqttServerRepository>().postSmartDeviceToAppMqtt(
      //   entityFromTheHub: this,
      // );
      return right(unit);
    } catch (e) {
      entityStateGRPC = EntityState(EntityStateGRPC.newStateFailed.toString());
      //
      // getIt<IMqttServerRepository>().postSmartDeviceToAppMqtt(
      //   entityFromTheHub: this,
      // );

      return left(const CoreFailure.unexpected());
    }
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOnSwitch() async {
    switchState = GenericSwitchSwitchState(EntityActions.on.toString());
    try {
      await getIt<EwelinkConnectorConjector>().ewelink?.setDevicePowerState(
            deviceId: deviceUniqueId.getOrCrash(),
            state: 'on',
            // TODO: Bug in api, channel 1 get changed no matter the input
            // https://github.com/ianmaciel/dart_ewelink_api/issues/21
            channel: entityKey.getOrCrash(),
          );
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
    return right(unit);
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOffSwitch() async {
    switchState = GenericSwitchSwitchState(EntityActions.off.toString());
    try {
      await getIt<EwelinkConnectorConjector>().ewelink?.setDevicePowerState(
            deviceId: deviceUniqueId.getOrCrash(),
            state: 'off',
            // TODO: Bug in api, channel 1 get changed no matter the input
            // https://github.com/ianmaciel/dart_ewelink_api/issues/21
            channel: entityKey.getOrCrash(),
          );
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
    return right(unit);
  }
}
