import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/device_type_enums.dart';
import 'package:cbj_hub/domain/generic_devices/generic_switch_device/generic_switch_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_switch_device/generic_switch_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/esphome/esphome_python_api/esphome_python_api.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/utils.dart';
import 'package:dartz/dartz.dart';

class EspHomeSwitchEntity extends GenericSwitchDE {
  EspHomeSwitchEntity({
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
    required super.switchState,
    required this.deviceMdnsName,
    required this.devicePort,
    required this.espHomeKey,
    this.lastKnownIp,
  }) : super(
          deviceVendor: DeviceVendor(VendorsAndServices.espHome.toString()),
        );

  DeviceLastKnownIp? lastKnownIp;

  DeviceMdnsName deviceMdnsName;

  DevicePort devicePort;

  EspHomeKey espHomeKey;

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
          deviceStateGRPC.getOrCrash() != DeviceStateGRPC.ack.toString()) {
        final DeviceActions? actionToPreform =
            EnumHelperCbj.stringToDeviceAction(
          newEntity.switchState!.getOrCrash(),
        );

        if (actionToPreform == DeviceActions.on) {
          (await turnOnSwitch()).fold((l) {
            logger.e('Error turning ESPHome switch on');
            throw l;
          }, (r) {
            logger.i('ESPHome switch turn on success');
          });
        } else if (actionToPreform == DeviceActions.off) {
          (await turnOffSwitch()).fold((l) {
            logger.e('Error turning ESPHome switch off');
            throw l;
          }, (r) {
            logger.i('ESPHome switch turn off success');
          });
        } else {
          logger.e('actionToPreform is not set correctly ESPHome switch');
        }
      }
      deviceStateGRPC = DeviceState(DeviceStateGRPC.ack.toString());
      return right(unit);
    } catch (e) {
      deviceStateGRPC = DeviceState(DeviceStateGRPC.newStateFailed.toString());
      return left(const CoreFailure.unexpected());
    }
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOnSwitch() async {
    switchState = GenericSwitchSwitchState(DeviceActions.on.toString());

    try {
      await EspHomePythonApi.turnOnOffDevice(
        address: lastKnownIp!.getOrCrash(),
        port: devicePort.getOrCrash(),
        deviceKey: espHomeKey.getOrCrash(),
        newState: 'True',
      );
      logger.v('Turn on ESPHome device');
      return right(unit);
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOffSwitch() async {
    switchState = GenericSwitchSwitchState(DeviceActions.off.toString());

    try {
      logger.v('Turn off ESPHome device');
      await EspHomePythonApi.turnOnOffDevice(
        address: lastKnownIp!.getOrCrash(),
        port: devicePort.getOrCrash(),
        deviceKey: espHomeKey.getOrCrash(),
        newState: 'False',
      );
      return right(unit);
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }
}
