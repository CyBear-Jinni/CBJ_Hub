import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:dartz/dartz.dart';

Either<CoreFailure<String>, String> validateGenericBlindsStateNotEmpty(
  String input,
) {
  return right(input);
}

/// Return all the valid actions for blinds
List<String> blindsAllValidActions() {
  return [
    EntityActions.moveUp.toString(),
    EntityActions.stop.toString(),
    EntityActions.moveDown.toString(),
  ];
}
