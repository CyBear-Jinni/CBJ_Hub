import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/local_db/local_db_failures.dart';
import 'package:cbj_hub/domain/matirial_colors/colors.dart';
import 'package:cbj_hub/domain/saved_devices/i_saved_devices_repo.dart';
import 'package:cbj_hub/domain/scene/scene_cbj_failures.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/infrastructure/scenes/area_types_scientific_presets/actions_for_area_types/bed_room_area_actions.dart';
import 'package:cbj_hub/infrastructure/scenes/area_types_scientific_presets/actions_for_area_types/outside_area_actions.dart';
import 'package:cbj_hub/infrastructure/scenes/area_types_scientific_presets/actions_for_area_types/study_room_area_actions.dart';
import 'package:cbj_hub/infrastructure/scenes/area_types_scientific_presets/actions_for_area_types/video_games_area_actions.dart';
import 'package:cbj_hub/infrastructure/scenes/area_types_scientific_presets/actions_for_area_types/work_room_area_actions.dart';
import 'package:cbj_hub/injection.dart';
import 'package:dartz/dartz.dart';

/// Pre define actions for each device in each area type
class AreaTypeWithDeviceTypePreset {
  static Future<Either<SceneCbjFailure, Map<String, String>>>
      getPreDefineActionForDeviceInArea({
    required String deviceId,
    required AreaPurposesTypes areaPurposeType,
    required String brokerNodeId,
  }) async {
    final Either<LocalDbFailures, DeviceEntityAbstract> dTemp =
        await getIt<ISavedDevicesRepo>().getDeviceById(deviceId);
    if (dTemp.isLeft()) {
      return left(const SceneCbjFailure.unexpected());
    }
    late DeviceEntityAbstract deviceEntity;

    dTemp.fold((l) => null, (r) {
      deviceEntity = r;
    });

    switch (areaPurposeType) {
      case AreaPurposesTypes.attic:
        // TODO: Handle this case.
        break;
      case AreaPurposesTypes.bathtub:
        // TODO: Handle this case.
        break;
      case AreaPurposesTypes.bedroom:
        return BedRoomAreaAction()
            .bedRoomSleepDeviceAction(deviceEntity, brokerNodeId);
      case AreaPurposesTypes.boardGames:
        // TODO: Handle this case.
        break;
      case AreaPurposesTypes.childrenRoom:
        // TODO: Handle this case.
        break;
      case AreaPurposesTypes.cinemaRoom:
        // TODO: Handle this case.
        break;
      case AreaPurposesTypes.diningRoom:
        // TODO: Handle this case.
        break;
      case AreaPurposesTypes.holidayCabin:
        // TODO: Handle this case.
        break;
      case AreaPurposesTypes.kitchen:
        // TODO: Handle this case.
        break;
      case AreaPurposesTypes.laundryRoom:
        // TODO: Handle this case.
        break;
      case AreaPurposesTypes.livingRoom:
        // TODO: Handle this case.
        break;
      case AreaPurposesTypes.meditation:
        // TODO: Handle this case.
        break;
      case AreaPurposesTypes.outside:
        return OutsideAreaAction()
            .outsideOffDeviceAction(deviceEntity, brokerNodeId);
      case AreaPurposesTypes.outsideNotPrimary:
        // TODO: Handle this case.
        break;
      case AreaPurposesTypes.outsidePrimary:
        // TODO: Handle this case.
        break;
      case AreaPurposesTypes.protectedSpace:
        // TODO: Handle this case.
        break;
      case AreaPurposesTypes.romantic:
        // TODO: Handle this case.
        break;
      case AreaPurposesTypes.safeRoom:
        // TODO: Handle this case.
        break;
      case AreaPurposesTypes.shower:
        // TODO: Handle this case.
        break;
      case AreaPurposesTypes.stairsInside:
        // TODO: Handle this case.
        break;
      case AreaPurposesTypes.stairsOutside:
        // TODO: Handle this case.
        break;
      case AreaPurposesTypes.studyRoom:
        return StudyRoomAreaAction()
            .studyRoomDeviceAction(deviceEntity, brokerNodeId);
      case AreaPurposesTypes.toiletRoom:
        // TODO: Handle this case.
        break;
      case AreaPurposesTypes.trainingRoom:
        // TODO: Handle this case.
        break;
      case AreaPurposesTypes.tvRoom:
        // TODO: Handle this case.
        break;
      case AreaPurposesTypes.videoGames:
        return VideoGamesAreaAction()
            .videoGamesRgbModDeviceAction(deviceEntity, brokerNodeId);
      case AreaPurposesTypes.workRoom:
        return WorkRoomAreaAction()
            .workRoomDeviceAction(deviceEntity, brokerNodeId);
    }
    return left(const SceneCbjFailure.unexpected());
  }

  static String getColorForAreaType(AreaPurposesTypes areaPurposeType) {
    Colors color = Colors.orange;

    switch (areaPurposeType) {
      case AreaPurposesTypes.attic:
        color = Colors.amberAccent;
        break;
      case AreaPurposesTypes.bathtub:
        color = Colors.lightBlue;
        break;
      case AreaPurposesTypes.bedroom:
        color = Colors.cyan;
        break;
      case AreaPurposesTypes.boardGames:
        color = Colors.brown;
        break;
      case AreaPurposesTypes.childrenRoom:
        color = Colors.lightBlueAccent;
        break;
      case AreaPurposesTypes.cinemaRoom:
        color = Colors.pink;
        break;
      case AreaPurposesTypes.diningRoom:
        color = Colors.amber;
        break;
      case AreaPurposesTypes.holidayCabin:
        color = Colors.lightGreen;
        break;
      case AreaPurposesTypes.kitchen:
        color = Colors.redAccent;
        break;
      case AreaPurposesTypes.laundryRoom:
        color = Colors.white12;
        break;
      case AreaPurposesTypes.livingRoom:
        color = Colors.orangeAccent;
        break;
      case AreaPurposesTypes.meditation:
        color = Colors.purple;
        break;
      case AreaPurposesTypes.outside:
        color = Colors.green;
        break;
      case AreaPurposesTypes.outsideNotPrimary:
        color = Colors.greenAccent;
        break;
      case AreaPurposesTypes.outsidePrimary:
        color = Colors.lightGreenAccent;
        break;
      case AreaPurposesTypes.protectedSpace:
        color = Colors.blueGrey;
        break;
      case AreaPurposesTypes.romantic:
        color = Colors.pinkAccent;
        break;
      case AreaPurposesTypes.safeRoom:
        color = Colors.indigo;
        break;
      case AreaPurposesTypes.shower:
        color = Colors.blueAccent;
        break;
      case AreaPurposesTypes.stairsInside:
        color = Colors.brown;
        break;
      case AreaPurposesTypes.stairsOutside:
        color = Colors.brown;
        break;
      case AreaPurposesTypes.studyRoom:
        color = Colors.deepPurpleAccent;
        break;
      case AreaPurposesTypes.toiletRoom:
        color = Colors.green;
        break;
      case AreaPurposesTypes.trainingRoom:
        color = Colors.redAccent;
        break;
      case AreaPurposesTypes.tvRoom:
        color = Colors.deepPurple;
        break;
      case AreaPurposesTypes.videoGames:
        color = Colors.tealAccent;
        break;
      case AreaPurposesTypes.workRoom:
        color = Colors.blue;
        break;
    }
    return color.value;
  }
}
