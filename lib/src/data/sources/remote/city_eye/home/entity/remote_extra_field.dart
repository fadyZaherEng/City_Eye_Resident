import 'package:city_eye/src/data/sources/remote/city_eye/qr/entity/remote_validation.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/entity/remote_choice.dart';
import 'package:city_eye/src/domain/entities/settings/page_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_extra_field.g.dart';

@JsonSerializable()
class RemoteExtraField {
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
  @JsonKey(name: 'eventsOptionQuestionValidations')
  final List<RemoteValidation>? validations;
  @JsonKey(name: 'eventOptionId')
  final int? eventOptionId;

  RemoteExtraField({
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
    this.eventOptionId = 0,
  });

  factory RemoteExtraField.fromJson(Map<String, dynamic> json) =>
      _$RemoteExtraFieldFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteExtraFieldToJson(this);
}

extension RemoteExtraFieldExtension on RemoteExtraField {
  PageField mapToDomain() {
    return PageField(
      id: id ?? 0,
      typeId: controlTypeId ?? 0,
      eventOptionId: eventOptionId ?? 0,
      maxCount: maxCount??0,
      minCount: minCount??0,
      code: controlTypeCode ?? "",
      label: lable ?? "",
      isRequired: isRequired ?? false,
      value: value ?? "",
      answerId: answerId ?? "",
      choices: (choice ?? []).mapToDomain(),
      validations:  [],
      description: description ?? "",
      errorMessage: "",
      fileValid: true,
      imagesList: [],
      key: GlobalKey(),
      canNotDeleteReason:  "",
      canNotEditReason: "",
      expireDate:  "",
      index: 0,
      isDeletable: false,
      isEditable:  false,
      notAnswered: false,
    );
  }
}

extension RemoteEventListExtension on List<RemoteExtraField>? {
  List<PageField> get mapToDomain =>
      this!.map((event) => event.mapToDomain()).toList();
}
