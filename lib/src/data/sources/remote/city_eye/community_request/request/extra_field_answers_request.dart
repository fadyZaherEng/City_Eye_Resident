import 'package:json_annotation/json_annotation.dart';

part 'extra_field_answers_request.g.dart';

@JsonSerializable()
class ExtraFieldAnswersRequest {
  final int id;
  final int controlTypeId;
  final String controlTypeCode;
  final String lable;
  final bool isRequired;
  final String value;
  final String answerId;

  ExtraFieldAnswersRequest({
    required this.id,
    required this.controlTypeId,
    required this.controlTypeCode,
    required this.lable,
    required this.isRequired,
    required this.value,
    required this.answerId,
  });

  factory ExtraFieldAnswersRequest.fromJson(Map<String, dynamic> json) =>
      _$ExtraFieldAnswersRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ExtraFieldAnswersRequestToJson(this);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'controlTypeId': controlTypeId,
      'controlTypeCode': controlTypeCode,
      'lable': lable,
      'isRequired': isRequired,
      'value': value,
      'answerId': answerId,
    };
  }

  factory ExtraFieldAnswersRequest.fromMap(Map<String, dynamic> map) {
    return ExtraFieldAnswersRequest(
      id: map['id'] as int,
      controlTypeId: map['controlTypeId'] as int,
      controlTypeCode: map['controlTypeCode'] as String,
      lable: map['lable'] as String,
      isRequired: map['isRequired'] as bool,
      value: map['value'] as String,
      answerId: map['answerId'] as String,
    );
  }
}