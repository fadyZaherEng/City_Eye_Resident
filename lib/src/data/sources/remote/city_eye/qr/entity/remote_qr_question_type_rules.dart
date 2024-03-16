import 'package:city_eye/src/domain/entities/qr/qr_question_type_rules.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_qr_question_type_rules.g.dart';

@JsonSerializable()
class RemoteQrQuestionTypeRules {
  final int? id;
  final String? code;

  const RemoteQrQuestionTypeRules({
    this.id = 0,
    this.code = "",
  });

  factory RemoteQrQuestionTypeRules.fromJson(Map<String, dynamic> json) =>
      _$RemoteQrQuestionTypeRulesFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteQrQuestionTypeRulesToJson(this);
}
extension RemoteQuestionTypeRulesExtension on RemoteQrQuestionTypeRules {
  QrQuestionTypeRules get mapToDomain => QrQuestionTypeRules(
        id: id ?? 0,
        code: code ?? "",
      );
}