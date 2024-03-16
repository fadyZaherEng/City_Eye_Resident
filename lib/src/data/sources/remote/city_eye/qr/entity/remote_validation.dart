import 'package:city_eye/src/data/sources/remote/city_eye/qr/entity/remote_validation_rule.dart';
import 'package:city_eye/src/domain/entities/settings/validation.dart';
import 'package:city_eye/src/domain/entities/settings/validation_rule.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_validation.g.dart';

@JsonSerializable()
class RemoteValidation {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'questionTypeRules')
  final RemoteValidationRule? remoteValidationRule;
  @JsonKey(name: 'value1')
  final String? value1;
  @JsonKey(name: 'value2')
  final String? value2;
  @JsonKey(name: 'validationMessage')
  final String? validationMessage;

  const RemoteValidation({
    this.id = 0,
    this.remoteValidationRule = const RemoteValidationRule(),
    this.value1 = "",
    this.value2 = "",
    this.validationMessage = "",
  });

  factory RemoteValidation.fromJson(Map<String, dynamic> json) =>
      _$RemoteValidationFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteValidationToJson(this);
}


extension RemoteValidationExtension on RemoteValidation {
  Validation mapToDomain() {
    return Validation(
      id: id ?? 0,
      validationRule: remoteValidationRule?.mapToDomain() ?? const ValidationRule(),
      valueOne: value1 ?? "",
      valueTwo: value2 ?? "",
      validationMessage: validationMessage ?? "",
    );
  }
}


extension RemoteValidationsExtension on List<RemoteValidation> {
  List<Validation> mapToDomain() {
    return map((e) => e.mapToDomain()).toList();
  }
}

