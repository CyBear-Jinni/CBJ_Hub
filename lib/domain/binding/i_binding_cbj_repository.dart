import 'package:cbj_hub/domain/binding/binding_cbj_entity.dart';
import 'package:cbj_hub/domain/binding/binding_cbj_failures.dart';
import 'package:cbj_hub/domain/local_db/local_db_failures.dart';
import 'package:dartz/dartz.dart';

abstract class IBindingCbjRepository {
  /// Setting up all bindings from db
  Future<void> setUpAllFromDb();

  Future<List<BindingCbjEntity>> getAllBindingsAsList();

  Future<Map<String, BindingCbjEntity>> getAllBindingsAsMap();

  /// Sending the new binding to the hub to get added
  Future<Either<BindingCbjFailure, Unit>> addNewBinding(
    BindingCbjEntity bindingCbj,
  );

  Future<Either<LocalDbFailures, Unit>> saveAndActivateBindingToDb();

  Future<bool> activateBinding(
    BindingCbjEntity bindingCbj,
  );

  /// Get entity and return the full MQTT path to it
  Future<String> getFullMqttPathOfBinding(BindingCbjEntity bindingCbj);
}
