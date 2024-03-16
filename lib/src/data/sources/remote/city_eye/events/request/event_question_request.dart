import 'package:json_annotation/json_annotation.dart';

part 'event_question_request.g.dart';

@JsonSerializable()
final class EventQuestionRequest {
  final int id;
  final int controlTypeId;
  final String controlTypeCode;
  final String lable;
  final bool isRequired;
  final String value;
  final String answerId;

  const EventQuestionRequest({
    required this.id,
    required this.controlTypeId,
    required this.controlTypeCode,
    required this.lable,
    required this.isRequired,
    required this.value,
    required this.answerId,
  });

  factory EventQuestionRequest.fromJson(Map<String, dynamic> json) =>
      _$EventQuestionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$EventQuestionRequestToJson(this);

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

  factory EventQuestionRequest.fromMap(Map<String, dynamic> map) {
    return EventQuestionRequest(
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
