import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/generic_light_with_brightness_device/generic_light_with_brightness_validators.dart';
import 'package:dartz/dartz.dart';

class GenericLightWithBrightnessSwitchState extends ValueObjectCore<String> {
  factory GenericLightWithBrightnessSwitchState(String? input) {
    assert(input != null);
    return GenericLightWithBrightnessSwitchState._(
      validateGenericLightWithBrightnessStateNotEmpty(input!),
    );
  }

  const GenericLightWithBrightnessSwitchState._(this.value);

  @override
  final Either<CoreFailure<String>, String> value;

  static List<String> lightValidActions() {
    return lightAllValidActions();
  }
}

class GenericLightWithBrightnessBrightness extends ValueObjectCore<String> {
  factory GenericLightWithBrightnessBrightness(String? input) {
    assert(input != null);
    return GenericLightWithBrightnessBrightness._(
      validateGenericLightBrightnessNotEmpty(input!),
    );
  }

  const GenericLightWithBrightnessBrightness._(this.value);

  @override
  final Either<CoreFailure<String>, String> value;
}
