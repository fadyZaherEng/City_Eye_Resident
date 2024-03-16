import 'package:city_eye/src/domain/entities/service_details/question_type_rules.dart';
import 'package:equatable/equatable.dart';

final class ServicePackageQuestionValidation extends Equatable {
  final int id;
  final int servicePackageQuestionId;
  final QuestionTypeRules questionTypeRules;
  final String value1;
  final String value2;

  const ServicePackageQuestionValidation({
    this.id = 0,
    this.servicePackageQuestionId = 0,
    this.questionTypeRules = const QuestionTypeRules(),
    this.value1 = "",
    this.value2 = "",
  });

  ServicePackageQuestionValidation copyWith({
    int? id,
    int? servicePackageQuestionId,
    QuestionTypeRules? questionTypeRules,
    String? value1,
    dynamic value2,
  }) =>
      ServicePackageQuestionValidation(
        id: id ?? this.id,
        servicePackageQuestionId:
            servicePackageQuestionId ?? this.servicePackageQuestionId,
        questionTypeRules: questionTypeRules ?? this.questionTypeRules,
        value1: value1 ?? this.value1,
        value2: value2 ?? this.value2,
      );

  @override
  List<Object> get props => [
        id,
        servicePackageQuestionId,
        questionTypeRules,
        value1,
        value2,
      ];

  ServicePackageQuestionValidation deepClone() {
    return ServicePackageQuestionValidation(
      id: this.id,
      servicePackageQuestionId: this.servicePackageQuestionId,
      questionTypeRules: this.questionTypeRules.deepClone(),
      value1: this.value1,
      value2: this.value2,
    );
  }
}
