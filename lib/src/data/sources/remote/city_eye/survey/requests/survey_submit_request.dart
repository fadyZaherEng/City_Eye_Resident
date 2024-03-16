
import 'package:json_annotation/json_annotation.dart';

part 'survey_submit_request.g.dart';

@JsonSerializable()
class SurveySubmitRequest {
  int id;
  String questionTypeCode;
  String answer;
  String answerId;

  SurveySubmitRequest(
      {
      required this.id,
      required this.questionTypeCode,
      required this.answer,
      required this.answerId});


  factory SurveySubmitRequest.fromJson(Map<String, dynamic> json) =>
      _$SurveySubmitRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SurveySubmitRequestToJson(this);

}
