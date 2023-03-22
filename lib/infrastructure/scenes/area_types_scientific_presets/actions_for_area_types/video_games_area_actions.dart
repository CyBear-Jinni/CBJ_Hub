import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/scene/scene_cbj_failures.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/infrastructure/scenes/area_types_scientific_presets/common_devices_scenes_presets_for_devices.dart';
import 'package:dartz/dartz.dart';

class VideoGamesAreaAction {
  Future<Either<SceneCbjFailure, Map<String, String>>>
      videoGamesRgbModDeviceAction(
    DeviceEntityAbstract deviceEntity,
    String brokerNodeId,
  ) async {
    final DeviceTypes deviceType = DeviceTypes.values.firstWhere(
      (element) => element.name == deviceEntity.entityTypes.getOrCrash(),
    );

    final Map<String, String> actionsList = <String, String>{};

    switch (deviceType) {
      case DeviceTypes.AirConditioner:
        // TODO: Handle this case.
        break;
      case DeviceTypes.babyMonitor:
        // TODO: Handle this case.
        break;
      case DeviceTypes.bed:
        // TODO: Handle this case.
        break;
      case DeviceTypes.blinds:
        actionsList.addEntries([
          CommonDevicesScenesPresetsForDevices.blindsUpPreset(
            deviceEntity,
            brokerNodeId,
          ),
        ]);
        break;
      case DeviceTypes.boiler:
        break;
      case DeviceTypes.browserApp:
        // TODO: Handle this case.
        break;
      case DeviceTypes.button:
        // TODO: Handle this case.
        break;
      case DeviceTypes.buttonWithLight:
        // TODO: Handle this case.
        break;
      case DeviceTypes.cctLight:
        // TODO: Handle this case.
        break;
      case DeviceTypes.coffeeMachine:
        // TODO: Handle this case.
        break;
      case DeviceTypes.computerApp:
        // TODO: Handle this case.
        break;
      case DeviceTypes.dimmableLight:
        // TODO: Handle this case.
        break;
      case DeviceTypes.dishwasher:
        // TODO: Handle this case.
        break;
      case DeviceTypes.hub:
        // TODO: Handle this case.
        break;
      case DeviceTypes.humiditySensor:
        // TODO: Handle this case.
        break;
      case DeviceTypes.kettle:
        // TODO: Handle this case.
        break;
      case DeviceTypes.light:
        actionsList.addEntries([
          CommonDevicesScenesPresetsForDevices.lightOnPreset(
            deviceEntity,
            brokerNodeId,
          ),
        ]);
        break;
      case DeviceTypes.lightSensor:
        // TODO: Handle this case.
        break;
      case DeviceTypes.microphone:
        // TODO: Handle this case.
        break;
      case DeviceTypes.motionSensor:
        // TODO: Handle this case.
        break;
      case DeviceTypes.oven:
        // TODO: Handle this case.
        break;
      case DeviceTypes.oxygenSensor:
        // TODO: Handle this case.
        break;
      case DeviceTypes.phoneApp:
        // TODO: Handle this case.
        break;
      case DeviceTypes.printer:
        // TODO: Handle this case.
        break;
      case DeviceTypes.printerWithScanner:
        // TODO: Handle this case.
        break;
      case DeviceTypes.refrigerator:
        // TODO: Handle this case.
        break;
      case DeviceTypes.rgbLights:
        // TODO: Handle this case.
        break;
      case DeviceTypes.rgbcctLights:
        // TODO: Handle this case.
        break;
      case DeviceTypes.rgbwLights:
        actionsList.addEntries([
          CommonDevicesScenesPresetsForDevices.rgbLightOrangePreset(
            deviceEntity,
            brokerNodeId,
          ),
        ]);
        actionsList.addEntries([
          CommonDevicesScenesPresetsForDevices.rgbLightMaxBrightnessPreset(
            deviceEntity,
            brokerNodeId,
          ),
        ]);
        actionsList.addEntries([
          CommonDevicesScenesPresetsForDevices.rgbwLightOnPreset(
            deviceEntity,
            brokerNodeId,
          ),
        ]);
        // TODO: add light color changing in cycles
        break;
      case DeviceTypes.scanner:
        // TODO: Handle this case.
        break;
      case DeviceTypes.securityCamera:
        // TODO: Handle this case.
        break;
      case DeviceTypes.smartPlug:
        break;
      case DeviceTypes.smartSpeakers:
        // TODO: Handle this case.
        break;
      case DeviceTypes.smartTV:
        actionsList.addEntries([
          CommonDevicesScenesPresetsForDevices.smartTvOffPreset(
            deviceEntity,
            brokerNodeId,
          ),
        ]);
        break;
      case DeviceTypes.smartWatch:
        // TODO: Handle this case.
        break;
      case DeviceTypes.smartWaterBottle:
        // TODO: Handle this case.
        break;
      case DeviceTypes.smokeDetector:
        // TODO: Handle this case.
        break;
      case DeviceTypes.smokeSensor:
        // TODO: Handle this case.
        break;
      case DeviceTypes.soundSensor:
        // TODO: Handle this case.
        break;
      case DeviceTypes.switch_:
        actionsList.addEntries([
          CommonDevicesScenesPresetsForDevices.switchOnPreset(
            deviceEntity,
            brokerNodeId,
          ),
        ]);
        break;
      case DeviceTypes.teapot:
        // TODO: Handle this case.
        break;
      case DeviceTypes.temperatureSensor:
        // TODO: Handle this case.
        break;
      case DeviceTypes.toaster:
        // TODO: Handle this case.
        break;
      case DeviceTypes.smartTypeNotSupported:
        // TODO: Handle this case.
        break;
      case DeviceTypes.emptyDevice:
        // TODO: Handle this case.
        break;
      case DeviceTypes.pingDevice:
        // TODO: Handle this case.
        break;
      case DeviceTypes.vacuumCleaner:
        // TODO: Handle this case.
        break;
      case DeviceTypes.washingMachine:
        // TODO: Handle this case.
        break;
      case DeviceTypes.smartComputer:
        // TODO: Handle this case.
        break;
    }
    return right(actionsList);
  }
}
