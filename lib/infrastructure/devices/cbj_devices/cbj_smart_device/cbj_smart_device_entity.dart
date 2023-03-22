import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/device_type_enums.dart';
import 'package:cbj_hub/domain/generic_devices/generic_smart_computer_device/generic_smart_computer_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_smart_computer_device/generic_smart_computer_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/cbj_devices/cbj_smart_device_client/cbj_smart_device_client.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/utils.dart';
import 'package:dartz/dartz.dart';

class CbjSmartComputerEntity extends GenericSmartComputerDE {
  CbjSmartComputerEntity({
    required super.uniqueId,
    required super.entityUniqueId,
    required super.deviceVendor,
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
    required super.smartComputerShutDownState,
    required super.smartComputerSuspendState,
    required this.lastKnownIp,
  });

  DeviceLastKnownIp lastKnownIp;

  @override
  Future<Either<CoreFailure, Unit>> executeDeviceAction({
    required DeviceEntityAbstract newEntity,
  }) async {
    if (newEntity is! GenericSmartComputerDE) {
      return left(
        const CoreFailure.actionExcecuter(
          failedValue: 'Not the correct type',
        ),
      );
    }

    try {
      if (newEntity.smartComputerSuspendState!.getOrCrash() !=
          smartComputerSuspendState!.getOrCrash()) {
        final DeviceActions? actionToPreform =
            EnumHelperCbj.stringToDeviceAction(
          newEntity.smartComputerSuspendState!.getOrCrash(),
        );

        if (actionToPreform == DeviceActions.suspend) {
          (await suspendSmartComputer()).fold((l) {
            logger.e('Error suspending Cbj Computer');
            throw l;
          }, (r) {
            logger.i('Cbj Computer suspended success');
          });
        } else {
          logger.e('actionToPreform is not set correctly Cbj Computer');
        }
      }

      if (newEntity.smartComputerShutDownState!.getOrCrash() !=
          smartComputerShutDownState!.getOrCrash()) {
        final DeviceActions? actionToPreform =
            EnumHelperCbj.stringToDeviceAction(
          newEntity.smartComputerShutDownState!.getOrCrash(),
        );
        if (actionToPreform == DeviceActions.shutdown) {
          (await shutDownSmartComputer()).fold((l) {
            logger.e('Error shutdown Cbj Computer');
            throw l;
          }, (r) {
            logger.i('Cbj Computer shutdown success');
          });
        } else {
          logger.e('actionToPreform is not set correctly Cbj Computer');
        }
      }

      smartComputerSuspendState =
          GenericSmartComputerSuspendState(DeviceActions.itIsFalse.toString());
      smartComputerShutDownState =
          GenericSmartComputerShutdownState(DeviceActions.itIsFalse.toString());

      // entityStateGRPC = EntityState(DeviceStateGRPC.ack.toString());
      //
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

  /// Please override the following methods
  @override
  Future<Either<CoreFailure, Unit>> suspendSmartComputer() async {
    smartComputerSuspendState =
        GenericSmartComputerSuspendState(DeviceActions.itIsFalse.toString());

    await CbjSmartDeviceClient.suspendCbjSmartDeviceHostDevice(
      lastKnownIp.getOrCrash(),
      entityUniqueId.getOrCrash(),
    );

    return left(
      const CoreFailure.actionExcecuter(
        failedValue: 'Action does not exist',
      ),
    );
  }

  /// Please override the following methods
  @override
  Future<Either<CoreFailure, Unit>> shutDownSmartComputer() async {
    smartComputerShutDownState =
        GenericSmartComputerShutdownState(DeviceActions.itIsFalse.toString());

    await CbjSmartDeviceClient.shutDownCbjSmartDeviceHostDevice(
      lastKnownIp.getOrCrash(),
      entityUniqueId.getOrCrash(),
    );

    return left(
      const CoreFailure.actionExcecuter(
        failedValue: 'Action does not exist',
      ),
    );
  }
}
