import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/local_db/local_db_failures.dart';
import 'package:cbj_hub/domain/remote_pipes/remote_pipes_entity.dart';
import 'package:cbj_hub/domain/vendors/login_abstract/login_entity_abstract.dart';
import 'package:dartz/dartz.dart';

abstract class ISavedDevicesRepo {
  /// Setting up all devices from db
  Future<void> setUpAllFromDb();

  DeviceEntityAbstract? addOrUpdateFromMqtt(dynamic updateFromMqtt);

  /// Add new device to saved devices list
  DeviceEntityAbstract addOrUpdateDevice(DeviceEntityAbstract deviceEntity);

  /// Will save the remote pipes entity to the local storage and will activate
  /// connection to remote pipes with that info
  /// Will return true if complete success
  Future<Either<LocalDbFailures, Unit>> saveAndActivateRemotePipesDomainToDb({
    required RemotePipesEntity remotePipes,
  });

  Future<Either<LocalDbFailures, Unit>> saveAndActivateSmartDevicesToDb();

  /// Save login of different form factors to the local db
  Future<Either<LocalDbFailures, Unit>>
      saveAndActivateVendorLoginCredentialsDomainToDb({
    required LoginEntityAbstract loginEntity,
  });

  /// Get all saved devices
  Future<Map<String, DeviceEntityAbstract>> getAllDevices();

  /// Get device by unique ID
  Future<Either<LocalDbFailures, DeviceEntityAbstract>> getDeviceById(
    String deviceUniqueId,
  );
}
