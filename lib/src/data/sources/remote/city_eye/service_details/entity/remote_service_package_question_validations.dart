import 'package:city_eye/src/data/sources/remote/city_eye/service_details/entity/remote_question_type_rules.dart';
import 'package:city_eye/src/domain/entities/service_details/question_type_rules.dart';
import 'package:city_eye/src/domain/entities/service_details/service_package_question_validations.dart';
import 'package:city_eye/src/domain/entities/settings/validation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_service_package_question_validations.g.dart';

@JsonSerializable()
class RemoteServicePackageQuestionValidations {
  final int? id;
  final int? servicePackageQuestionId;
  final RemoteQuestionTypeRules? questionTypeRules;
  final String? value1;
  final String? value2;

  const RemoteServicePackageQuestionValidations({
    this.id = 0,
    this.servicePackageQuestionId = 0,
    this.questionTypeRules = const RemoteQuestionTypeRules(),
    this.value1,
    this.value2,
  });

  factory RemoteServicePackageQuestionValidations.fromJson(
          Map<String, dynamic> json) =>
      _$RemoteServicePackageQuestionValidationsFromJson(json);

  Map<String, dynamic> toJson() =>
      _$RemoteServicePackageQuestionValidationsToJson(this);
}

extension RemoteServicePackageQuestionValidationsExtension
    on RemoteServicePackageQuestionValidations {
  Validation get mapToDomain {
    return Validation(
      id: id ?? 0,
      // servicePackageQuestionId: servicePackageQuestionId ?? 0,
      validationRule: questionTypeRules!.mapToDomain,
      valueOne: value1 ?? "",
      valueTwo: value2 ?? "",
    );
  }
}

extension RemoteServicePackageQuestionValidationsListExtension
    on List<RemoteServicePackageQuestionValidations>? {
  List<Validation> get mapToDomain =>
      this!.map((e) => e.mapToDomain).toList();
}
