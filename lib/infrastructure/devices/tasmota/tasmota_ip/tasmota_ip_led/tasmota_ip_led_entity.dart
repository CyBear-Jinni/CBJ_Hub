import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/device_type_enums.dart';
import 'package:cbj_hub/domain/generic_devices/generic_light_device/generic_light_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_light_device/generic_light_value_objects.dart';
import 'package:cbj_hub/domain/mqtt_server/i_mqtt_server_repository.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/injection.dart';
import 'package:cbj_hub/utils.dart';
import 'package:dartz/dartz.dart';

// TODO: Make the commends work, currently this object does not work
// Toggle device on/off, the o is the number of output to toggle o=2 is the second
//    http://ip/?m=1&o=1
// Change brightness
//    http://ip/?m=1&d0=30
// Change color
//    http://ip/?m=1&h0=232
// Change tint (I think)
//    http://ip/?m=1&t0=500
// Change color strength
//    http://ip/?m=1&n0=87

class TasmotaIpLedEntity extends GenericLightDE {
  TasmotaIpLedEntity({
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
  }) : super(
          deviceVendor: DeviceVendor(VendorsAndServices.tasmota.toString()),
        );

  /// Please override the following methods
  @override
  Future<Either<CoreFailure, Unit>> executeDeviceAction({
    required DeviceEntityAbstract newEntity,
  }) async {
    if (newEntity is! GenericLightDE) {
      return left(
        const CoreFailure.actionExcecuter(
          failedValue: 'Not the correct type',
        ),
      );
    }

    try {
      if (newEntity.lightSwitchState!.getOrCrash() !=
              lightSwitchState!.getOrCrash() ||
          entityStateGRPC.getOrCrash() != DeviceStateGRPC.ack.toString()) {
        final DeviceActions? actionToPreform =
            EnumHelperCbj.stringToDeviceAction(
          newEntity.lightSwitchState!.getOrCrash(),
        );

        if (actionToPreform == DeviceActions.on) {
          (await turnOnLight()).fold(
            (l) {
              logger.e('Error turning TasmotaIp light on');
              throw l;
            },
            (r) {
              logger.i('TasmotaIp light turn on success');
            },
          );
        } else if (actionToPreform == DeviceActions.off) {
          (await turnOffLight()).fold(
            (l) {
              logger.e('Error turning TasmotaIp light off');
              throw l;
            },
            (r) {
              logger.i('TasmotaIp light turn off success');
            },
          );
        } else {
          logger.e('actionToPreform is not set correctly on TasmotaIp Led');
        }
      }
      entityStateGRPC = EntityState(DeviceStateGRPC.ack.toString());
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

  @override
  Future<Either<CoreFailure, Unit>> turnOnLight() async {
    lightSwitchState = GenericLightSwitchState(DeviceActions.on.toString());

    try {
      getIt<IMqttServerRepository>().publishMessage(
        'cmnd/${deviceHostName.getOrCrash()}/Power',
        'ON',
      );
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
        'cmnd/${deviceHostName.getOrCrash()}/Power',
        'OFF',
      );
      return right(unit);
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }
}
