import 'package:cbj_hub/domain/binding/binding_cbj_entity.dart';
import 'package:cbj_hub/domain/binding/value_objects_routine_cbj.dart';
import 'package:cbj_hub/domain/core/value_objects.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'binding_cbj_dtos.freezed.dart';
part 'binding_cbj_dtos.g.dart';

@freezed
abstract class BindingCbjDtos implements _$BindingCbjDtos {
  factory BindingCbjDtos({
    // @JsonKey(ignore: true)
    required String uniqueId,
    required String name,
    required String backgroundColor,
    required String? deviceStateGRPC,
    required String? senderDeviceOs,
    required String? senderDeviceModel,
    required String? senderId,
    required String? compUuid,
    required String? stateMassage,
    String? automationString,
    String? firstNodeId,
    String? iconCodePoint,
    String? image,
    String? lastDateOfExecute,
    // required ServerTimestampConverter() FieldValue serverTimeStamp,
  }) = _BindingCbjDtos;

  BindingCbjDtos._();

  factory BindingCbjDtos.fromDomain(BindingCbjEntity bindingCbj) {
    return BindingCbjDtos(
      uniqueId: bindingCbj.uniqueId.getOrCrash(),
      name: bindingCbj.name.getOrCrash(),
      backgroundColor: bindingCbj.backgroundColor.getOrCrash(),
      automationString: bindingCbj.automationString.getOrCrash(),
      firstNodeId: bindingCbj.firstNodeId.getOrCrash(),
      iconCodePoint: bindingCbj.iconCodePoint.getOrCrash(),
      image: bindingCbj.image.getOrCrash(),
      lastDateOfExecute: bindingCbj.lastDateOfExecute.getOrCrash(),
      deviceStateGRPC: bindingCbj.deviceStateGRPC.getOrCrash(),
      senderDeviceModel: bindingCbj.senderDeviceModel.getOrCrash(),
      senderDeviceOs: bindingCbj.senderDeviceOs.getOrCrash(),
      senderId: bindingCbj.senderId.getOrCrash(),
      compUuid: bindingCbj.compUuid.getOrCrash(),
      stateMassage: bindingCbj.stateMassage.getOrCrash(),
      // serverTimeStamp: FieldValue.serverTimestamp(),
    );
  }

  factory BindingCbjDtos.fromJson(Map<String, dynamic> json) =>
      _$BindingCbjDtosFromJson(json);

  final String deviceDtoClassInstance = (BindingCbjDtos).toString();

  BindingCbjEntity toDomain() {
    return BindingCbjEntity(
      uniqueId: UniqueId.fromUniqueString(uniqueId),
      name: BindingCbjName(name),
      backgroundColor: BindingCbjBackgroundColor(backgroundColor),
      automationString: BindingCbjAutomationString(automationString),
      firstNodeId: BindingCbjFirstNodeId(firstNodeId),
      iconCodePoint: BindingCbjIconCodePoint(iconCodePoint),
      image: BindingCbjBackgroundImage(image),
      lastDateOfExecute: BindingCbjLastDateOfExecute(lastDateOfExecute),
      deviceStateGRPC: BindingCbjDeviceStateGRPC(deviceStateGRPC),
      senderDeviceModel: BindingCbjSenderDeviceModel(senderDeviceModel),
      senderDeviceOs: BindingCbjSenderDeviceOs(senderDeviceOs),
      senderId: BindingCbjSenderId(senderId),
      compUuid: BindingCbjCompUuid(compUuid),
      stateMassage: BindingCbjStateMassage(stateMassage),
    );
  }
}
