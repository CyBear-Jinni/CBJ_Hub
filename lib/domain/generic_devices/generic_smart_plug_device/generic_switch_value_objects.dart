import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/generic_smart_plug_device/generic_switch_validators.dart';
import 'package:dartz/dartz.dart';

class GenericSmartPlugState extends ValueObjectCore<String> {
  factory GenericSmartPlugState(String? input) {
    assert(input != null);
    return GenericSmartPlugState._(
      validateGenericSmartPlugStateNotEmty(input!),
    );
  }

  const GenericSmartPlugState._(this.value);

  @override
  final Either<CoreFailure<String>, String> value;
}
