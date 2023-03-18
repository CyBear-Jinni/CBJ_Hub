// import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
// import 'package:cbj_hub/domain/generic_devices/generic_switch_device/generic_switch_value_objects.dart';
// import 'package:cbj_hub/infrastructure/devices/esphome/esphome_switch/esphome_switch_entity.dart';
// import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';
//
// part 'esphome_python_api_switch_info_object_type.freezed.dart';
// part 'esphome_python_api_switch_info_object_type.g.dart';
//
// /// ESPHome SwitchInfo object type
// @freezed
// abstract class EsphomePythonApiSwitchInfoObjectType
//     implements _$EsphomePythonApiSwitchInfoObjectType {
//   factory EsphomePythonApiSwitchInfoObjectType({
//     // @JsonKey(ignore: true)
//     @JsonKey(name: 'object_id') String? objectId,
//     int? key,
//     String? name,
//     @JsonKey(name: 'unique_id') String? uniqueId,
//     @JsonKey(name: 'disabled_by_default') bool? disabledByDefault,
//     String? icon,
//     @JsonKey(name: 'entity_category') int? entityCategory,
//     @JsonKey(name: 'assumed_state') bool? assumedState,
//     @JsonKey(name: 'device_class') String? deviceClass,
//   }) = _EsphomePythonApiSwitchInfoObjectType;
//
//   EsphomePythonApiSwitchInfoObjectType._();
//
//   factory EsphomePythonApiSwitchInfoObjectType.fromJson(
//     Map<String, dynamic> json,
//   ) =>
//       _$EsphomePythonApiSwitchInfoObjectTypeFromJson(json);
//
//   EspHomeSwitchEntity toEspHomeSwitchEntity({
//     required String address,
//     required String mDnsName,
//     required String? port,
//   }) {
//     return EspHomeSwitchEntity(
//       uniqueId: CoreUniqueId(),
//       vendorUniqueId: VendorUniqueId.fromUniqueString(uniqueId!),
//       defaultName: DeviceDefaultName(name),
//       deviceStateGRPC: DeviceState(DeviceStateGRPC.ack.toString()),
//       stateMassage: DeviceStateMassage('EspHome Created'),
//       senderDeviceOs: DeviceSenderDeviceOs('ESPHome'),
//       senderDeviceModel: DeviceSenderDeviceModel('ESPHome model'),
//       senderId: DeviceSenderId.fromUniqueString('No sender id'),
//       compUuid: DeviceCompUuid('No comp uuid'),
//       powerConsumption: DevicePowerConsumption('0'),
//       switchState: GenericSwitchSwitchState(DeviceActions.off.toString()),
//       deviceMdnsName: DeviceMdnsName(mDnsName),
//       devicePort: DevicePort(port),
//       espHomeKey: EspHomeKey(key.toString()),
//       lastKnownIp: DeviceLastKnownIp(address),
//     );
//   }
// }
