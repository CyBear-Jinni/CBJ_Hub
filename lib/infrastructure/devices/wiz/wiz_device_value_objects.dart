import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/infrastructure/devices/wiz/wiz_device_validators.dart';
import 'package:dartz/dartz.dart';

/// Wiz communication port
class WizPort extends ValueObjectCore<String> {
  factory WizPort(String? input) {
    assert(input != null);
    return WizPort._(
      validateWizPortNotEmpty(input!),
    );
  }

  const WizPort._(this.value);

  @override
  final Either<CoreFailure<String>, String> value;
}
