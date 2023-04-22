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
    final EntityTypes deviceType = EntityTypes.values.firstWhere(
      (element) => element.name == deviceEntity.entityTypes.getOrCrash(),
    );

    final Map<String, String> actionsList = <String, String>{};

    switch (deviceType) {
      case EntityTypes.AirConditioner:
        // TODO: Handle this case.
        break;
      case EntityTypes.babyMonitor:
        // TODO: Handle this case.
        break;
      case EntityTypes.bed:
        // TODO: Handle this case.
        break;
      case EntityTypes.blinds:
        actionsList.addEntries([
          CommonDevicesScenesPresetsForDevices.blindsUpPreset(
            deviceEntity,
            brokerNodeId,
          ),
        ]);
        break;
      case EntityTypes.boiler:
        break;
      case EntityTypes.browserApp:
        // TODO: Handle this case.
        break;
      case EntityTypes.button:
        // TODO: Handle this case.
        break;
      case EntityTypes.buttonWithLight:
        // TODO: Handle this case.
        break;
      case EntityTypes.cctLight:
        // TODO: Handle this case.
        break;
      case EntityTypes.coffeeMachine:
        // TODO: Handle this case.
        break;
      case EntityTypes.computerApp:
        // TODO: Handle this case.
        break;
      case EntityTypes.dimmableLight:
        // TODO: Handle this case.
        break;
      case EntityTypes.dishwasher:
        // TODO: Handle this case.
        break;
      case EntityTypes.hub:
        // TODO: Handle this case.
        break;
      case EntityTypes.humiditySensor:
        // TODO: Handle this case.
        break;
      case EntityTypes.kettle:
        // TODO: Handle this case.
        break;
      case EntityTypes.light:
        actionsList.addEntries([
          CommonDevicesScenesPresetsForDevices.lightOnPreset(
            deviceEntity,
            brokerNodeId,
          ),
        ]);
        break;
      case EntityTypes.lightSensor:
        // TODO: Handle this case.
        break;
      case EntityTypes.microphone:
        // TODO: Handle this case.
        break;
      case EntityTypes.motionSensor:
        // TODO: Handle this case.
        break;
      case EntityTypes.oven:
        // TODO: Handle this case.
        break;
      case EntityTypes.oxygenSensor:
        // TODO: Handle this case.
        break;
      case EntityTypes.phoneApp:
        // TODO: Handle this case.
        break;
      case EntityTypes.printer:
        // TODO: Handle this case.
        break;
      case EntityTypes.printerWithScanner:
        // TODO: Handle this case.
        break;
      case EntityTypes.refrigerator:
        // TODO: Handle this case.
        break;
      case EntityTypes.rgbLights:
        // TODO: Handle this case.
        break;
      case EntityTypes.rgbcctLights:
        // TODO: Handle this case.
        break;
      case EntityTypes.rgbwLights:
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
      case EntityTypes.scanner:
        // TODO: Handle this case.
        break;
      case EntityTypes.securityCamera:
        // TODO: Handle this case.
        break;
      case EntityTypes.smartPlug:
        break;
      case EntityTypes.smartSpeakers:
        // TODO: Handle this case.
        break;
      case EntityTypes.smartTV:
        actionsList.addEntries([
          CommonDevicesScenesPresetsForDevices.smartTvOffPreset(
            deviceEntity,
            brokerNodeId,
          ),
        ]);
        break;
      case EntityTypes.smartWatch:
        // TODO: Handle this case.
        break;
      case EntityTypes.smartWaterBottle:
        // TODO: Handle this case.
        break;
      case EntityTypes.smokeDetector:
        // TODO: Handle this case.
        break;
      case EntityTypes.smokeSensor:
        // TODO: Handle this case.
        break;
      case EntityTypes.soundSensor:
        // TODO: Handle this case.
        break;
      case EntityTypes.switch_:
        actionsList.addEntries([
          CommonDevicesScenesPresetsForDevices.switchOnPreset(
            deviceEntity,
            brokerNodeId,
          ),
        ]);
        break;
      case EntityTypes.teapot:
        // TODO: Handle this case.
        break;
      case EntityTypes.temperatureSensor:
        // TODO: Handle this case.
        break;
      case EntityTypes.toaster:
        // TODO: Handle this case.
        break;
      case EntityTypes.smartTypeNotSupported:
        // TODO: Handle this case.
        break;
      case EntityTypes.emptyEntity:
        // TODO: Handle this case.
        break;
      case EntityTypes.pingEntity:
        // TODO: Handle this case.
        break;
      case EntityTypes.vacuumCleaner:
        // TODO: Handle this case.
        break;
      case EntityTypes.washingMachine:
        // TODO: Handle this case.
        break;
      case EntityTypes.smartComputer:
        // TODO: Handle this case.
        break;
      case EntityTypes.playerEntity:
        // TODO: Handle this case.
        break;
      case EntityTypes.routerEntity:
        // TODO: Handle this case.
        break;
      case EntityTypes.voiceAssistant:
        // TODO: Handle this case.
        break;
    }
    return right(actionsList);
  }
}
