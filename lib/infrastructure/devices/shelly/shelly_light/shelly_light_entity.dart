import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/device_type_enums.dart';
import 'package:cbj_hub/domain/generic_devices/generic_rgbw_light_device/generic_rgbw_light_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_rgbw_light_device/generic_rgbw_light_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/shelly/shelly_api/shelly_api_color_bulb.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/utils.dart';
import 'package:color/color.dart';
import 'package:dartz/dartz.dart';

class ShellyColorLightEntity extends GenericRgbwLightDE {
  ShellyColorLightEntity({
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
    required super.lightColorTemperature,
    required super.lightColorAlpha,
    required super.lightColorHue,
    required super.lightColorSaturation,
    required super.lightColorValue,
    required super.lightBrightness,
    ShellyApiColorBulb? bulbeMode,
  }) : super(
          deviceVendor: DeviceVendor(VendorsAndServices.shelly.toString()),
        ) {
    shellyColorBulb = bulbeMode ??
        ShellyApiColorBulb(
          lastKnownIp: deviceLastKnownIp.getOrCrash(),
          mDnsName: deviceMdns.getOrCrash(),
          hostName: deviceHostName.getOrCrash(),
        );
  }

  late ShellyApiColorBulb shellyColorBulb;

  @override
  Future<Either<CoreFailure, Unit>> executeDeviceAction({
    required DeviceEntityAbstract newEntity,
  }) async {
    if (newEntity is! GenericRgbwLightDE) {
      return left(
        const CoreFailure.actionExcecuter(
          failedValue: 'Not the correct type',
        ),
      );
    }

    try {
      // if (entityStateGRPC.getOrCrash() == DeviceStateGRPC.ack.toString()) {
      //   return right(unit);
      // }

      if (newEntity.lightSwitchState!.getOrCrash() !=
          lightSwitchState!.getOrCrash()) {
        final DeviceActions? actionToPreform =
            EnumHelperCbj.stringToDeviceAction(
          newEntity.lightSwitchState!.getOrCrash(),
        );

        if (actionToPreform == DeviceActions.on) {
          (await turnOnLight()).fold((l) {
            logger.e('Error turning Shelly light on');
            throw l;
          }, (r) {
            logger.i('Shelly light turn on success');
          });
        } else if (actionToPreform == DeviceActions.off) {
          (await turnOffLight()).fold((l) {
            logger.e('Error turning Shelly light off');
            throw l;
          }, (r) {
            logger.i('Shelly light turn off success');
          });
        } else {
          logger.e('actionToPreform is not set correctly Shelly light');
        }
      }

      if (newEntity.lightColorTemperature.getOrCrash() !=
          lightColorTemperature.getOrCrash()) {
        (await changeColorTemperature(
          lightColorTemperatureNewValue:
              newEntity.lightColorTemperature.getOrCrash(),
        ))
            .fold(
          (l) {
            logger.e('Error changing Shelly temperature\n$l');
            throw l;
          },
          (r) {
            logger.i('Shelly changed temperature successfully');
          },
        );
      }

      if (newEntity.lightColorAlpha.getOrCrash() !=
              lightColorAlpha.getOrCrash() ||
          newEntity.lightColorHue.getOrCrash() != lightColorHue.getOrCrash() ||
          newEntity.lightColorSaturation.getOrCrash() !=
              lightColorSaturation.getOrCrash() ||
          newEntity.lightColorValue.getOrCrash() !=
              lightColorValue.getOrCrash()) {
        (await changeColorHsv(
          lightColorAlphaNewValue: newEntity.lightColorAlpha.getOrCrash(),
          lightColorHueNewValue: newEntity.lightColorHue.getOrCrash(),
          lightColorSaturationNewValue:
              newEntity.lightColorSaturation.getOrCrash(),
          lightColorValueNewValue: newEntity.lightColorValue.getOrCrash(),
        ))
            .fold(
          (l) {
            logger.e('Error changing Shelly light color\n$l');
            throw l;
          },
          (r) {
            logger.i('Shelly changed color successfully');
          },
        );
      }

      if (newEntity.lightBrightness.getOrCrash() !=
          lightBrightness.getOrCrash()) {
        (await setBrightness(newEntity.lightBrightness.getOrCrash())).fold(
          (l) {
            logger.e('Error changing Shelly brightness\n$l');
            throw l;
          },
          (r) {
            logger.i('Shelly changed brightness successfully');
          },
        );
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
    lightSwitchState = GenericRgbwLightSwitchState(DeviceActions.on.toString());

    try {
      logger.v('Turn on Shelly device');
      shellyColorBulb.turnOn();
      return right(unit);
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOffLight() async {
    lightSwitchState =
        GenericRgbwLightSwitchState(DeviceActions.off.toString());

    try {
      logger.v('Turn off Shelly device');
      await shellyColorBulb.turnOff();
      return right(unit);
    } catch (exception) {
      return left(const CoreFailure.unexpected());
    }
  }

  @override
  Future<Either<CoreFailure, Unit>> changeColorTemperature({
    required String lightColorTemperatureNewValue,
  }) async {
    try {
      int temperatureInt = int.parse(lightColorTemperatureNewValue);
      if (temperatureInt < 3000) {
        temperatureInt = 3000;
      } else if (temperatureInt > 6465) {
        temperatureInt = 6465;
      }

      if (lightColorTemperature.getOrCrash() == temperatureInt.toString()) {
        return right(unit);
      }

      lightColorTemperature =
          GenericRgbwLightColorTemperature(temperatureInt.toString());

      await shellyColorBulb.changTemperature(
        temperature: lightColorTemperature.getOrCrash(),
      );

      return right(unit);
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }

  @override
  Future<Either<CoreFailure, Unit>> setBrightness(String brightness) async {
    lightBrightness = GenericRgbwLightBrightness(brightness);

    try {
      await shellyColorBulb.changBrightness(
        brightness: brightness,
      );

      return right(unit);
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }

  @override
  Future<Either<CoreFailure, Unit>> changeColorHsv({
    required String lightColorAlphaNewValue,
    required String lightColorHueNewValue,
    required String lightColorSaturationNewValue,
    required String lightColorValueNewValue,
  }) async {
    lightColorAlpha = GenericRgbwLightColorAlpha(lightColorAlphaNewValue);
    lightColorHue = GenericRgbwLightColorHue(lightColorHueNewValue);
    lightColorSaturation =
        GenericRgbwLightColorSaturation(lightColorSaturationNewValue);
    lightColorValue = GenericRgbwLightColorValue(lightColorValueNewValue);

    try {
      final HsvColor hsvColor = HsvColor(
        double.parse(lightColorHue.getOrCrash()),
        convertDecimalPresentagetToIntegerPercentage(
          double.parse(lightColorSaturation.getOrCrash()),
        ),
        convertDecimalPresentagetToIntegerPercentage(
          double.parse(lightColorValue.getOrCrash()),
        ),
      );

      final RgbColor rgbColor = hsvColor.toRgbColor();

      await shellyColorBulb.changeColor(
        red: rgbColor.r.toString(),
        green: rgbColor.g.toString(),
        blue: rgbColor.b.toString(),
      );

      return right(unit);
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }

  // Convert percentage 0-1 numbers to 0-100 with the same percentage
  int convertDecimalPresentagetToIntegerPercentage(double number) {
    if (number == 1.0) {
      return 100;
    } else if (number == 0.0) {
      return 0;
    }

    if (number.toString().length <= 8) {
      throw 'Error converting to integer percentage';
    }
    // 0.3455545372845
    final String inString = number.toStringAsFixed(6); //  0.34555
    final int numberTemp = int.parse(inString.substring(2)); //   34555

    final int percentage = (100 * numberTemp) ~/ 1000000;

    return percentage;
  }
}
