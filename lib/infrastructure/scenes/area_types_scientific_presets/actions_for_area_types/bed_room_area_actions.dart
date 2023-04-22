import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/scene/scene_cbj_failures.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/infrastructure/scenes/area_types_scientific_presets/common_devices_scenes_presets_for_devices.dart';
import 'package:dartz/dartz.dart';

class BedRoomAreaAction {
  Future<Either<SceneCbjFailure, Map<String, String>>> bedRoomSleepDeviceAction(
    DeviceEntityAbstract deviceEntity,
    String brokerNodeId,
  ) async {
    final EntityTypes deviceType = EntityTypes.values.firstWhere(
      (element) => element.name == deviceEntity.entityTypes.getOrCrash(),
    );
    final Map<String, String> actionsList = <String, String>{};

    switch (deviceType) {
      case EntityTypes.AirConditioner:
        // TODO: Turn on on sleep mode?.
        break;
      case EntityTypes.babyMonitor:
        // TODO: Open and ready.
        break;
      case EntityTypes.bed:
        // TODO: Change angle to be straight for sleep (not with angle for reading).
        break;
      case EntityTypes.blinds:
        actionsList.addEntries([
          CommonDevicesScenesPresetsForDevices.blindsDownPreset(
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
        // TODO: Turn off button light for better sleep? or turn on so that it will be easy to find the button at the dart.
        break;
      case EntityTypes.cctLight:
        // TODO: Turn off dim light in case it turned on in the night.
        break;
      case EntityTypes.coffeeMachine:
        // TODO: Turn off.
        break;
      case EntityTypes.computerApp:
        // TODO: Turn sleep mode.
        break;
      case EntityTypes.dimmableLight:
        // TODO: Turn off dim light in case it turned on in the night.
        break;
      case EntityTypes.dishwasher:
        // TODO: Turn off.
        break;
      case EntityTypes.hub:
        // TODO: Handle this case.
        break;
      case EntityTypes.humiditySensor:
        // TODO: Handle this case.
        break;
      case EntityTypes.kettle:
        // TODO: Turn off.
        break;
      case EntityTypes.light:
        actionsList.addEntries([
          CommonDevicesScenesPresetsForDevices.lightOffPreset(
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
        // TODO: Put phone on sleep mode, gray screen as well as quite and maybe set alarm clock for the morning.
        break;
      case EntityTypes.printer:
        // TODO: Postpone maintenance.
        break;
      case EntityTypes.printerWithScanner:
        // TODO: Postpone maintenance.
        break;
      case EntityTypes.refrigerator:
        // TODO: Handle this case.
        break;
      case EntityTypes.rgbLights:
        // TODO: Turn off and dim light in case it turned on in the night.
        break;
      case EntityTypes.rgbcctLights:
        // TODO: Turn off and dim light in case it turned on in the night.
        break;
      case EntityTypes.rgbwLights:
        actionsList.addEntries([
          CommonDevicesScenesPresetsForDevices.rgbwLightOffPreset(
            deviceEntity,
            brokerNodeId,
          ),
        ]);
        break;
      case EntityTypes.scanner:
        // TODO: Handle this case.
        break;
      case EntityTypes.securityCamera:
        // TODO: Handle this case.
        break;
      case EntityTypes.smartPlug:
        actionsList.addEntries([
          CommonDevicesScenesPresetsForDevices.smartPlugOffPreset(
            deviceEntity,
            brokerNodeId,
          ),
        ]);
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
          CommonDevicesScenesPresetsForDevices.switchOffPreset(
            deviceEntity,
            brokerNodeId,
          ),
        ]);
        break;
      case EntityTypes.teapot:
        // TODO: Turn off.
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
      case EntityTypes.vacuumCleaner:
        // TODO: Turn off.
        break;
      case EntityTypes.washingMachine:
        // TODO: Turn off.
        break;
      case EntityTypes.emptyEntity:
        // TODO: Handle this case.
        break;
      case EntityTypes.pingEntity:
        // TODO: Handle this case.
        break;
      case EntityTypes.smartComputer:
        actionsList.addEntries([
          CommonDevicesScenesPresetsForDevices.smartComputerSuspend(
            deviceEntity,
            brokerNodeId,
          ),
        ]);
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
