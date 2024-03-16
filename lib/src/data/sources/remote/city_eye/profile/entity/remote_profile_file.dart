import 'package:city_eye/src/domain/entities/profile/profile_file.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_profile_file.g.dart';

@JsonSerializable()
class RemoteProfileFile {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'controlTypeId')
  final int? controlTypeId;
  @JsonKey(name: 'controlTypeCode')
  final String? controlTypeCode;
  @JsonKey(name: 'lable')
  final String? lable;
  @JsonKey(name: 'isRequired')
  final bool? isRequired;
  @JsonKey(name: 'value')
  final String? value;
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
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'maxCount')
  final int? maxCount;
  @JsonKey(name: 'minCount')
  final int? minCount;

  const RemoteProfileFile({
    this.id = 0,
    this.controlTypeId = 0,
    this.controlTypeCode = "",
    this.lable = "",
    this.isRequired = false,
    this.value = "",
    this.expireDate = "",
    this.isEditable = false,
    this.isDeletable = false,
    this.canNotDeleteReason = "",
    this.canNotEditReason = "",
    this.description = "",
    this.maxCount = 0,
    this.minCount = 0,
  });

  factory RemoteProfileFile.fromJson(Map<String, dynamic> json) =>
      _$RemoteProfileFileFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteProfileFileToJson(this);
}


//write extension function to map RemoteProfileFile to ProfileFile
extension RemoteProfileFileExtension on RemoteProfileFile {
  ProfileFile mapToDomain() {
    return ProfileFile(
      id: id ?? 0,
      typeId: controlTypeId ?? 0,
      code: controlTypeCode ?? "",
      name: lable ?? "",
      isMandatory: isRequired ?? false,
      value: value ?? "",
      expireDate: expireDate ?? "",
      isEditable: isEditable ?? false,
      isDeletable: isDeletable ?? false,
      canNotDeleteReason: canNotDeleteReason ?? "",
      canNotEditReason: canNotEditReason ?? "",
      errorMessage: "",
      key: GlobalKey(),
      label: description ?? "",
      isChanged: false,
      maxCount: maxCount ?? 0,
      minCount: minCount ?? 0,
    );
  }
}

extension RemoteProfileFilesExtension on List<RemoteProfileFile>? {
  List<ProfileFile> mapToDomain() {
    return this?.map((e) => e.mapToDomain()).toList() ?? [];
  }
}
