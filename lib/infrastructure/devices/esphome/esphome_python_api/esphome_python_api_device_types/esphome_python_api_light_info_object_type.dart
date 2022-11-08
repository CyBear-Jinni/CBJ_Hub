import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/generic_light_device/generic_light_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/esphome/esphome_light/esphome_light_entity.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'esphome_python_api_light_info_object_type.freezed.dart';
part 'esphome_python_api_light_info_object_type.g.dart';

/// ESPHome LightInfo object type
@freezed
abstract class EsphomePythonApiLightInfoObjectType
    implements _$EsphomePythonApiLightInfoObjectType {
  factory EsphomePythonApiLightInfoObjectType({
    // @JsonKey(ignore: true)
    @JsonKey(name: 'object_id') String? objectId,
    int? key,
    String? name,
    @JsonKey(name: 'unique_id') String? uniqueId,
    @JsonKey(name: 'disabled_by_default') bool? disabledByDefault,
    String? icon,
    @JsonKey(name: 'entity_category') int? entityCategory,
    @JsonKey(name: 'supported_color_modes') List<int>? supportedColorModes,
    @JsonKey(name: 'min_mireds') double? minMireds,
    @JsonKey(name: 'max_mireds') double? maxMireds,
    List<String>? effects,
    @JsonKey(name: 'legacy_supports_brightness') bool? legacySupportsBrightness,
    @JsonKey(name: 'legacy_supports_rgb') bool? legacySupportsRgb,
    @JsonKey(name: 'legacy_supports_white_value')
        bool? legacySupportsWhiteValue,
    @JsonKey(name: 'legacy_supports_color_temperature')
        bool? legacySupportsColorTemperature,
  }) = _EsphomePythonApiLightInfoObjectType;

  EsphomePythonApiLightInfoObjectType._();

  factory EsphomePythonApiLightInfoObjectType.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$EsphomePythonApiLightInfoObjectTypeFromJson(json);

  EspHomeLightEntity toEspHomeLightEntity({
    required String address,
    required String mDnsName,
    required String? port,
  }) {
    return EspHomeLightEntity(
      uniqueId: CoreUniqueId(),
      vendorUniqueId: VendorUniqueId.fromUniqueString(uniqueId!),
      defaultName: DeviceDefaultName(name),
      deviceStateGRPC: DeviceState(DeviceStateGRPC.ack.toString()),
      stateMassage: DeviceStateMassage('EspHome Created'),
      senderDeviceOs: DeviceSenderDeviceOs('ESPHome'),
      senderDeviceModel: DeviceSenderDeviceModel('ESPHome model'),
      senderId: DeviceSenderId.fromUniqueString('No sender id'),
      compUuid: DeviceCompUuid('No comp uuid'),
      powerConsumption: DevicePowerConsumption('0'),
      lightSwitchState: GenericLightSwitchState(DeviceActions.off.toString()),
      deviceMdnsName: DeviceMdnsName(mDnsName),
      devicePort: DevicePort(port),
      espHomeKey: EspHomeKey(key.toString()),
      lastKnownIp: DeviceLastKnownIp(address),
    );
  }
}
