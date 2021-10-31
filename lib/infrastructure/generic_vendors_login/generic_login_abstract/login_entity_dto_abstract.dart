import 'package:cbj_hub/domain/vendors/login_abstract/login_entity_abstract.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/infrastructure/generic_vendors_login/generic_lifx_login/generic_lifx_login_dtos.dart';
import 'package:cbj_hub/infrastructure/generic_vendors_login/generic_tuya_login/generic_tuya_login_dtos.dart';
import 'package:cbj_hub/utils.dart';

class LoginEntityDtoAbstract {
  LoginEntityDtoAbstract();

  factory LoginEntityDtoAbstract.fromDomain(
    LoginEntityAbstract loginEntityDtoAbstract,
  ) {
    logger.v('LoginEntityDtoAbstract.fromDomain');
    return LoginEntityDtoAbstract();
  }

  factory LoginEntityDtoAbstract.fromJson(Map<String, dynamic> json) {
    LoginEntityDtoAbstract loginEntityDtoAbstract = LoginEntityDtoAbstract();
    final String jsonLoginDtoClass = json['loginVendor'].toString();

    if (jsonLoginDtoClass == VendorsAndServices.lifx.toString()) {
      loginEntityDtoAbstract = GenericLifxLoginDtos.fromJson(json);
    } else if (jsonLoginDtoClass == VendorsAndServices.tuyaSmart.toString()) {
      loginEntityDtoAbstract = GenericTuyaLoginDtos.fromJson(json);
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
