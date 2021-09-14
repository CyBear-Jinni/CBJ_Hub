import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/device_type_enums.dart';
import 'package:cbj_hub/domain/generic_devices/generic_light_device/generic_light_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_light_device/generic_light_value_objects.dart';
import 'package:cbj_hub/domain/mqtt_server/i_mqtt_server_repository.dart';
import 'package:cbj_hub/infrastructure/devices/tasmota/tasmota_device_value_objects.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/injection.dart';
import 'package:dartz/dartz.dart';
import 'package:cbj_hub/utils.dart';

class TasmotaLedEntity extends GenericLightDE {
  TasmotaLedEntity({
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
    required GenericLightSwitchState lightSwitchState,
    required this.tasmotaDeviceId,
    required this.tasmotaDeviceTopicName,
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
          deviceVendor: DeviceVendor(VendorsAndServices.tasmota.toString()),
          compUuid: compUuid,
          powerConsumption: powerConsumption,
        );

  TasmotaDeviceTopicName tasmotaDeviceTopicName;
  TasmotaDeviceId tasmotaDeviceId;

  /// Please override the following methods
  @override
  Future<Either<CoreFailure, Unit>> executeDeviceAction(
      DeviceEntityAbstract newEntity) async {
    if (newEntity is! GenericLightDE) {
      return left(const CoreFailure.actionExcecuter(
          failedValue: 'Not the correct type'));
    }

    if (newEntity.lightSwitchState!.getOrCrash() !=
        lightSwitchState!.getOrCrash()) {
      final DeviceActions? actionToPreform = EnumHelper.stringToDeviceAction(
          newEntity.lightSwitchState!.getOrCrash());

      if (actionToPreform == DeviceActions.on) {
        (await turnOnLight()).fold(
            (l) => logger.e('Error turning tasmota light on'),
            (r) => print('Light turn on success'));
      } else if (actionToPreform == DeviceActions.off) {
        (await turnOffLight()).fold(
            (l) => logger.e('Error turning tasmota light off'),
            (r) => print('Light turn off success'));
      } else {
        logger.e('actionToPreform is not set correctly on Tasmota Led');
      }
    }

    return right(unit);
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOnLight() async {
    lightSwitchState = GenericLightSwitchState(DeviceActions.on.toString());

    try {
      getIt<IMqttServerRepository>().publishMessage(
          'cmnd/${tasmotaDeviceTopicName.getOrCrash()}/Power', 'ON');
      return right(unit);
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOffLight() async {
    lightSwitchState = GenericLightSwitchState(DeviceActions.off.toString());

    try {
      getIt<IMqttServerRepository>().publishMessage(
          'cmnd/${tasmotaDeviceTopicName.getOrCrash()}/Power', 'OFF');
      return right(unit);
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }
}
