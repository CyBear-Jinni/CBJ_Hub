import 'package:cbj_hub/domain/vendors/login_abstract/core_login_failures.dart';
import 'package:dartz/dartz.dart';

Either<CoreLoginFailure<String>, String> validateGenericLifxLoginApiKeyNotEmty(
  String input,
) {
  if (input != null) {
    return right(input);
  } else {
    return left(CoreLoginFailure.empty(failedValue: input));
  }
}
