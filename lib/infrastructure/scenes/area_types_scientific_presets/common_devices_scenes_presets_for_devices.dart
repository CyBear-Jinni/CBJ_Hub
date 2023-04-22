import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/generic_blinds_device/generic_blinds_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_boiler_device/generic_boiler_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_light_device/generic_light_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_rgbw_light_device/generic_rgbw_light_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_smart_computer_device/generic_smart_computer_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_smart_plug_device/generic_smart_plug_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_smart_tv/generic_smart_tv_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_switch_device/generic_switch_entity.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/infrastructure/node_red/node_red_converter.dart';

class CommonDevicesScenesPresetsForDevices {
  /// TODO: add TypeNotSupported preset

  /// Light preset

  static MapEntry<String, String> lightOnPreset(
    DeviceEntityAbstract deviceEntity,
    String brokerNodeId,
  ) {
    final String property =
        GenericLightDE.empty().getListOfPropertiesToChange()[0];
    final String action = EntityActions.on.toString();

    return NodeRedConverter.convertToNodeString(
      device: deviceEntity,
      brokerNodeId: brokerNodeId,
      property: property,
      action: action,
    );
  }

  static MapEntry<String, String> lightOffPreset(
    DeviceEntityAbstract deviceEntity,
    String brokerNodeId,
  ) {
    final String property =
        GenericLightDE.empty().getListOfPropertiesToChange()[0];
    final String action = EntityActions.off.toString();

    return NodeRedConverter.convertToNodeString(
      device: deviceEntity,
      brokerNodeId: brokerNodeId,
      property: property,
      action: action,
    );
  }

  /// Blinds preset

  static MapEntry<String, String> blindsUpPreset(
    DeviceEntityAbstract deviceEntity,
    String brokerNodeId,
  ) {
    final String property =
        GenericBlindsDE.empty().getListOfPropertiesToChange()[0];
    final String action = EntityActions.moveUp.toString();

    return NodeRedConverter.convertToNodeString(
      device: deviceEntity,
      brokerNodeId: brokerNodeId,
      property: property,
      action: action,
    );
  }

  static MapEntry<String, String> blindsStopPreset(
    DeviceEntityAbstract deviceEntity,
    String brokerNodeId,
  ) {
    final String property =
        GenericBlindsDE.empty().getListOfPropertiesToChange()[0];
    final String action = EntityActions.stop.toString();

    return NodeRedConverter.convertToNodeString(
      device: deviceEntity,
      brokerNodeId: brokerNodeId,
      property: property,
      action: action,
    );
  }

  static MapEntry<String, String> blindsDownPreset(
    DeviceEntityAbstract deviceEntity,
    String brokerNodeId,
  ) {
    final String property =
        GenericBlindsDE.empty().getListOfPropertiesToChange()[0];
    final String action = EntityActions.moveDown.toString();

    return NodeRedConverter.convertToNodeString(
      device: deviceEntity,
      brokerNodeId: brokerNodeId,
      property: property,
      action: action,
    );
  }

  /// Boiler preset

  static MapEntry<String, String> boilerOnPreset(
    DeviceEntityAbstract deviceEntity,
    String brokerNodeId,
  ) {
    final String property =
        GenericBoilerDE.empty().getListOfPropertiesToChange()[0];
    final String action = EntityActions.on.toString();

    return NodeRedConverter.convertToNodeString(
      device: deviceEntity,
      brokerNodeId: brokerNodeId,
      property: property,
      action: action,
    );
  }

  static MapEntry<String, String> boilerOffPreset(
    DeviceEntityAbstract deviceEntity,
    String brokerNodeId,
  ) {
    final String property =
        GenericBoilerDE.empty().getListOfPropertiesToChange()[0];
    final String action = EntityActions.off.toString();

    return NodeRedConverter.convertToNodeString(
      device: deviceEntity,
      brokerNodeId: brokerNodeId,
      property: property,
      action: action,
    );
  }

  /// TODO: Add Button preset
  /// TODO: Add ButtonWithLight preset
  /// TODO: Add Hub preset
  /// TODO: Add PhoneApp preset
  /// TODO: Add ComputerApp preset
  /// TODO: Add BrowserApp preset

  /// Switch_ preset

  static MapEntry<String, String> switchOnPreset(
    DeviceEntityAbstract deviceEntity,
    String brokerNodeId,
  ) {
    final String property =
        GenericSwitchDE.empty().getListOfPropertiesToChange()[0];
    final String action = EntityActions.on.toString();

    return NodeRedConverter.convertToNodeString(
      device: deviceEntity,
      brokerNodeId: brokerNodeId,
      property: property,
      action: action,
    );
  }

  static MapEntry<String, String> switchOffPreset(
    DeviceEntityAbstract deviceEntity,
    String brokerNodeId,
  ) {
    final String property =
        GenericSwitchDE.empty().getListOfPropertiesToChange()[0];
    final String action = EntityActions.off.toString();

    return NodeRedConverter.convertToNodeString(
      device: deviceEntity,
      brokerNodeId: brokerNodeId,
      property: property,
      action: action,
    );
  }

  /// TODO: Add DimmableLight preset
  /// TODO: Add CctLight preset
  /// TODO: Add RgbLights preset

  /// RgbwLights preset
  static MapEntry<String, String> rgbwLightOnPreset(
    DeviceEntityAbstract deviceEntity,
    String brokerNodeId,
  ) {
    final String property =
        GenericRgbwLightDE.empty().getListOfPropertiesToChange()[0];
    final String action = EntityActions.on.toString();

    return NodeRedConverter.convertToNodeString(
      device: deviceEntity,
      brokerNodeId: brokerNodeId,
      property: property,
      action: action,
    );
  }

  static MapEntry<String, String> rgbwLightOffPreset(
    DeviceEntityAbstract deviceEntity,
    String brokerNodeId,
  ) {
    final String property =
        GenericRgbwLightDE.empty().getListOfPropertiesToChange()[0];
    final String action = EntityActions.off.toString();

    return NodeRedConverter.convertToNodeString(
      device: deviceEntity,
      brokerNodeId: brokerNodeId,
      property: property,
      action: action,
    );
  }

  static MapEntry<String, String> rgbLightOrangePreset(
    DeviceEntityAbstract deviceEntity,
    String brokerNodeId,
  ) {
    final String property =
        GenericRgbwLightDE.empty().getListOfPropertiesToChange()[1];
    const String action = '2500';

    return NodeRedConverter.convertToNodeString(
      device: deviceEntity,
      brokerNodeId: brokerNodeId,
      property: property,
      action: action,
    );
  }

  static MapEntry<String, String> rgbLightWhitePreset(
    DeviceEntityAbstract deviceEntity,
    String brokerNodeId,
  ) {
    final String property =
        GenericRgbwLightDE.empty().getListOfPropertiesToChange()[1];
    const String action = '5400';

    return NodeRedConverter.convertToNodeString(
      device: deviceEntity,
      brokerNodeId: brokerNodeId,
      property: property,
      action: action,
    );
  }

  static MapEntry<String, String> rgbLightBluePreset(
    DeviceEntityAbstract deviceEntity,
    String brokerNodeId,
  ) {
    final String property =
        GenericRgbwLightDE.empty().getListOfPropertiesToChange()[1];
    const String action = '8800';

    return NodeRedConverter.convertToNodeString(
      device: deviceEntity,
      brokerNodeId: brokerNodeId,
      property: property,
      action: action,
    );
  }

  static MapEntry<String, String> rgbLightMaxBrightnessPreset(
    DeviceEntityAbstract deviceEntity,
    String brokerNodeId,
  ) {
    final String property =
        GenericRgbwLightDE.empty().getListOfPropertiesToChange()[6];
    final String action = 100.toString();

    return NodeRedConverter.convertToNodeString(
      device: deviceEntity,
      brokerNodeId: brokerNodeId,
      property: property,
      action: action,
    );
  }

  /// TODO: Add RgbcctLights preset

  /// TODO: Add SmartTV preset

  static MapEntry<String, String> smartTvOffPreset(
    DeviceEntityAbstract deviceEntity,
    String brokerNodeId,
  ) {
    final String property =
        GenericSmartTvDE.empty().getListOfPropertiesToChange()[0];
    final String action = EntityActions.off.toString();

    return NodeRedConverter.convertToNodeString(
      device: deviceEntity,
      brokerNodeId: brokerNodeId,
      property: property,
      action: action,
    );
  }

  static MapEntry<String, String> smartTvOnPreset(
    DeviceEntityAbstract deviceEntity,
    String brokerNodeId,
  ) {
    final String property =
        GenericSmartTvDE.empty().getListOfPropertiesToChange()[0];
    final String action = EntityActions.on.toString();

    return NodeRedConverter.convertToNodeString(
      device: deviceEntity,
      brokerNodeId: brokerNodeId,
      property: property,
      action: action,
    );
  }

  /// TODO: Add SmartSpeakers preset
  /// TODO: Add CoffeeMachine preset
  /// TODO: Add Kettle preset
  /// TODO: Add Teapot preset
  /// TODO: Add WashingMachine preset
  /// TODO: Add Dishwasher preset
  /// TODO: Add Toaster preset
  /// TODO: Add VacuumCleaner preset
  /// TODO: Add Refrigerator preset
  /// TODO: Add Bed preset
  /// TODO: Add Oven preset
  /// TODO: Add AirConditioner preset
  /// TODO: Add SmartWatch preset
  /// TODO: Add SmartWaterBottle preset
  /// TODO: Add Microphone preset
  /// TODO: Add SecurityCamera preset
  /// TODO: Add BabyMonitor preset
  /// TODO: Add MotionSensor preset
  /// TODO: Add TemperatureSensor preset
  /// TODO: Add HumiditySensor preset
  /// TODO: Add LightSensor preset
  /// TODO: Add SoundSensor preset
  /// TODO: Add SmokeSensor preset
  /// TODO: Add SmokeDetector preset
  /// TODO: Add OxygenSensor preset

  /// SmartPlug preset

  static MapEntry<String, String> smartPlugOnPreset(
    DeviceEntityAbstract deviceEntity,
    String brokerNodeId,
  ) {
    final String property =
        GenericSmartPlugDE.empty().getListOfPropertiesToChange()[0];
    final String action = EntityActions.on.toString();

    return NodeRedConverter.convertToNodeString(
      device: deviceEntity,
      brokerNodeId: brokerNodeId,
      property: property,
      action: action,
    );
  }

  static MapEntry<String, String> smartPlugOffPreset(
    DeviceEntityAbstract deviceEntity,
    String brokerNodeId,
  ) {
    final String property =
        GenericSmartPlugDE.empty().getListOfPropertiesToChange()[0];
    final String action = EntityActions.off.toString();

    return NodeRedConverter.convertToNodeString(
      device: deviceEntity,
      brokerNodeId: brokerNodeId,
      property: property,
      action: action,
    );
  }

  static MapEntry<String, String> smartComputerSuspend(
    DeviceEntityAbstract deviceEntity,
    String brokerNodeId,
  ) {
    final String property =
        GenericSmartComputerDE.empty().getListOfPropertiesToChange()[0];
    final String action = EntityActions.suspend.toString();

    return NodeRedConverter.convertToNodeString(
      device: deviceEntity,
      brokerNodeId: brokerNodeId,
      property: property,
      action: action,
    );
  }

  /// TODO: Add Printer preset
  /// TODO: Add Scanner preset
  /// TODO: Add Printer with scanner preset
}
