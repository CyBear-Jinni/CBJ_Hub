import 'package:cbj_hub/domain/vendors/login_abstract/core_login_failures.dart';
import 'package:dartz/dartz.dart';

Either<CoreLoginFailure<String>, String> validateGenericEwelinkNotEmpty(
  String input,
) {
  return right(input);
}
