import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/generic_smart_tv/generic_smart_tv_validators.dart';
import 'package:dartz/dartz.dart';

class GenericSmartTvSwitchState extends ValueObjectCore<String> {
  factory GenericSmartTvSwitchState(String? input) {
    assert(input != null);
    return GenericSmartTvSwitchState._(
      validateGenericSmartTvStateNotEmpty(input!),
    );
  }

  const GenericSmartTvSwitchState._(this.value);

  @override
  final Either<CoreFailure<String>, String> value;

  /// All valid actions of smart tv state
  static List<String> smartTvValidActions() {
    return smartTvAllValidActions();
  }
}
