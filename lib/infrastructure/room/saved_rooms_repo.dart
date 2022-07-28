import 'dart:collection';

import 'package:cbj_hub/domain/binding/binding_cbj_entity.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/local_db/i_local_db_repository.dart';
import 'package:cbj_hub/domain/local_db/local_db_failures.dart';
import 'package:cbj_hub/domain/room/room_entity.dart';
import 'package:cbj_hub/domain/room/value_objects_room.dart';
import 'package:cbj_hub/domain/rooms/i_saved_rooms_repo.dart';
import 'package:cbj_hub/domain/routine/routine_cbj_entity.dart';
import 'package:cbj_hub/domain/saved_devices/i_saved_devices_repo.dart';
import 'package:cbj_hub/domain/scene/scene_cbj_entity.dart';
import 'package:cbj_hub/injection.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ISavedRoomsRepo)
class SavedRoomsRepo extends ISavedRoomsRepo {
  SavedRoomsRepo() {
    setUpAllFromDb();
  }

  static final HashMap<String, RoomEntity> _allRooms =
      HashMap<String, RoomEntity>();

  Future<void> setUpAllFromDb() async {
    /// Delay inorder for the Hive boxes to initialize
    /// In case you got the following error:
    /// "HiveError: You need to initialize Hive or provide a path to store
    /// the box."
    /// Please increase the duration
    await Future.delayed(const Duration(milliseconds: 100));
    getIt<ILocalDbRepository>().getRoomsFromDb().then((value) {
      value.fold((l) => null, (r) {
        r.forEach((element) {
          addOrUpdateRoom(element);
        });
      });
    });
  }

  @override
  Future<Map<String, RoomEntity>> getAllRooms() async {
    return _allRooms;
  }

  RoomEntity? getRoomDeviceExistIn(DeviceEntityAbstract deviceEntityAbstract) {
    final String uniqueId = deviceEntityAbstract.uniqueId.getOrCrash();
    for (final RoomEntity roomEntity in _allRooms.values) {
      if (roomEntity.roomDevicesId.getOrCrash().contains(uniqueId)) {
        return roomEntity;
      }
    }
    return null;
  }

  RoomEntity? getRoomSceneExistIn(SceneCbjEntity sceneCbj) {
    final String uniqueId = sceneCbj.uniqueId.getOrCrash();
    for (final RoomEntity roomEntity in _allRooms.values) {
      if (roomEntity.roomScenesId.getOrCrash().contains(uniqueId)) {
        return roomEntity;
      }
    }
    return null;
  }

  RoomEntity? getRoomRoutineExistIn(RoutineCbjEntity routineCbj) {
    final String uniqueId = routineCbj.uniqueId.getOrCrash();
    for (final RoomEntity roomEntity in _allRooms.values) {
      if (roomEntity.roomRoutinesId.getOrCrash().contains(uniqueId)) {
        return roomEntity;
      }
    }
    return null;
  }

  RoomEntity? getRoomBindingExistIn(BindingCbjEntity bindingCbj) {
    final String uniqueId = bindingCbj.uniqueId.getOrCrash();
    for (final RoomEntity roomEntity in _allRooms.values) {
      if (roomEntity.roomBindingsId.getOrCrash().contains(uniqueId)) {
        return roomEntity;
      }
    }
    return null;
  }

  @override
  RoomEntity addOrUpdateRoom(RoomEntity roomEntity) {
    _allRooms.addEntries([
      MapEntry<String, RoomEntity>(roomEntity.uniqueId.getOrCrash(), roomEntity)
    ]);
    return roomEntity;
  }

  @override
  void addDeviceToRoomDiscoveredIfNotExist(DeviceEntityAbstract deviceEntity) {
    final RoomEntity? roomEntity = getRoomDeviceExistIn(deviceEntity);
    if (roomEntity != null) {
      return;
    }
    final String discoveredRoomId =
        RoomUniqueId.discoveredRoomId().getOrCrash();

    if (_allRooms[discoveredRoomId] == null) {
      _allRooms.addEntries([MapEntry(discoveredRoomId, RoomEntity.empty())]);
    }
    _allRooms[discoveredRoomId]!
        .addDeviceId(deviceEntity.uniqueId.getOrCrash());
  }

  @override
  void addSceneToRoomDiscoveredIfNotExist(SceneCbjEntity sceneCbjEntity) {
    final RoomEntity? roomEntity = getRoomSceneExistIn(sceneCbjEntity);
    if (roomEntity != null) {
      return;
    }
    final String discoveredRoomId =
        RoomUniqueId.discoveredRoomId().getOrCrash();

    if (_allRooms[discoveredRoomId] == null) {
      _allRooms.addEntries([MapEntry(discoveredRoomId, RoomEntity.empty())]);
    }
    _allRooms[discoveredRoomId]!
        .addSceneId(sceneCbjEntity.uniqueId.getOrCrash());
  }

  @override
  void addRoutineToRoomDiscoveredIfNotExist(RoutineCbjEntity routineCbjEntity) {
    final RoomEntity? roomEntity = getRoomRoutineExistIn(routineCbjEntity);
    if (roomEntity != null) {
      return;
    }
    final String discoveredRoomId =
        RoomUniqueId.discoveredRoomId().getOrCrash();

    if (_allRooms[discoveredRoomId] == null) {
      _allRooms.addEntries([MapEntry(discoveredRoomId, RoomEntity.empty())]);
    }
    _allRooms[discoveredRoomId]!
        .addRoutineId(routineCbjEntity.uniqueId.getOrCrash());
  }

  @override
  void addBindingToRoomDiscoveredIfNotExist(BindingCbjEntity bindingCbjEntity) {
    final RoomEntity? roomEntity = getRoomBindingExistIn(bindingCbjEntity);
    if (roomEntity != null) {
      return;
    }
    final String discoveredRoomId =
        RoomUniqueId.discoveredRoomId().getOrCrash();

    if (_allRooms[discoveredRoomId] == null) {
      _allRooms.addEntries([MapEntry(discoveredRoomId, RoomEntity.empty())]);
    }
    _allRooms[discoveredRoomId]!
        .addBindingId(bindingCbjEntity.uniqueId.getOrCrash());
  }

  @override
  Future<Either<LocalDbFailures, Unit>> saveAndActiveRoomToDb({
    required RoomEntity roomEntity,
  }) async {
    final String roomId = roomEntity.uniqueId.getOrCrash();

    await removeSameDevicesFromOtherRooms(roomEntity);

    if (_allRooms[roomId] == null) {
      _allRooms.addEntries([MapEntry(roomId, roomEntity)]);
    } else {
      final RoomEntity roomEntityCombinedDevices = roomEntity.copyWith(
        roomDevicesId: RoomDevicesId(
          combineNoDuplicateListOfString(
            _allRooms[roomId]!.roomDevicesId.getOrCrash(),
            roomEntity.roomDevicesId.getOrCrash(),
          ),
        ),
      );
      _allRooms[roomId] = roomEntityCombinedDevices;
    }
    await getIt<ISavedDevicesRepo>().saveAndActivateSmartDevicesToDb();
    return getIt<ILocalDbRepository>().saveRoomsToDb(
      roomsList: List<RoomEntity>.from(_allRooms.values),
    );
  }

  /// Remove all devices ID in our room from all other rooms to prevent
  /// duplicate
  Future<void> removeSameDevicesFromOtherRooms(RoomEntity roomEntity) async {
    final List<String> devicesIdInTheRoom =
        List.from(roomEntity.roomDevicesId.getOrCrash());
    if (devicesIdInTheRoom.isEmpty) {
      return;
    }

    for (final RoomEntity roomEntityTemp in _allRooms.values) {
      if (roomEntityTemp.roomDevicesId.failureOrUnit != right(unit)) {
        continue;
      }
      final List<String> roomIdesTempList =
          List.from(roomEntityTemp.roomDevicesId.getOrCrash());

      for (final String roomIdTemp in roomIdesTempList) {
        final int indexOfDeviceId = devicesIdInTheRoom.indexOf(roomIdTemp);

        /// If device id exist in other room than delete it from that room
        if (indexOfDeviceId != -1) {
          roomEntityTemp.copyWith(
            roomDevicesId: roomEntityTemp.deleteIdIfExist(roomIdTemp),
          );

          devicesIdInTheRoom.removeAt(indexOfDeviceId);
          if (devicesIdInTheRoom.isEmpty) {
            return;
          }
          continue;
        }
      }
    }
  }

  List<String> combineNoDuplicateListOfString(
    List<String> devicesId,
    List<String> newDevicesId,
  ) {
    final HashSet<String> hashSetDevicesId = HashSet<String>();
    hashSetDevicesId.addAll(devicesId);
    hashSetDevicesId.addAll(newDevicesId);
    return List.from(hashSetDevicesId);
  }
}
