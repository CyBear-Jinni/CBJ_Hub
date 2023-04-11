// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cbj_hub/domain/app_communication/i_app_communication_repository.dart'
    as _i8;
import 'package:cbj_hub/domain/binding/i_binding_cbj_repository.dart' as _i10;
import 'package:cbj_hub/domain/cbj_web_server/i_cbj_web_server_repository.dart'
    as _i12;
import 'package:cbj_hub/domain/local_db/i_local_db_repository.dart' as _i14;
import 'package:cbj_hub/domain/mqtt_server/i_mqtt_server_repository.dart'
    as _i16;
import 'package:cbj_hub/domain/node_red/i_node_red_repository.dart' as _i18;
import 'package:cbj_hub/domain/rooms/i_saved_rooms_repo.dart' as _i24;
import 'package:cbj_hub/domain/routine/i_routine_cbj_repository.dart' as _i20;
import 'package:cbj_hub/domain/saved_devices/i_saved_devices_repo.dart' as _i22;
import 'package:cbj_hub/domain/scene/i_scene_cbj_repository.dart' as _i26;
import 'package:cbj_hub/infrastructure/app_communication/app_communication_repository.dart'
    as _i9;
import 'package:cbj_hub/infrastructure/bindings/binding_repository.dart'
    as _i11;
import 'package:cbj_hub/infrastructure/cbj_web_server/cbj_web_server_repository.dart'
    as _i13;
import 'package:cbj_hub/infrastructure/devices/cbj_devices/cbj_devices_connector_conjector.dart'
    as _i3;
import 'package:cbj_hub/infrastructure/devices/esphome/esphome_connector_conjector.dart'
    as _i4;
import 'package:cbj_hub/infrastructure/devices/ewelink/ewelink_connector_conjector.dart'
    as _i5;
import 'package:cbj_hub/infrastructure/devices/google/google_connector_conjector.dart'
    as _i6;
import 'package:cbj_hub/infrastructure/devices/hp/hp_connector_conjector.dart'
    as _i7;
import 'package:cbj_hub/infrastructure/devices/lg/lg_connector_conjector.dart'
    as _i28;
import 'package:cbj_hub/infrastructure/devices/lifx/lifx_connector_conjector.dart'
    as _i29;
import 'package:cbj_hub/infrastructure/devices/philips_hue/philips_hue_connector_conjector.dart'
    as _i30;
import 'package:cbj_hub/infrastructure/devices/shelly/shelly_connector_conjector.dart'
    as _i32;
import 'package:cbj_hub/infrastructure/devices/sonoff_diy/sonoff_diy_connector_conjector.dart'
    as _i33;
import 'package:cbj_hub/infrastructure/devices/switcher/switcher_connector_conjector.dart'
    as _i34;
import 'package:cbj_hub/infrastructure/devices/tasmota/tasmota_ip/tasmota_ip_connector_conjector.dart'
    as _i36;
import 'package:cbj_hub/infrastructure/devices/tasmota/tasmota_mqtt/tasmota_mqtt_connector_conjector.dart'
    as _i37;
import 'package:cbj_hub/infrastructure/devices/tuya_smart/tuya_smart_connector_conjector.dart'
    as _i38;
import 'package:cbj_hub/infrastructure/devices/wiz/wiz_connector_conjector.dart'
    as _i39;
import 'package:cbj_hub/infrastructure/devices/xiaomi_io/xiaomi_io_connector_conjector.dart'
    as _i40;
import 'package:cbj_hub/infrastructure/devices/yeelight/yeelight_connector_conjector.dart'
    as _i41;
import 'package:cbj_hub/infrastructure/local_db/local_db_hive_repository.dart'
    as _i15;
import 'package:cbj_hub/infrastructure/mqtt_server/mqtt_server_repository.dart'
    as _i17;
import 'package:cbj_hub/infrastructure/node_red/node_red_repository.dart'
    as _i19;
import 'package:cbj_hub/infrastructure/room/saved_rooms_repo.dart' as _i25;
import 'package:cbj_hub/infrastructure/routines/routine_repository.dart'
    as _i21;
import 'package:cbj_hub/infrastructure/saved_devices/saved_devices_repo.dart'
    as _i23;
import 'package:cbj_hub/infrastructure/scenes/scene_repository.dart' as _i27;
import 'package:cbj_hub/infrastructure/shared_variables.dart' as _i31;
import 'package:cbj_hub/infrastructure/system_commands/system_commands_manager_d.dart'
    as _i35;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart'
    as _i2; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i3.CbjDevicesConnectorConjector>(
        _i3.CbjDevicesConnectorConjector());
    gh.singleton<_i4.EspHomeConnectorConjector>(
        _i4.EspHomeConnectorConjector());
    gh.singleton<_i5.EwelinkConnectorConjector>(
        _i5.EwelinkConnectorConjector());
    gh.singleton<_i6.GoogleConnectorConjector>(_i6.GoogleConnectorConjector());
    gh.singleton<_i7.HpConnectorConjector>(_i7.HpConnectorConjector());
    gh.lazySingleton<_i8.IAppCommunicationRepository>(
        () => _i9.AppCommunicationRepository());
    gh.lazySingleton<_i10.IBindingCbjRepository>(
        () => _i11.BindingCbjRepository());
    gh.lazySingleton<_i12.ICbjWebServerRepository>(
        () => _i13.CbjWebServerRepository());
    gh.lazySingleton<_i14.ILocalDbRepository>(() => _i15.HiveRepository());
    gh.lazySingleton<_i16.IMqttServerRepository>(
        () => _i17.MqttServerRepository());
    gh.lazySingleton<_i18.INodeRedRepository>(() => _i19.NodeRedRepository());
    gh.lazySingleton<_i20.IRoutineCbjRepository>(
        () => _i21.RoutineCbjRepository());
    gh.lazySingleton<_i22.ISavedDevicesRepo>(() => _i23.SavedDevicesRepo());
    gh.lazySingleton<_i24.ISavedRoomsRepo>(() => _i25.SavedRoomsRepo());
    gh.lazySingleton<_i26.ISceneCbjRepository>(() => _i27.SceneCbjRepository());
    gh.singleton<_i28.LgConnectorConjector>(_i28.LgConnectorConjector());
    gh.singleton<_i29.LifxConnectorConjector>(_i29.LifxConnectorConjector());
    gh.singleton<_i30.PhilipsHueConnectorConjector>(
        _i30.PhilipsHueConnectorConjector());
    gh.singleton<_i31.SharedVariables>(_i31.SharedVariables());
    gh.singleton<_i32.ShellyConnectorConjector>(
        _i32.ShellyConnectorConjector());
    gh.singleton<_i33.SonoffDiyConnectorConjector>(
        _i33.SonoffDiyConnectorConjector());
    gh.singleton<_i34.SwitcherConnectorConjector>(
        _i34.SwitcherConnectorConjector());
    gh.singleton<_i35.SystemCommandsManager>(_i35.SystemCommandsManager());
    gh.singleton<_i36.TasmotaIpConnectorConjector>(
        _i36.TasmotaIpConnectorConjector());
    gh.singleton<_i37.TasmotaMqttConnectorConjector>(
        _i37.TasmotaMqttConnectorConjector());
    gh.singleton<_i38.TuyaSmartConnectorConjector>(
        _i38.TuyaSmartConnectorConjector());
    gh.singleton<_i39.WizConnectorConjector>(_i39.WizConnectorConjector());
    gh.singleton<_i40.XiaomiIoConnectorConjector>(
        _i40.XiaomiIoConnectorConjector());
    gh.singleton<_i41.YeelightConnectorConjector>(
        _i41.YeelightConnectorConjector());
    return this;
  }
}
