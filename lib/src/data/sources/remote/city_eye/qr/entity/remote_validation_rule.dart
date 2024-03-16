import 'package:city_eye/src/domain/entities/settings/validation_rule.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_validation_rule.g.dart';

@JsonSerializable()
class RemoteValidationRule {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'code')
  final String? code;

  const RemoteValidationRule({
    this.id = 0,
    this.code = "",
  });

  factory RemoteValidationRule.fromJson(Map<String, dynamic> json) =>
      _$RemoteValidationRuleFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteValidationRuleToJson(this);
}


extension RemoteValidationRuleExtension on RemoteValidationRule {
  ValidationRule mapToDomain() {
    return ValidationRule(
      id: id ?? 0,
      code: code ?? "",
    );
  }
}