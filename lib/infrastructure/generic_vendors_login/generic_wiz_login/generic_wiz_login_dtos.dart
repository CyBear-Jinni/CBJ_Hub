import 'package:cbj_hub/domain/vendors/login_abstract/login_entity_abstract.dart';
import 'package:cbj_hub/domain/vendors/login_abstract/value_login_objects_core.dart';
import 'package:cbj_hub/domain/vendors/wiz_login/generic_wiz_login_entity.dart';
import 'package:cbj_hub/domain/vendors/wiz_login/generic_wiz_login_value_objects.dart';
import 'package:cbj_hub/infrastructure/generic_vendors_login/generic_login_abstract/login_entity_dto_abstract.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'generic_wiz_login_dtos.freezed.dart';
part 'generic_wiz_login_dtos.g.dart';

@freezed
abstract class GenericWizLoginDtos
    implements _$GenericWizLoginDtos, LoginEntityDtoAbstract {
  factory GenericWizLoginDtos({
    // @JsonKey(ignore: true)
    required String? senderUniqueId,
    required String? loginVendor,
    required String? wizApiKey,
    // required ServerTimestampConverter() FieldValue serverTimeStamp,
  }) = _GenericWizLoginDtos;

  GenericWizLoginDtos._();

  factory GenericWizLoginDtos.fromDomain(GenericWizLoginDE genericWizDE) {
    return GenericWizLoginDtos(
      senderUniqueId: genericWizDE.senderUniqueId.getOrCrash(),
      loginVendor: genericWizDE.loginVendor.getOrCrash(),
      wizApiKey: genericWizDE.wizApiKey.getOrCrash(),

      // serverTimeStamp: FieldValue.serverTimestamp(),
    );
  }

  factory GenericWizLoginDtos.fromJson(Map<String, dynamic> json) =>
      _$GenericWizLoginDtosFromJson(json);

  @override
  final String loginDtoClassInstance = (GenericWizLoginDtos).toString();

  @override
  LoginEntityAbstract toDomain() {
    return GenericWizLoginDE(
      senderUniqueId: CoreLoginSenderId.fromUniqueString(senderUniqueId),
      wizApiKey: GenericWizLoginApiKey(wizApiKey),
    );
  }
}

// class ServerTimestampConverter implements JsonConverter<FieldValue, Object> {
//   const ServerTimestampConverter();
//
//   @override
//   FieldValue fromJson(Object json) {
//     return FieldValue.serverTimestamp();
//   }
//
//   @override
//   Object toJson(FieldValue fieldValue) => fieldValue;
// }
