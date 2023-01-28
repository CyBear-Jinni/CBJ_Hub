import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:dartz/dartz.dart';

Either<CoreFailure<String>, String> validateCbjDevicesIdNotEmpty(String input) {
  return right(input);
}

Either<CoreFailure<String>, String> validateCbjDevicesPortNotEmpty(
  String input,
) {
  return right(input);
}

Either<CoreFailure<String>, String> validateCbjDevicesMacAddressNotEmpty(
  String input,
) {
  return right(input);
}
