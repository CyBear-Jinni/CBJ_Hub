import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/device_type_enums.dart';
import 'package:cbj_hub/domain/generic_devices/generic_light_device/generic_light_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_light_device/generic_light_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/esphome/esphome_api/esphome_api.dart';
import 'package:cbj_hub/infrastructure/devices/esphome/esphome_device_value_objects.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:dartz/dartz.dart';
import 'package:cbj_hub/utils.dart';

class ESPHomeLightEntity extends GenericLightDE {
  ESPHomeLightEntity({
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
    required this.espHomeSwitchKey,
    required this.deviceMdnsName,
    this.lastKnownIp,
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
          deviceVendor: DeviceVendor(VendorsAndServices.espHome.toString()),
          compUuid: compUuid,
          powerConsumption: powerConsumption,
        );

  ESPHomeSwitchKey espHomeSwitchKey;

  DeviceLastKnownIp? lastKnownIp;

  DeviceMdnsName deviceMdnsName;

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
            (l) => logger.e('Error turning ESPHome light on'),
            (r) => print('Light turn on success'));
      } else if (actionToPreform == DeviceActions.off) {
        (await turnOffLight()).fold(
            (l) => logger.e('Error turning ESPHome light off'),
            (r) => print('Light turn off success'));
      } else {
        logger.e('actionToPreform is not set correctly ESPHome light');
      }
    }

    return right(unit);
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOnLight() async {
    lightSwitchState = GenericLightSwitchState(DeviceActions.on.toString());

    try {
      print('Turn on ESPHome device');
      EspHomeApi espHomeApi;
      try {
        espHomeApi = EspHomeApi.createWithAddress(deviceMdnsName.getOrCrash());
        //
        // EspHomeApi.listenToResponses();
        await espHomeApi.helloRequestToEsp();
      } catch (mDnsCannotBeFound) {
        espHomeApi = EspHomeApi.createWithAddress(lastKnownIp!.getOrCrash());
        //
        // EspHomeApi.listenToResponses();
        await espHomeApi.helloRequestToEsp();
      }
      await espHomeApi.sendConnect('MyPassword');
      // await EspHomeApi.deviceInfoRequestToEsp();
      // await EspHomeApi.listEntitiesRequest();
      // await EspHomeApi.subscribeStatesRequest();
      await espHomeApi.switchCommandRequest(
          int.parse(espHomeSwitchKey.getOrCrash()), true);
      await espHomeApi.disconnect();
      return right(unit);
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOffLight() async {
    lightSwitchState = GenericLightSwitchState(DeviceActions.off.toString());

    try {
      try {
        print('Turn off ESPHome device');
        EspHomeApi espHomeApi;
        try {
          espHomeApi =
              EspHomeApi.createWithAddress(deviceMdnsName.getOrCrash());
          //
          // EspHomeApi.listenToResponses();
          await espHomeApi.helloRequestToEsp();
        } catch (mDnsCannotBeFound) {
          espHomeApi = EspHomeApi.createWithAddress(lastKnownIp!.getOrCrash());
          //
          // EspHomeApi.listenToResponses();
          await espHomeApi.helloRequestToEsp();
        }
        await espHomeApi.sendConnect('MyPassword');
        // await EspHomeApi.deviceInfoRequestToEsp();
        // await EspHomeApi.listEntitiesRequest();
        // await EspHomeApi.subscribeStatesRequest();
        await espHomeApi.switchCommandRequest(
            int.parse(espHomeSwitchKey.getOrCrash()), false);
        await espHomeApi.disconnect();
        return right(unit);
      } catch (exception) {
        return left(const CoreFailure.unexpected());
      }
      return right(unit);
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }
}
