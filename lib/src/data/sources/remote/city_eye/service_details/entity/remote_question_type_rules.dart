import 'package:city_eye/src/domain/entities/service_details/question_type_rules.dart';
import 'package:city_eye/src/domain/entities/settings/validation_rule.dart';
import 'package:json_annotation/json_annotation.dart';
part 'remote_question_type_rules.g.dart';

@JsonSerializable()
class RemoteQuestionTypeRules {
  final int? id;
  final String? code;

  const RemoteQuestionTypeRules({
    this.id = 0,
    this.code = "",
  });

  factory RemoteQuestionTypeRules.fromJson(Map<String, dynamic> json) =>
      _$RemoteQuestionTypeRulesFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteQuestionTypeRulesToJson(this);
}
extension RemoteQuestionTypeRulesExtension on RemoteQuestionTypeRules {
  ValidationRule get mapToDomain => ValidationRule(
        id: id ?? 0,
        code: code ?? "",
      );
}