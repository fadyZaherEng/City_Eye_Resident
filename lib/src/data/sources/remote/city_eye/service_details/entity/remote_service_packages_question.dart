import 'package:city_eye/src/data/sources/remote/city_eye/service_details/entity/remote_service_package_question_validations.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/entity/remote_choice.dart';
import 'package:city_eye/src/domain/entities/settings/choice.dart';
import 'package:city_eye/src/domain/entities/settings/page_field.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_service_packages_question.g.dart';

@JsonSerializable()
final class RemoteServicePackagesQuestion {
  final List<RemoteServicePackageQuestionValidations>?
      servicePackageQuestionValidations;
  final int? id;
  final int? controlTypeId;
  final String? controlTypeCode;
  final String? lable;
  final bool? isRequired;
  final String? value;
  final String? answerId;
  final String? description;
  final List<RemoteChoice>? choice;

  const RemoteServicePackagesQuestion({
    this.servicePackageQuestionValidations = const [],
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

  factory RemoteServicePackagesQuestion.fromJson(Map<String, dynamic> json) =>
      _$RemoteServicePackagesQuestionFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteServicePackagesQuestionToJson(this);
}

extension RemoteServiceDetailsCartQuestionForPageFieldEntityExtension
    on RemoteServicePackagesQuestion {
  PageField get mapToDomain => PageField(
        id: id ?? 0,
        typeId: controlTypeId ?? 0,
        code: controlTypeCode ?? "",
        isRequired: isRequired ?? false,
        value: value ?? "",
        choices: choice!
            .map((e) => Choice(value: e.optionValue ?? "", id: e.optionId ?? 0))
            .toList(),
        label: lable ?? "",
        description: description ?? "",
        answerId: answerId ?? "",
        validations:
            servicePackageQuestionValidations.mapToDomain,
      );
}

extension RemoteServicePackagesQuestionListExtension
    on List<RemoteServicePackagesQuestion>? {
  List<PageField> get mapToDomain => this!.map((e) => e.mapToDomain).toList();
}
