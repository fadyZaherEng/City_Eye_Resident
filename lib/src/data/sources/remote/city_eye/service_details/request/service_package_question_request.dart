import 'package:city_eye/src/domain/entities/settings/page_field.dart';
import 'package:json_annotation/json_annotation.dart';

part 'service_package_question_request.g.dart';

@JsonSerializable()
final class ServicePackageQuestionRequest {
  final int id;
  final int controlTypeId;
  final String controlTypeCode;
  final String lable;
  final bool isRequired;
  final String value;
  final String answerId;

  const ServicePackageQuestionRequest({
    required this.id,
    required this.controlTypeId,
    required this.controlTypeCode,
    required this.lable,
    required this.isRequired,
    required this.value,
    required this.answerId,
  });

  factory ServicePackageQuestionRequest.fromJson(Map<String, dynamic> json) =>
      _$ServicePackageQuestionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ServicePackageQuestionRequestToJson(this);
}
