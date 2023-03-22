import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/generic_switch_device/generic_switch_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/tasmota/tasmota_ip/tasmota_ip_api/tasmota_ip_api_components.dart';
import 'package:cbj_hub/infrastructure/devices/tasmota/tasmota_ip/tasmota_ip_switch/tasmota_ip_switch_entity.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbenum.dart';
import 'package:cbj_hub/utils.dart';
import 'package:network_tools/network_tools.dart';

class TasmotaIpHelpers {
  static Future<List<DeviceEntityAbstract>> addDiscoverdDevice({
    required ActiveHost activeHost,
    required List<CoreUniqueId?> uniqueDeviceIdList,
    required List<String> componentInDeviceNumberLabelList,
  }) async {
    final List<CoreUniqueId> uniqueDeviceIdTempList = [];

    for (int counter = 0;
        counter < componentInDeviceNumberLabelList.length;
        counter++) {
      if (counter < uniqueDeviceIdList.length &&
          uniqueDeviceIdList[counter] != null) {
        uniqueDeviceIdTempList.add(uniqueDeviceIdList[counter]!);
      } else {
        uniqueDeviceIdTempList.add(CoreUniqueId());
      }
    }

    final List<DeviceEntityAbstract> devicesToAddTemp = [];

    for (int counter = 0;
        counter < componentInDeviceNumberLabelList.length;
        counter++) {
      final String componentInDeviceNumberLabel =
          componentInDeviceNumberLabelList[counter];
      final CoreUniqueId coreUniqueIdTemp = uniqueDeviceIdTempList[counter];
      final DeviceEntityAbstract? deviceEntity = await addDeviceByTasmotaType(
        componentInDeviceNumberLabel: componentInDeviceNumberLabel,
        coreUniqueIdTemp: coreUniqueIdTemp,
        activeHost: activeHost,
      );
      if (deviceEntity != null) {
        devicesToAddTemp.add(deviceEntity);
      }
    }

    return devicesToAddTemp;
  }

  static Future<DeviceEntityAbstract?> addDeviceByTasmotaType({
    required String componentInDeviceNumberLabel,
    required ActiveHost activeHost,
    required CoreUniqueId coreUniqueIdTemp,
  }) async {
    final String? deviceHostName = await activeHost.hostName;
    if (deviceHostName == null) {
      return null;
    }
    final int componentInDeviceNumberLabelAsInt =
        int.parse(componentInDeviceNumberLabel);

    if (!gpioOverviewTasmota.keys.contains(componentInDeviceNumberLabelAsInt) ||
        gpioOverviewTasmota[componentInDeviceNumberLabelAsInt]!.length < 2) {
      logger.w(
        'Tasmota ip does not contain this key, you can add more in [gpioOverviewTasmota]',
      );
      return null;
    }
    final List<String>? componentInDeviceUiLabelAndComment =
        gpioOverviewTasmota[componentInDeviceNumberLabelAsInt];

    if (componentInDeviceNumberLabelAsInt == 0) {
      // UI Label: None
      return null;
    } else if (componentInDeviceNumberLabelAsInt >= 32 &&
        componentInDeviceNumberLabelAsInt <= 39) {
      // UI Label: Button
    } else if (componentInDeviceNumberLabelAsInt >= 64 &&
        componentInDeviceNumberLabelAsInt <= 71) {
      // UI Label: Button_n
    } else if (componentInDeviceNumberLabelAsInt >= 96 &&
        componentInDeviceNumberLabelAsInt <= 103) {
      // UI Label: Button_i
    } else if (componentInDeviceNumberLabelAsInt >= 224 &&
        componentInDeviceNumberLabelAsInt <= 251) {
      // UI Label: Relay
      return TasmotaIpSwitchEntity(
        uniqueId: coreUniqueIdTemp,
        entityUniqueId: EntityUniqueId(
          '$deviceHostName-$componentInDeviceNumberLabel}',
        ),
        cbjEntityName: CbjEntityName(
          '$deviceHostName-${componentInDeviceUiLabelAndComment![0]}',
        ),
        entityOriginalName: EntityOriginalName(
          '$deviceHostName-${componentInDeviceUiLabelAndComment[0]}',
        ),
        deviceOriginalName: DeviceOriginalName(
          '$deviceHostName-${componentInDeviceUiLabelAndComment[0]}',
        ),
        entityStateGRPC: EntityState(DeviceStateGRPC.ack.toString()),
        senderDeviceOs: DeviceSenderDeviceOs('Tasmota'),
        senderDeviceModel: DeviceSenderDeviceModel('Tasmota'),
        senderId: DeviceSenderId(),
        compUuid: DeviceCompUuid('34asdfrsd23gggg'),
        stateMassage: DeviceStateMassage('Hello World'),
        powerConsumption: DevicePowerConsumption('0'),
        switchState: GenericSwitchSwitchState(DeviceActions.off.toString()),
        deviceHostName: DeviceHostName(deviceHostName),
        deviceLastKnownIp: DeviceLastKnownIp(activeHost.address),
        deviceUniqueId: DeviceUniqueId('0'),
        devicePort: DevicePort('0'),
        deviceMdns: DeviceMdns('0'),
        devicesMacAddress: DevicesMacAddress('0'),
        entityKey: EntityKey('0'),
        requestTimeStamp: RequestTimeStamp('0'),
        lastResponseFromDeviceTimeStamp: LastResponseFromDeviceTimeStamp('0'),
        deviceCbjUniqueId: CoreUniqueId(),
      );
    } else if (componentInDeviceNumberLabelAsInt >= 256 &&
        componentInDeviceNumberLabelAsInt <= 283) {
      // UI Label: Relay_i
    } else if (componentInDeviceNumberLabelAsInt >= 288 &&
        componentInDeviceNumberLabelAsInt <= 291) {
      // UI Label: Led
    } else if (componentInDeviceNumberLabelAsInt >= 320 &&
        componentInDeviceNumberLabelAsInt <= 323) {
      // UI Label: Led_i
    }

    logger.i(
      'Please add new Tasmota device type ${componentInDeviceUiLabelAndComment![0]}',
    );
    return null;
  }
}
