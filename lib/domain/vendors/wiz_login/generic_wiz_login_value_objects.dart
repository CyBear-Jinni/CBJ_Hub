import 'package:cbj_hub/domain/vendors/login_abstract/core_login_failures.dart';
import 'package:cbj_hub/domain/vendors/login_abstract/value_login_objects_core.dart';
import 'package:cbj_hub/domain/vendors/wiz_login/generic_wiz_login_validators.dart';
import 'package:dartz/dartz.dart';

class GenericWizLoginApiKey extends ValueObjectCoreLogin<String> {
  factory GenericWizLoginApiKey(String? input) {
    assert(input != null);
    return GenericWizLoginApiKey._(
      validateGenericWizLoginApiKeyNotEmty(input!),
    );
  }

  const GenericWizLoginApiKey._(this.value);

  @override
  final Either<CoreLoginFailure<String>, String> value;
}
