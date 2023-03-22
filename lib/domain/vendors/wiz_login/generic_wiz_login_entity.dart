import 'package:cbj_hub/domain/vendors/login_abstract/core_login_failures.dart';
import 'package:cbj_hub/domain/vendors/login_abstract/login_entity_abstract.dart';
import 'package:cbj_hub/domain/vendors/login_abstract/value_login_objects_core.dart';
import 'package:cbj_hub/domain/vendors/wiz_login/generic_wiz_login_value_objects.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/infrastructure/generic_vendors_login/generic_login_abstract/login_entity_dto_abstract.dart';
import 'package:cbj_hub/infrastructure/generic_vendors_login/generic_wiz_login/generic_wiz_login_dtos.dart';
import 'package:dartz/dartz.dart';

/// Abstract smart GenericWiz that exist inside a computer, the
/// implementations will be actual GenericWiz like blinds wizs and more
class GenericWizLoginDE extends LoginEntityAbstract {
  /// All public field of GenericWiz entity
  GenericWizLoginDE({
    required super.senderUniqueId,
    required this.wizApiKey,
  }) : super(
          loginVendor: CoreLoginVendor(VendorsAndServices.tuyaSmart.name),
        );

  /// Empty instance of GenericWizEntity
  factory GenericWizLoginDE.empty() => GenericWizLoginDE(
        senderUniqueId: CoreLoginSenderId.fromUniqueString(''),
        wizApiKey: GenericWizLoginApiKey(''),
      );

  /// Wiz api key
  GenericWizLoginApiKey wizApiKey;

  Option<CoreLoginFailure<dynamic>> get failureOption =>
      senderUniqueId.value.fold((f) => some(f), (_) => none());

  //
  // /// Will return failure if any of the fields failed or return unit if fields
  // /// have legit values
  // Option<CoreFailure<dynamic>> get failureOption {
  //   return cbjEntityName!.value.fold((f) => some(f), (_) => none());
  //
  // return body.failureOrUnit
  //     .andThen(todos.failureOrUnit)
  //     .andThen(
  //       todos
  //           .getOrCrash()
  //           // Getting the failureOption from the TodoItem ENTITY - NOT a failureOrUnit from a VALUE OBJECT
  //           .map((todoItem) => todoItem.failureOption)
  //           .filter((o) => o.isSome())
  //           // If we can't get the 0th element, the list is empty. In such a case, it's valid.
  //           .getOrElse(0, (_) => none())
  //           .fold(() => right(unit), (f) => left(f)),
  //     )
  //     .fold((f) => some(f), (_) => none());
  // }

  @override
  LoginEntityDtoAbstract toInfrastructure() {
    return GenericWizLoginDtos(
      senderUniqueId: senderUniqueId.getOrCrash(),
      loginVendor: loginVendor.getOrCrash(),
      wizApiKey: wizApiKey.getOrCrash(),
    );
  }
}
