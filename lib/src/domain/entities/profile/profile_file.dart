import 'package:city_eye/src/data/sources/remote/city_eye/profile/request/profile_document_request.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ProfileFile extends Equatable {
  final int id;
  final int typeId;
  final String code;
  final String name;
  final String value;
  final String expireDate;
  final bool isEditable;
  final bool isDeletable;
  final String canNotDeleteReason;
  final String canNotEditReason;
  final bool isMandatory;
  final String label;
  final GlobalKey? key;
  final String errorMessage;
  final bool isChanged;
  final String description;
  final int maxCount;
  final int minCount;

  const ProfileFile({
    this.id = 0,
    this.code = "",
    this.name = "",
    this.value = "",
    this.typeId = 0,
    this.expireDate = "",
    this.isEditable = false,
    this.isDeletable = false,
    this.canNotDeleteReason = "",
    this.canNotEditReason = "",
    this.isMandatory = false,
    this.label = "",
    this.key,
    this.errorMessage = "",
    this.description = "",
    this.isChanged = false,
    this.maxCount = 0,
    this.minCount = 0,
  });

  ProfileFile copyWith({
    int? id,
    int? typeId,
    String? name,
    String? code,
    String? value,
    String? expireDate,
    bool? isEditable,
    bool? isDeletable,
    String? canNotDeleteReason,
    String? canNotEditReason,
    bool? isMandatory,
    String? label,
    GlobalKey? key,
    String? errorMessage,
    bool? isChanged,
    int? maxCount,
    int? minCount,
  }) {
    return ProfileFile(
      id: id ?? this.id,
      typeId: typeId ?? this.typeId,
      code: code ?? this.code,
      name: name ?? this.name,
      value: value ?? this.value,
      expireDate: expireDate ?? this.expireDate,
      isEditable: isEditable ?? this.isEditable,
      isDeletable: isDeletable ?? this.isDeletable,
      canNotDeleteReason: canNotDeleteReason ?? this.canNotDeleteReason,
      canNotEditReason: canNotEditReason ?? this.canNotEditReason,
      isMandatory: isMandatory ?? this.isMandatory,
      label: label ?? this.label,
      key: key ?? this.key,
      errorMessage: errorMessage ?? this.errorMessage,
      isChanged: isChanged ?? this.isChanged,
      maxCount: maxCount ?? this.maxCount,
      minCount: minCount ?? this.minCount,
    );
  }

  @override
  List<Object?> get props => [
        id,
        typeId,
        code,
        name,
        value,
        expireDate,
        isEditable,
        isDeletable,
        canNotDeleteReason,
        canNotEditReason,
        isMandatory,
        label,
        key,
        errorMessage,
        isChanged,
        description,
        maxCount,
        minCount,
      ];
}

extension PageFieldExtension on ProfileFile {
  ProfileDocumentRequest mapToRequest() {
    return ProfileDocumentRequest(
        controlTypeId: typeId,
        controlTypeCode: code,
        label: label,
        id: id,
        isRequired: isMandatory,
        value: value,
        expireDate: expireDate == "" ? null : expireDate,
        isChanged: isChanged);
  }
}

extension PageFieldsExtension on List<ProfileFile> {
  List<ProfileDocumentRequest> mapToRequest() {
    return map((e) => e.mapToRequest()).toList();
  }
}
