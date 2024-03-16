import 'package:city_eye/src/data/sources/remote/city_eye/settings/entity/remote_choice.dart';
import 'package:city_eye/src/domain/entities/qr_history/unit_qr_question_answer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_unit_qr_question_answer.g.dart';

@JsonSerializable(explicitToJson: true)
final class RemoteUnitQrQuestionAnswer {
  final int? id;
  final int? controlTypeId;
  final String? controlTypeCode;
  final String? lable;
  final bool? isRequired;
  final String? value;
  final String? answerId;
  final String? description;
  final List<RemoteChoice>? choice;

  const RemoteUnitQrQuestionAnswer({
    this.id = 0,
    this.controlTypeId = 0,
    this.controlTypeCode = "",
    this.lable = "",
    this.isRequired = false,
    this.value = "",
    this.answerId = "",
    this.description = "",
    this.choice = const [],
  });

  factory RemoteUnitQrQuestionAnswer.fromJson(Map<String, dynamic> json) =>
      _$RemoteUnitQrQuestionAnswerFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteUnitQrQuestionAnswerToJson(this);
}

extension RemoteUnitQrQuestionAnswerExtension on RemoteUnitQrQuestionAnswer {
  UnitQrQuestionAnswer mapToDomain() => UnitQrQuestionAnswer(
        id: id ?? 0,
        controlTypeId: controlTypeId ?? 0,
        controlTypeCode: controlTypeCode ?? "",
        lable: lable ?? "",
        isRequired: isRequired ?? false,
        value: value ?? "",
        answerId: answerId ?? "",
        description: description ?? "",
        choice: choice.mapToDomain(),
      );
}

extension ListRemoteUnitQrQuestionAnswerExtension
    on List<RemoteUnitQrQuestionAnswer>? {
  List<UnitQrQuestionAnswer> mapToDomain() {
    return this?.map((e) => e.mapToDomain()).toList() ?? [];
  }
}
