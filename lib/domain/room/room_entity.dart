import 'package:cbj_hub/domain/room/room_failures.dart';
import 'package:cbj_hub/domain/room/value_objects_room.dart';
import 'package:cbj_hub/infrastructure/room/room_entity_dtos.dart';
import 'package:cbj_hub/utils.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'room_entity.freezed.dart';

@freezed
abstract class RoomEntity implements _$RoomEntity {
  const factory RoomEntity({
    required RoomUniqueId uniqueId,
    required RoomDefaultName defaultName,
    required RoomBackground background,
    required RoomTypes roomTypes,
    required RoomDevicesId roomDevicesId,
    required RoomScenesId roomScenesId,
    required RoomRoutinesId roomRoutinesId,
    required RoomBindingsId roomBindingsId,

    /// Who is using this room
    required RoomMostUsedBy roomMostUsedBy,

    /// Room permissions by users id
    required RoomPermissions roomPermissions,
  }) = _RoomEntity;

  const RoomEntity._();

  factory RoomEntity.empty() => RoomEntity(
        uniqueId: RoomUniqueId(),
        defaultName: RoomDefaultName(''),
        background: RoomBackground(
          'https://live.staticflickr.com/5220/5486044345_f67abff3e9_h.jpg',
        ),
        roomDevicesId: RoomDevicesId([]), // Do not add const
        roomScenesId: RoomScenesId([]), // Do not add const
        roomRoutinesId: RoomRoutinesId([]), // Do not add const
        roomBindingsId: RoomBindingsId([]), // Do not add const
        roomMostUsedBy: RoomMostUsedBy([]), // Do not add const
        roomPermissions: RoomPermissions([]), // Do not add const
        roomTypes: RoomTypes([]), // Do not add const
      );

  /// Will add new device id to the devices in the room list
  void addDeviceId(String newDeviceId) {
    /// Will not work if list got created with const
    try {
      roomDevicesId.getOrCrash().add(newDeviceId);
    } catch (e) {
      logger.e('Will not work if list got created with const');
    }
  }

  /// Will add new scene id to the scenes in the room list
  void addSceneId(String newSceneId) {
    /// Will not work if list got created with const
    try {
      roomScenesId.getOrCrash().add(newSceneId);
    } catch (e) {
      logger.e('Will not work if list got created with const');
    }
  }

  /// Will add new routine id to the scenes in the room list
  void addRoutineId(String newSceneId) {
    /// Will not work if list got created with const
    try {
      roomRoutinesId.getOrCrash().add(newSceneId);
    } catch (e) {
      logger.e('Will not work if list got created with const');
    }
  }

  /// Will add new Binding id to the scenes in the room list
  void addBindingId(String newSceneId) {
    /// Will not work if list got created with const
    try {
      roomBindingsId.getOrCrash().add(newSceneId);
    } catch (e) {
      logger.e('Will not work if list got created with const');
    }
  }

  /// Return new RoomDevicesId object without id if it exist in roomDevicesId
  RoomDevicesId deleteIdIfExist(String id) {
    final List<String> tempList = List.from(roomDevicesId.getOrCrash());
    tempList.removeWhere((element) => element == id);

    return RoomDevicesId(tempList);
  }

  Option<RoomFailure<dynamic>> get failureOption {
    return defaultName.value.fold((f) => some(f), (_) => none());
  }

  RoomEntityDtos toInfrastructure() {
    return RoomEntityDtos(
      uniqueId: uniqueId.getOrCrash(),
      defaultName: defaultName.getOrCrash(),
      background: background.getOrCrash(),
      roomTypes: roomTypes.getOrCrash(),
      roomDevicesId: roomDevicesId.getOrCrash(),
      roomScenesId: roomScenesId.getOrCrash(),
      roomRoutinesId: roomRoutinesId.getOrCrash(),
      roomBindingsId: roomBindingsId.getOrCrash(),
      roomMostUsedBy: roomMostUsedBy.getOrCrash(),
      roomPermissions: roomPermissions.getOrCrash(),
    );
  }
}
