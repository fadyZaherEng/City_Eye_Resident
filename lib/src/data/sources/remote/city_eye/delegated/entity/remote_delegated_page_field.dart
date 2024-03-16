import 'package:city_eye/src/data/sources/remote/city_eye/qr/entity/remote_validation.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/entity/remote_choice.dart';
import 'package:city_eye/src/domain/entities/settings/page_field.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_delegated_page_field.g.dart';

@JsonSerializable()
class RemoteDelegatedPageField {
  final int? id;
  final int? controlTypeId;
  final String? controlTypeCode;
  final String? lable;
  final bool? isRequired;
  final String? value;
  final String? answerId;
  final String? description;
  final List<RemoteChoice>? choice;
  @JsonKey(name: 'formControlsValidation')
  final List<RemoteValidation>? validations;

  const RemoteDelegatedPageField({
    this.id = 0,
    this.controlTypeId = 0,
    this.controlTypeCode = "",
    this.lable = "",
    this.isRequired = false,
    this.value = "",
    this.answerId = "",
    this.description = "",
    this.choice = const [],
    this.validations = const [],
  });

  factory RemoteDelegatedPageField.fromJson(Map<String, dynamic> json) =>
      _$RemoteDelegatedPageFieldFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteDelegatedPageFieldToJson(this);
}

extension RemoteDelegatedPageFieldExtension on RemoteDelegatedPageField {
  PageField mapToDomain() {
    return PageField(
      id: id ?? 0,
      typeId: controlTypeId ?? 0,
      code: controlTypeCode ?? "",
      label: lable ?? "",
      isRequired: isRequired ?? false,
      value: value ?? "",
      answerId: answerId ?? "",
      choices: (choice ?? []).mapToDomain(),
      errorMessage: "",
      fileValid: true,
      imagesList: [],
      key: GlobalKey(),
      notAnswered: false,
      description: description ?? "",
      validations: (validations ?? []).mapToDomain(),
    );
  }
}

extension RemoteDelegatedPageFieldListExtension
    on List<RemoteDelegatedPageField>? {
  List<PageField> mapToDomain() {
    return this?.map((e) => e.mapToDomain()).toList() ?? [];
  }
}
