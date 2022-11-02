import 'package:cbj_hub/domain/binding/binding_cbj_entity.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/local_db/local_db_failures.dart';
import 'package:cbj_hub/domain/room/room_entity.dart';
import 'package:cbj_hub/domain/routine/routine_cbj_entity.dart';
import 'package:cbj_hub/domain/scene/scene_cbj_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ISavedRoomsRepo {
  /// Setting up all rooms from db
  Future<void> setUpAllFromDb();

  /// Add new room to saved rooms list
  RoomEntity addOrUpdateRoom(RoomEntity roomEntity);

  /// Check if the device exist in one of the rooms, if not will add it to
  /// Discovered room
  void addDeviceToRoomDiscoveredIfNotExist(DeviceEntityAbstract deviceEntity);

  /// Check if the scene exist in one of the rooms, if not will add it to
  /// Discovered room
  void addSceneToRoomDiscoveredIfNotExist(SceneCbjEntity sceneCbjEntity);

  /// Check if the routine exist in one of the rooms, if not will add it to
  /// Discovered room
  void addRoutineToRoomDiscoveredIfNotExist(RoutineCbjEntity routineCbjEntity);

  /// Check if the binding exist in one of the rooms, if not will add it to
  /// Discovered room
  void addBindingToRoomDiscoveredIfNotExist(BindingCbjEntity bindingCbjEntity);

  Future<Either<LocalDbFailures, Unit>> saveAndActiveRoomToDb({
    required RoomEntity roomEntity,
  });

  Future<Either<LocalDbFailures, RoomEntity>>
      createScenesForAllSelectedRoomTypes({
    required RoomEntity roomEntity,
  });

  /// Get all saved rooms
  Future<Map<String, RoomEntity>> getAllRooms();
}
