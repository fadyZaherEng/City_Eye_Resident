import 'package:city_eye/src/data/sources/remote/city_eye/qr/entity/remote_validation.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/entity/remote_choice.dart';
import 'package:city_eye/src/domain/entities/settings/page_field.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_qr_question.g.dart';

@JsonSerializable()
class RemoteQrQuestion {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'controlTypeId')
  final int? controlTypeId;
  @JsonKey(name: 'maxCount')
  final int? maxCount;
  @JsonKey(name: 'minCount')
  final int? minCount;
  @JsonKey(name: 'controlTypeCode')
  final String? controlTypeCode;
  @JsonKey(name: 'lable')
  final String? lable;
  @JsonKey(name: 'isRequired')
  final bool? isRequired;
  @JsonKey(name: 'value')
  final String? value;
  @JsonKey(name: 'answerId')
  final String? answerId;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'choice')
  final List<RemoteChoice>? choice;
  @JsonKey(name: 'formControlsValidation')
  final List<RemoteValidation>? validations;

  RemoteQrQuestion({
    this.id = 0,
    this.controlTypeId = 0,
    this.maxCount = 0,
    this.minCount = 0,
    this.controlTypeCode = "",
    this.lable = "",
    this.isRequired = false,
    this.value = "",
    this.answerId = "",
    this.description = "",
    this.choice = const [],
    this.validations = const [],
  });

  factory RemoteQrQuestion.fromJson(Map<String, dynamic> json) =>
      _$RemoteQrQuestionFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteQrQuestionToJson(this);
}

extension RemoteQrQuestionExtension on RemoteQrQuestion {
  PageField mapToDomain() {
    return PageField(
      id: id ?? 0,
      typeId: controlTypeId ?? 0,
      maxCount: maxCount ?? 0,
      minCount: minCount ?? 0,
      code: controlTypeCode ?? "",
      label: lable ?? "",
      isRequired: isRequired ?? false,
      value: value ?? "",
      answerId: answerId ?? "",
      description: description ?? "",
      choices: (choice ?? []).mapToDomain(),
      validations: (validations ?? []).mapToDomain(),
    );
  }
}

extension RemoteQrQuestionListExtension on List<RemoteQrQuestion> {
  List<PageField> mapToDomain() {
    return map((e) => e.mapToDomain()).toList();
  }
}
