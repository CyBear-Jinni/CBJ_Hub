import 'package:cbj_hub/domain/core/value_objects.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/generic_light_device/generic_light_value_objects.dart';
import 'package:cbj_hub/domain/generic_devices/generic_switch_device/generic_switch_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/esphome/esphome_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/esphome/esphome_light/esphome_light_entity.dart';
import 'package:cbj_hub/infrastructure/devices/esphome/esphome_node_red_api/esphome_node_red_api.dart';
import 'package:cbj_hub/infrastructure/devices/esphome/esphome_node_red_api/esphome_node_red_server_api_calls.dart';
import 'package:cbj_hub/infrastructure/devices/esphome/esphome_switch/esphome_switch_entity.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/injection.dart';

class EspHomeHelpers {
  static Future<String> createDeviceNode({
    required String mDnsName,
    required String devicePassword,
    String? espHomeNodeDeviceId,
  }) async {
    final String tempEspHomeNodeDeviceId =
        espHomeNodeDeviceId ?? UniqueId().getOrCrash();

    await EspHomeNodeRedApi.setNewGlobalEspHomeDeviceNode(
      deviceMdnsName: mDnsName,
      password: devicePassword,
      espHomeDeviceId: tempEspHomeNodeDeviceId,
    );
    await Future.delayed(const Duration(milliseconds: 800));

    return tempEspHomeNodeDeviceId;
  }

  static Future<List<EspHomeDeviceEntityObject>> retreveOnlyNewEntities({
    required String mDnsName,
    required String devicePassword,
  }) async {
    /// 1. Add ESPHome Device node to node red
    final String espHomeDeviceNodeId = await createDeviceNode(
      devicePassword: devicePassword,
      mDnsName: mDnsName,
    );

    /// 2. Get all entities of this device
    final List<EspHomeDeviceEntityObject> allEntities =
        await EspHomeNodeRedServerApiCalls.getEspHomeDeviceEntities(
      espHomeDeviceNodeId,
    );

    // TODO: 3. Remove ESPHome Device node
    // await getIt<INodeRedRepository>().deleteGlobalNode(nodeId: espHomeDeviceNodeId);

    /// 4. Compere device entities with already added entities to retrieve
    ///  only the new once
    for (final EspHomeDeviceEntityObject entity in allEntities) {
      if (getIt<EspHomeConnectorConjector>()
          .getAllCompanyDevices
          .containsKey(entity.config['uniqueId'])) {
        allEntities.remove(entity);
      }
    }
    return allEntities;
  }

  static Future<List<DeviceEntityAbstract>> addDiscoverdEntities({
    required String address,
    required String mDnsName,
    required String devicePassword,
    String port = '6053',
  }) async {
    /// Make sure we add only new entities
    final List<EspHomeDeviceEntityObject> entitiesList =
        await retreveOnlyNewEntities(
      mDnsName: mDnsName,
      devicePassword: devicePassword,
    );

    if (entitiesList.isEmpty) {
      return [];
    }

    final String tempEspHomeNodeDeviceId = UniqueId().getOrCrash();

    // TODO: Fix the extra step where if you add new entities for the same
    //  device it will create new ESPHome device node specially for that entity
    //  instead of using the existing global device node and existing flow
    final String espHomeDeviceNodeId = await createDeviceNode(
      devicePassword: devicePassword,
      mDnsName: mDnsName,
      espHomeNodeDeviceId: tempEspHomeNodeDeviceId,
    );

    final List<DeviceEntityAbstract> deviceEntityList = [];

    for (final EspHomeDeviceEntityObject espHomeDeviceEntityObject
        in entitiesList) {
      final String flowId = UniqueId().getOrCrash();

      final String deviceKey =
          (espHomeDeviceEntityObject.config['key'] as int).toString();
      await EspHomeNodeRedApi.setNewStateNodes(
        espHomeDeviceId: espHomeDeviceNodeId,
        flowId: flowId,
        entityId: deviceKey,
      );

      if (espHomeDeviceEntityObject.type == 'Light') {
        // TODO: Add support for more light types, I think the type is stored in supportedColorModList
        // final List supportedColorModList = espHomeDeviceEntityObject
        //     .config['supportedColorModesList'] as List<dynamic>;
        // if (supportedColorModList.first == 1) {}

        deviceEntityList.add(
          EspHomeLightEntity(
            uniqueId: CoreUniqueId(),
            vendorUniqueId: VendorUniqueId.fromUniqueString(
              espHomeDeviceEntityObject.config['uniqueId'] as String,
            ),
            defaultName: DeviceDefaultName(espHomeDeviceEntityObject.name),
            deviceStateGRPC: DeviceState(DeviceStateGRPC.ack.toString()),
            stateMassage: DeviceStateMassage('Test'),
            senderDeviceOs: DeviceSenderDeviceOs('EspHome'),
            senderDeviceModel: DeviceSenderDeviceModel('Probably esp8266'),
            senderId: DeviceSenderId.fromUniqueString('Test'),
            compUuid: DeviceCompUuid('test'),
            powerConsumption: DevicePowerConsumption('0'),
            lightSwitchState: GenericLightSwitchState('on'),
            deviceMdnsName: DeviceMdnsName(mDnsName),
            devicePort: DevicePort(port),
            espHomeKey: EspHomeKey(deviceKey),
            lastKnownIp: DeviceLastKnownIp(address),
          ),
        );
      } else if (espHomeDeviceEntityObject.type == 'Switch' ||
          espHomeDeviceEntityObject.type == 'Fan' ||
          espHomeDeviceEntityObject.type == 'Siren') {
        deviceEntityList.add(
          EspHomeSwitchEntity(
            uniqueId: CoreUniqueId(),
            vendorUniqueId: VendorUniqueId.fromUniqueString(
              espHomeDeviceEntityObject.config['uniqueId'] as String,
            ),
            defaultName: DeviceDefaultName(espHomeDeviceEntityObject.name),
            deviceStateGRPC: DeviceState(DeviceStateGRPC.ack.toString()),
            stateMassage: DeviceStateMassage('Test'),
            senderDeviceOs: DeviceSenderDeviceOs('EspHome'),
            senderDeviceModel: DeviceSenderDeviceModel('Probably esp8266'),
            senderId: DeviceSenderId.fromUniqueString('Test'),
            compUuid: DeviceCompUuid('test'),
            powerConsumption: DevicePowerConsumption('0'),
            deviceMdnsName: DeviceMdnsName(mDnsName),
            devicePort: DevicePort(port),
            espHomeKey: EspHomeKey(deviceKey),
            lastKnownIp: DeviceLastKnownIp(address),
            switchState: GenericSwitchSwitchState('on'),
          ),
        );
      }
    }

    return deviceEntityList;
  }
}
