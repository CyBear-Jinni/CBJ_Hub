import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:dartz/dartz.dart';

Either<CoreFailure<String>, String> validateLifxIdNotEmpty(String input) {
  return right(input);
}

Either<CoreFailure<String>, String> validateLifxPortNotEmpty(String input) {
  return right(input);
}
