import 'dart:async';

import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/generic_smart_tv/generic_smart_tv_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_smart_tv/generic_smart_tv_value_objects.dart';
import 'package:cbj_hub/domain/mqtt_server/i_mqtt_server_repository.dart';
import 'package:cbj_hub/infrastructure/devices/google/chromecast_api_node_red/chromecast_api_node_red.dart';
import 'package:cbj_hub/infrastructure/devices/google/google_device_value_objects.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/injection.dart';
import 'package:cbj_hub/utils.dart';
import 'package:dartz/dartz.dart';

class ChromeCastEntity extends GenericSmartTvDE {
  ChromeCastEntity({
    required super.uniqueId,
    required super.vendorUniqueId,
    required super.defaultName,
    required super.deviceStateGRPC,
    required super.stateMassage,
    required super.senderDeviceOs,
    required super.senderDeviceModel,
    required super.senderId,
    required super.compUuid,
    required super.powerConsumption,
    required super.smartTvSwitchState,
    required this.googlePort,
    super.openUrl,
    super.pausePlayState,
    super.skip,
    super.volume,
    this.deviceMdnsName,
    this.lastKnownIp,
  }) : super(
          deviceVendor: DeviceVendor(VendorsAndServices.google.toString()),
        ) {
    setUpNodeRedApi();
  }

  /// Google communication port 8009 for chromecast
  GooglePort? googlePort;

  DeviceLastKnownIp? lastKnownIp;

  DeviceMdnsName? deviceMdnsName;

  late ChromecastApiNodeRed chromecastApiNodeRed;

  void setUpNodeRedApi() async {
    // TODO: add check to add  uniqueId + action as flow in node read only if missing
    chromecastApiNodeRed = ChromecastApiNodeRed();
    chromecastApiNodeRed.setNewYoutubeVideoNodes(
      uniqueId.getOrCrash(),
      lastKnownIp!.getOrCrash(),
    );
  }

  /// Please override the following methods
  @override
  Future<Either<CoreFailure, Unit>> executeDeviceAction({
    required DeviceEntityAbstract newEntity,
  }) async {
    if (newEntity is! GenericSmartTvDE) {
      return left(
        const CoreFailure.actionExcecuter(
          failedValue: 'Not the correct type',
        ),
      );
    }

    try {
      if (newEntity.openUrl?.getOrCrash() != null &&
          (newEntity.openUrl?.getOrCrash() != openUrl?.getOrCrash() &&
              newEntity.deviceStateGRPC.getOrCrash() !=
                  DeviceStateGRPC.ack.toString())) {
        (await sendUrlToDevice(newEntity.openUrl!.getOrCrash())).fold((l) {
          logger.e('Error opening url on ChromeCast');
          throw l;
        }, (r) {
          logger.i('ChromeCast opening url success');
        });
      }

      if (newEntity.pausePlayState?.getOrCrash() != null &&
          (newEntity.pausePlayState?.getOrCrash() !=
                  pausePlayState?.getOrCrash() &&
              newEntity.deviceStateGRPC.getOrCrash() !=
                  DeviceStateGRPC.ack.toString())) {
        (await togglePausePlay(newEntity.pausePlayState!.getOrCrash())).fold(
            (l) {
          logger.e('Error toggle pause or play on ChromeCast');
          throw l;
        }, (r) {
          logger.i('ChromeCast toggle pause or play success');
        });
      }

      deviceStateGRPC = DeviceState(DeviceStateGRPC.ack.toString());
      // getIt<IMqttServerRepository>().postSmartDeviceToAppMqtt(
      //   entityFromTheHub: this,
      // );
      return right(unit);
    } catch (e) {
      deviceStateGRPC = DeviceState(DeviceStateGRPC.newStateFailed.toString());
      // getIt<IMqttServerRepository>().postSmartDeviceToAppMqtt(
      //   entityFromTheHub: this,
      // );

      return left(const CoreFailure.unexpected());
    }
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOnSmartTv() async {
    try {} catch (e) {
      return left(const CoreFailure.unexpected());
    }
    return left(const CoreFailure.unexpected());
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOffSmartTv() async {
    try {} catch (e) {
      return left(const CoreFailure.unexpected());
    }
    return left(const CoreFailure.unexpected());
  }

  @override
  Future<Either<CoreFailure, Unit>> sendUrlToDevice(String newUrl) async {
    try {
      openUrl = GenericSmartTvOpenUrl(newUrl);
      final String nodeRedApiBaseTopic =
          getIt<IMqttServerRepository>().getNodeRedApiBaseTopic();

      final String nodeRedDevicesTopic =
          getIt<IMqttServerRepository>().getNodeRedDevicesTopicTypeName();

      final String topic =
          '$nodeRedApiBaseTopic/$nodeRedDevicesTopic/${uniqueId.getOrCrash()}/${chromecastApiNodeRed.youtubeVideoTopicProperty}/${chromecastApiNodeRed.playingVideoTopicProperty}';

      String validYoutubeVidId = openUrl!.getOrCrash();
      if (validYoutubeVidId.contains('?v=')) {
        validYoutubeVidId =
            validYoutubeVidId.substring(validYoutubeVidId.indexOf('?v=') + 3);
      }
      if (validYoutubeVidId.contains('&index=')) {
        final int valueOfAndIndexEqual = validYoutubeVidId.indexOf('&index=');
        validYoutubeVidId = validYoutubeVidId.substring(
          0,
          valueOfAndIndexEqual,
        );
      }
      if (validYoutubeVidId.contains('&list=')) {
        final int valueOfAndIndexEqual = validYoutubeVidId.indexOf('&list=');
        validYoutubeVidId = validYoutubeVidId.substring(
          0,
          valueOfAndIndexEqual,
        );
      }
      getIt<IMqttServerRepository>().publishMessage(topic, validYoutubeVidId);
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
    return right(unit);
  }

  @override
  Future<Either<CoreFailure, Unit>> togglePausePlay(
    String toggleNewState,
  ) async {
    if (toggleNewState == DeviceActions.pause.toString()) {
      return togglePause();
    } else if (toggleNewState == DeviceActions.play.toString()) {
      return togglePlay();
    } else if (toggleNewState == DeviceActions.stop.toString()) {
      return toggleStop();
    } else if (toggleNewState == DeviceActions.skipPreviousVid.toString()) {
      return queuePrev();
    } else if (toggleNewState == DeviceActions.skipNextVid.toString()) {
      return queueNext();
    } else if (toggleNewState == DeviceActions.close.toString()) {
      return closeApp();
    }
    return left(const CoreFailure.unexpected());
  }

  @override
  Future<Either<CoreFailure, Unit>> togglePause() async {
    try {
      pausePlayState =
          GenericSmartTvPausePlayState(DeviceActions.pause.toString());

      final String nodeRedApiBaseTopic =
          getIt<IMqttServerRepository>().getNodeRedApiBaseTopic();

      final String nodeRedDevicesTopic =
          getIt<IMqttServerRepository>().getNodeRedDevicesTopicTypeName();

      final String topic =
          '$nodeRedApiBaseTopic/$nodeRedDevicesTopic/${uniqueId.getOrCrash()}/${chromecastApiNodeRed.youtubeVideoTopicProperty}/${chromecastApiNodeRed.pauseVideoTopicProperty}';

      getIt<IMqttServerRepository>()
          .publishMessage(topic, 'Media Command Pause');
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
    return right(unit);
  }

  @override
  Future<Either<CoreFailure, Unit>> togglePlay() async {
    try {
      pausePlayState =
          GenericSmartTvPausePlayState(DeviceActions.play.toString());

      final String nodeRedApiBaseTopic =
          getIt<IMqttServerRepository>().getNodeRedApiBaseTopic();

      final String nodeRedDevicesTopic =
          getIt<IMqttServerRepository>().getNodeRedDevicesTopicTypeName();

      final String topic =
          '$nodeRedApiBaseTopic/$nodeRedDevicesTopic/${uniqueId.getOrCrash()}/${chromecastApiNodeRed.youtubeVideoTopicProperty}/${chromecastApiNodeRed.playVideoTopicProperty}';

      getIt<IMqttServerRepository>()
          .publishMessage(topic, 'Media Command Play');
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
    return right(unit);
  }

  @override
  Future<Either<CoreFailure, Unit>> toggleStop() async {
    try {
      pausePlayState =
          GenericSmartTvPausePlayState(DeviceActions.stop.toString());

      final String nodeRedApiBaseTopic =
          getIt<IMqttServerRepository>().getNodeRedApiBaseTopic();

      final String nodeRedDevicesTopic =
          getIt<IMqttServerRepository>().getNodeRedDevicesTopicTypeName();

      final String topic =
          '$nodeRedApiBaseTopic/$nodeRedDevicesTopic/${uniqueId.getOrCrash()}/${chromecastApiNodeRed.youtubeVideoTopicProperty}/${chromecastApiNodeRed.stopVideoTopicProperty}';

      getIt<IMqttServerRepository>()
          .publishMessage(topic, 'Media Command Stop');
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
    return right(unit);
  }

  @override
  Future<Either<CoreFailure, Unit>> queuePrev() async {
    try {
      pausePlayState = GenericSmartTvPausePlayState(
        DeviceActions.skipPreviousVid.toString(),
      );

      final String nodeRedApiBaseTopic =
          getIt<IMqttServerRepository>().getNodeRedApiBaseTopic();

      final String nodeRedDevicesTopic =
          getIt<IMqttServerRepository>().getNodeRedDevicesTopicTypeName();

      final String topic =
          '$nodeRedApiBaseTopic/$nodeRedDevicesTopic/${uniqueId.getOrCrash()}/${chromecastApiNodeRed.youtubeVideoTopicProperty}/${chromecastApiNodeRed.queuePrevVideoTopicProperty}';

      getIt<IMqttServerRepository>()
          .publishMessage(topic, 'Media Command Prev Queue');
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
    return right(unit);
  }

  @override
  Future<Either<CoreFailure, Unit>> queueNext() async {
    try {
      pausePlayState =
          GenericSmartTvPausePlayState(DeviceActions.skipNextVid.toString());

      final String nodeRedApiBaseTopic =
          getIt<IMqttServerRepository>().getNodeRedApiBaseTopic();

      final String nodeRedDevicesTopic =
          getIt<IMqttServerRepository>().getNodeRedDevicesTopicTypeName();

      final String topic =
          '$nodeRedApiBaseTopic/$nodeRedDevicesTopic/${uniqueId.getOrCrash()}/${chromecastApiNodeRed.youtubeVideoTopicProperty}/${chromecastApiNodeRed.queueNextVideoTopicProperty}';

      getIt<IMqttServerRepository>()
          .publishMessage(topic, 'Media Command Next Queue');
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
    return right(unit);
  }

  @override
  Future<Either<CoreFailure, Unit>> closeApp() async {
    try {
      pausePlayState =
          GenericSmartTvPausePlayState(DeviceActions.close.toString());

      final String nodeRedApiBaseTopic =
          getIt<IMqttServerRepository>().getNodeRedApiBaseTopic();

      final String nodeRedDevicesTopic =
          getIt<IMqttServerRepository>().getNodeRedDevicesTopicTypeName();

      final String topic =
          '$nodeRedApiBaseTopic/$nodeRedDevicesTopic/${uniqueId.getOrCrash()}/${chromecastApiNodeRed.youtubeVideoTopicProperty}/${chromecastApiNodeRed.closeAppTopicProperty}';

      getIt<IMqttServerRepository>()
          .publishMessage(topic, 'Media Command Next Queue');
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
    return right(unit);
  }
}
