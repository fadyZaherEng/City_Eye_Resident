import 'dart:io';

import 'package:city_eye/src/core/utils/questions_code.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/community_request/request/extra_field_answers_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/delegated/request/delegated_extra_field_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/profile/request/info_file_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/qr/request/unit_qr_question_answer.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/register/request/register_file.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/service_details/request/service_package_question_request.dart';
import 'package:city_eye/src/domain/entities/service_details/service_package_question_validations.dart';
import 'package:city_eye/src/domain/entities/settings/choice.dart';
import 'package:city_eye/src/domain/entities/settings/validation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class PageField extends Equatable {
  final int id;
  final int typeId;
  final int eventOptionId;
  final int maxCount;
  final int minCount;
  final String code;
  final String label;
  final String description;
  final bool isRequired;
  final String value;
  final String answerId;
  final List<Choice> choices;
  final List<File> imagesList;
  final String errorMessage;
  final bool fileValid;
  final GlobalKey? key;
  final int? index;
  final bool notAnswered;
  final String expireDate;
  final bool isEditable;
  final bool isDeletable;
  final String canNotDeleteReason;
  final String canNotEditReason;
  final bool isFromServer;
  final bool isHasRelatedQuestion;
  final List<Validation> validations;
  final bool isValid;
  final String validationMessage;

  PageField({
    this.id = 0,
    this.typeId = 0,
    this.eventOptionId = 0,
    this.maxCount = 0,
    this.minCount = 0,
    this.code = "",
    this.label = "",
    this.description = "",
    this.isRequired = false,
    this.value = "",
    this.answerId = "",
    this.choices = const [],
    this.validations = const [],
    this.imagesList = const [],
    this.errorMessage = "",
    this.fileValid = false,
    this.index = 0,
    this.key,
    this.notAnswered = false,
    this.expireDate = "",
    this.isEditable = false,
    this.isDeletable = false,
    this.canNotDeleteReason = "",
    this.canNotEditReason = "",
    this.isFromServer = false,
    this.isHasRelatedQuestion = false,
    this.isValid = true,
    this.validationMessage = "",
  });

  PageField copyWith({
    int? id,
    int? typeId,
    int? eventOptionId,
    int? maxCount,
    int? minCount,
    String? code,
    String? label,
    String? description,
    bool? isRequired,
    String? value,
    String? answerId,
    List<Choice>? choices,
    List<File>? imagesList,
    String? errorMessage,
    bool? fileValid,
    int? index,
    GlobalKey? key,
    bool? notAnswered,
    String? expireDate,
    bool? isEditable,
    bool? isDeletable,
    String? canNotDeleteReason,
    String? canNotEditReason,
    bool? isFromServer,
    bool? isHasRelatedQuestion,
    List<Validation>? validations,
    bool? isValid,
    String? validationMessage,
  }) {
    return PageField(
      id: id ?? this.id,
      typeId: typeId ?? this.typeId,
      maxCount: maxCount ?? this.maxCount,
      minCount: minCount ?? this.minCount,
      code: code ?? this.code,
      label: label ?? this.label,
      description: description ?? this.description,
      isRequired: isRequired ?? this.isRequired,
      value: value ?? this.value,
      answerId: answerId ?? this.answerId,
      choices: choices ?? this.choices,
      imagesList: imagesList ?? this.imagesList,
      errorMessage: errorMessage ?? this.errorMessage,
      fileValid: fileValid ?? this.fileValid,
      index: index ?? this.index,
      key: key ?? this.key,
      notAnswered: notAnswered ?? this.notAnswered,
      expireDate: expireDate ?? this.expireDate,
      isEditable: notAnswered ?? this.isEditable,
      isDeletable: isDeletable ?? this.isDeletable,
      canNotDeleteReason: canNotDeleteReason ?? this.canNotDeleteReason,
      canNotEditReason: canNotEditReason ?? this.canNotEditReason,
      isFromServer: isFromServer ?? this.isFromServer,
      isHasRelatedQuestion: isHasRelatedQuestion ?? this.isHasRelatedQuestion,
      validations: validations ?? this.validations,
      isValid: isValid ?? this.isValid,
      validationMessage: validationMessage ?? this.validationMessage,
      eventOptionId: eventOptionId ?? this.eventOptionId,
      //write the rest of the fields
    );
  }

  @override
  List<Object?> get props => [
        id,
        typeId,
        eventOptionId,
        maxCount,
        minCount,
        code,
        label,
        description,
        isRequired,
        value,
        answerId,
        choices,
        imagesList,
        errorMessage,
        fileValid,
        index,
        key,
        notAnswered,
        expireDate,
        isEditable,
        isDeletable,
        canNotDeleteReason,
        isFromServer,
        canNotEditReason,
        validations,
        eventOptionId,
        isHasRelatedQuestion,
    isValid,
    validationMessage
      ];

  PageField deepClone() {
    return PageField(
      id: id,
      typeId: typeId,
      eventOptionId: eventOptionId,
      maxCount: maxCount,
      minCount: minCount,
      code: code,
      label: label,
      description: description,
      isRequired: isRequired,
      value: value,
      answerId: answerId,
      choices: choices.map((choice) => choice.deepClone()).toList(),
      imagesList: imagesList.map((image) => File(image.path)).toList(),
      errorMessage: errorMessage,
      fileValid: fileValid,
      key: key,
      // Note: This will still reference the same GlobalKey
      index: index,
      notAnswered: notAnswered,
      expireDate: expireDate,
      isEditable: isEditable,
      isDeletable: isDeletable,
      canNotDeleteReason: canNotDeleteReason,
      canNotEditReason: canNotEditReason,
      isFromServer: isFromServer,
      validations: validations,
      isValid: isValid,
      validationMessage: validationMessage,
    );
  }

  @override
  String toString() {
    return 'PageField{id: $id, typeId: $typeId, eventOptionId: $eventOptionId, code: $code, label: $label, description: $description, isRequired: $isRequired, value: $value, answerId: $answerId, choices: $choices, imagesList: $imagesList, errorMessage: $errorMessage, fileValid: $fileValid, key: $key, index: $index, notAnswered: $notAnswered, expireDate: $expireDate, isEditable: $isEditable, isDeletable: $isDeletable, canNotDeleteReason: $canNotDeleteReason, canNotEditReason: $canNotEditReason, isFromServer: $isFromServer, validations: $validations isValid: $isValid}';
  }
}

extension PageFieldExtension on PageField {
  RegisterFile mapToDomain() {
    return RegisterFile(
      controlTypeId: typeId,
      controlTypeCode: code,
      label: label,
      id: id,
      isRequired: isRequired,
      value: imagesList.isEmpty
          ? value
          : imagesList.map((e) => e.path).toList().join(","),
      expireDate: "",
    );
  }
}

extension PageFieldsExtension on List<PageField> {
  List<RegisterFile> mapToDomain() {
    return map((e) => e.mapToDomain()).toList();
  }
}

extension ProfilePageFieldExtension on PageField {
  InfoFileRequest mapToInfoRequestFile() {
    return InfoFileRequest(
        controlTypeId: id,
        controlTypeCode: code,
        label: label,
        id: id,
        isRequired: isRequired,
        value: value,
        answerId: 0);
  }
}

extension ProfilePageFieldsExtension on List<PageField> {
  List<InfoFileRequest> mapToInfoRequestFiles() {
    return map((e) => e.mapToInfoRequestFile()).toList();
  }
}

extension PageFieldConvertToServicePackageQuestionRequestExtension
    on PageField {
  ServicePackageQuestionRequest mapToServicePackageQuestionRequest() {
    return ServicePackageQuestionRequest(
      id: id,
      controlTypeId: typeId,
      controlTypeCode: code,
      lable: label,
      isRequired: isRequired,
      value: value,
      answerId: answerId,
    );
  }
}

extension PageFieldConvertToServicePackageQuestionRequestListExtension
    on List<PageField> {
  List<ServicePackageQuestionRequest> mapToServicesPackageQuestionRequest() {
    return map((e) => e.mapToServicePackageQuestionRequest()).toList();
  }
}

extension PageFieldConvertToUnitQrQuestionAnswerExtension on PageField {
  UnitQrQuestionAnswer mapToUnitQrQuestionAnswer() {
    return UnitQrQuestionAnswer(
      id: id,
      controlTypeCode: code,
      lable: label,
      value: value,
      answerId: answerId,
    );
  }
}

extension PageFieldConvertToUnitQrQuestionAnswerListExtension
    on List<PageField> {
  List<UnitQrQuestionAnswer> mapToUnitQrQuestionAnswerList() {
    return map((e) => e.mapToUnitQrQuestionAnswer()).toList();
  }
}

extension PageFieldConvertToDelegatedExtraFieldRequestExtension on PageField {
  DelegatedExtraFieldRequest mapToDelegatedExtraFieldRequest() {
    return DelegatedExtraFieldRequest(
      id: id,
      controlTypeId: typeId,
      controlTypeCode: code,
      lable: label,
      isRequired: isRequired,
      value: value,
      answerId: answerId,
    );
  }
}

extension PageFieldConvertToDelegatedExtraFieldRequestListExtension
    on List<PageField> {
  List<DelegatedExtraFieldRequest> mapToDelegatedExtraFieldRequest() {
    return map((e) => e.mapToDelegatedExtraFieldRequest()).toList();
  }
}

extension PageFieldConvertToExtraFieldAnswersRequestExtension on PageField {
  ExtraFieldAnswersRequest mapToExtraFieldAnswersRequest() {
    return ExtraFieldAnswersRequest(
      id: id,
      controlTypeId: typeId,
      controlTypeCode: code,
      lable: label,
      isRequired: isRequired,
      value: value,
      answerId: answerId,
    );
  }
}

extension PageFieldConvertToExtraFieldAnswersRequestListExtension
    on List<PageField> {
  List<ExtraFieldAnswersRequest> mapToExtraFieldAnswersRequestList() {
    return map((e) => e.mapToExtraFieldAnswersRequest()).toList();
  }
}
