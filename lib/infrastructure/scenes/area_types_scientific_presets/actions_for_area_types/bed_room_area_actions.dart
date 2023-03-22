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
    final DeviceTypes deviceType = DeviceTypes.values.firstWhere(
      (element) => element.name == deviceEntity.entityTypes.getOrCrash(),
    );
    final Map<String, String> actionsList = <String, String>{};

    switch (deviceType) {
      case DeviceTypes.AirConditioner:
        // TODO: Turn on on sleep mode?.
        break;
      case DeviceTypes.babyMonitor:
        // TODO: Open and ready.
        break;
      case DeviceTypes.bed:
        // TODO: Change angle to be straight for sleep (not with angle for reading).
        break;
      case DeviceTypes.blinds:
        actionsList.addEntries([
          CommonDevicesScenesPresetsForDevices.blindsDownPreset(
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
        // TODO: Turn off button light for better sleep? or turn on so that it will be easy to find the button at the dart.
        break;
      case DeviceTypes.cctLight:
        // TODO: Turn off dim light in case it turned on in the night.
        break;
      case DeviceTypes.coffeeMachine:
        // TODO: Turn off.
        break;
      case DeviceTypes.computerApp:
        // TODO: Turn sleep mode.
        break;
      case DeviceTypes.dimmableLight:
        // TODO: Turn off dim light in case it turned on in the night.
        break;
      case DeviceTypes.dishwasher:
        // TODO: Turn off.
        break;
      case DeviceTypes.hub:
        // TODO: Handle this case.
        break;
      case DeviceTypes.humiditySensor:
        // TODO: Handle this case.
        break;
      case DeviceTypes.kettle:
        // TODO: Turn off.
        break;
      case DeviceTypes.light:
        actionsList.addEntries([
          CommonDevicesScenesPresetsForDevices.lightOffPreset(
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
        // TODO: Put phone on sleep mode, gray screen as well as quite and maybe set alarm clock for the morning.
        break;
      case DeviceTypes.printer:
        // TODO: Postpone maintenance.
        break;
      case DeviceTypes.printerWithScanner:
        // TODO: Postpone maintenance.
        break;
      case DeviceTypes.refrigerator:
        // TODO: Handle this case.
        break;
      case DeviceTypes.rgbLights:
        // TODO: Turn off and dim light in case it turned on in the night.
        break;
      case DeviceTypes.rgbcctLights:
        // TODO: Turn off and dim light in case it turned on in the night.
        break;
      case DeviceTypes.rgbwLights:
        actionsList.addEntries([
          CommonDevicesScenesPresetsForDevices.rgbwLightOffPreset(
            deviceEntity,
            brokerNodeId,
          ),
        ]);
        break;
      case DeviceTypes.scanner:
        // TODO: Handle this case.
        break;
      case DeviceTypes.securityCamera:
        // TODO: Handle this case.
        break;
      case DeviceTypes.smartPlug:
        actionsList.addEntries([
          CommonDevicesScenesPresetsForDevices.smartPlugOffPreset(
            deviceEntity,
            brokerNodeId,
          ),
        ]);
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
          CommonDevicesScenesPresetsForDevices.switchOffPreset(
            deviceEntity,
            brokerNodeId,
          ),
        ]);
        break;
      case DeviceTypes.teapot:
        // TODO: Turn off.
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
      case DeviceTypes.vacuumCleaner:
        // TODO: Turn off.
        break;
      case DeviceTypes.washingMachine:
        // TODO: Turn off.
        break;
      case DeviceTypes.emptyDevice:
        // TODO: Handle this case.
        break;
      case DeviceTypes.pingDevice:
        // TODO: Handle this case.
        break;
      case DeviceTypes.smartComputer:
        actionsList.addEntries([
          CommonDevicesScenesPresetsForDevices.smartComputerSuspend(
            deviceEntity,
            brokerNodeId,
          ),
        ]);
        break;
    }
    return right(actionsList);
  }
}
