import 'package:cbj_hub/domain/vendors/login_abstract/login_entity_abstract.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/infrastructure/generic_vendors_login/generic_esphome_login/generic_esphome_login_dtos.dart';
import 'package:cbj_hub/infrastructure/generic_vendors_login/generic_ewelink_login/generic_ewelink_login_dtos.dart';
import 'package:cbj_hub/infrastructure/generic_vendors_login/generic_lifx_login/generic_lifx_login_dtos.dart';
import 'package:cbj_hub/infrastructure/generic_vendors_login/generic_tuya_login/generic_tuya_login_dtos.dart';
import 'package:cbj_hub/infrastructure/generic_vendors_login/generic_xiaomi_mi_login/generic_xiaomi_mi_login_dtos.dart';
import 'package:cbj_hub/utils.dart';

class LoginEntityDtoAbstract {
  LoginEntityDtoAbstract();

  factory LoginEntityDtoAbstract.fromDomain() {
    logger.v('LoginEntityDtoAbstract.fromDomain');
    return LoginEntityDtoAbstract();
  }

  factory LoginEntityDtoAbstract.fromJson(Map<String, dynamic> json) {
    LoginEntityDtoAbstract loginEntityDtoAbstract = LoginEntityDtoAbstract();
    final String jsonLoginDtoClass = json['loginVendor'].toString();

    if (jsonLoginDtoClass == VendorsAndServices.lifx.toString()) {
      loginEntityDtoAbstract = GenericLifxLoginDtos.fromJson(json);
    } else if (jsonLoginDtoClass == VendorsAndServices.espHome.toString()) {
      loginEntityDtoAbstract = GenericEspHomeLoginDtos.fromJson(json);
    } else if (jsonLoginDtoClass == VendorsAndServices.tuyaSmart.toString() ||
        jsonLoginDtoClass == VendorsAndServices.smartLife.toString() ||
        jsonLoginDtoClass == VendorsAndServices.jinvooSmart.toString()) {
      loginEntityDtoAbstract = GenericTuyaLoginDtos.fromJson(json);
    } else if (jsonLoginDtoClass == VendorsAndServices.xiaomiMi.toString()) {
      loginEntityDtoAbstract = GenericXiaomiMiLoginDtos.fromJson(json);
    } else if (jsonLoginDtoClass ==
        VendorsAndServices.sonoffEweLink.toString()) {
      loginEntityDtoAbstract = GenericEwelinkLoginDtos.fromJson(json);
    } else {
      throw 'DtoClassTypeDoesNotExist';
    }
    return loginEntityDtoAbstract;
  }

  final String loginDtoClassInstance = (LoginEntityDtoAbstract).toString();

  Map<String, dynamic> toJson() {
    logger.v('LoginEntityDtoAbstract to Json');
    return {};
  }

  LoginEntityAbstract toDomain() {
    logger.v('ToDomain');
    return LoginEntityEmpty();
  }
}
