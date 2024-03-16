import 'package:city_eye/src/data/sources/remote/city_eye/settings/entity/remote_choice.dart';
import 'package:city_eye/src/domain/entities/settings/page_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_page_field.g.dart';

@JsonSerializable()
class RemotePageField {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'controlTypeId')
  final int? controlTypeId;
  @JsonKey(name: 'maxCount')
  final int? maxCount;
  @JsonKey(name: 'minCount')
  final int? minCount;
  @JsonKey(name: 'description')
  final String? description;
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
  @JsonKey(name: 'choice')
  final List<RemoteChoice>? choice;
  @JsonKey(name: 'expireDate')
  final String? expireDate;
  @JsonKey(name: 'isEditable')
  final bool? isEditable;
  @JsonKey(name: 'isDeletable')
  final bool? isDeletable;
  @JsonKey(name: 'canNotDeleteReason')
  final String? canNotDeleteReason;
  @JsonKey(name: 'canNotEditReason')
  final String? canNotEditReason;


  const RemotePageField({
    this.id = 0,
    this.controlTypeId = 0,
    this.maxCount = 0,
    this.minCount = 0,
    this.description = "",
    this.controlTypeCode = "",
    this.lable = "",
    this.isRequired = false,
    this.value = "",
    this.answerId = "",
    this.choice = const [],
    this.expireDate = "",
    this.isEditable = false,
    this.isDeletable = false,
    this.canNotDeleteReason = "",
    this.canNotEditReason = "",
  });

  factory RemotePageField.fromJson(Map<String, dynamic> json) =>
      _$RemotePageFieldFromJson(json);

  Map<String, dynamic> toJson() => _$RemotePageFieldToJson(this);
}

extension RemotePageFieldExtension on RemotePageField {
  PageField mapToDomain() {
    return PageField(
      id: id ?? 0,
      typeId: controlTypeId ?? 0,
      maxCount: maxCount ?? 0,
      minCount: minCount ?? 0,
      description: description ?? "",
      code: controlTypeCode ?? "",
      label: lable ?? "",
      isRequired:  isRequired ?? false,
      value: value ?? "",
      answerId: answerId ?? "",
      choices: (choice ?? []).mapToDomain(),
      errorMessage: "",
      fileValid: true,
      imagesList: [],
      key: GlobalKey(),
      canNotDeleteReason: canNotDeleteReason ?? "",
      canNotEditReason: canNotEditReason ?? "",
      expireDate: expireDate ?? "",
      index: 0,
      isDeletable: isDeletable ?? false,
      isEditable: isEditable ?? false,
      notAnswered: false,
    );
  }
}

extension RemotePageFieldsExtension on List<RemotePageField>? {
  List<PageField> mapToDomain() {
    return this?.map((e) => e.mapToDomain()).toList() ?? [];
  }
}


// extension RemotePageFieldDynamiExtension on RemotePageField {
//   Question mapToDynamicQuestion() {
//     return Question(
//       questionId: id ?? 0,
//       questionTitle: lable ?? "",
//       questionCode: controlTypeCode ?? "",
//       questionTypeId: controlTypeId ?? 0,
//       isMandatory: isRequired ?? false,
//       notAnswered: false,
//       key: GlobalKey(),
//       label: lable ?? "",
//       radioButtonAnswerList:(choice ?? []).mapToQrRadioButtonAnswers(id ?? 0),
//       isHasRelatedQuestion: false,
//       isRelated: false,
//       relatedAnswerID: 0,
//       relatedQuestionId: 0,
//       viewObject: null,
//       answer: null,
//     );
//   }
// }
//
//
// extension RemotePageFieldsDynamiExtension on List<RemotePageField>? {
//   List<Question> mapToDynamicQuestions() {
//     return this?.map((e) => e.mapToDynamicQuestion()).toList() ?? [];
//
//   }
// }
