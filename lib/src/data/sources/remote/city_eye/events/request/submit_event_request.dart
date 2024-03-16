import 'package:city_eye/src/data/sources/remote/city_eye/events/request/event_question_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'submit_event_request.g.dart';

@JsonSerializable()
final class SubmitEventRequest {
  final int eventid;
  final int eventOptionId;
  final int transactionId;
  final String calendarRef;
  final List<EventQuestionRequest> questionAnswer;

  const SubmitEventRequest({
    required this.eventid,
    required this.eventOptionId ,
    required this.transactionId ,
    required this.calendarRef ,
    required this.questionAnswer,
  });

  factory SubmitEventRequest.fromJson(Map<String, dynamic> json) =>
      _$SubmitEventRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SubmitEventRequestToJson(this);

  Map<String, dynamic> toMap() {
    return {
      'eventid': this.eventid,
      'eventOptionId': this.eventOptionId,
      'transactionId': this.transactionId,
      'calendarRef': this.calendarRef,
      'questionAnswer':  questionAnswer.map((question) => question.toMap()).toList(),
    };
  }

  factory SubmitEventRequest.fromMap(Map<String, dynamic> map) {
    return SubmitEventRequest(
      eventid: map['eventid'] as int,
      eventOptionId: map['eventOptionId'] as int,
      transactionId: map['transactionId'] as int,
      calendarRef: map['calendarRef'] as String,
      questionAnswer: map['questionAnswer'] as List<EventQuestionRequest>,
    );
  }
}
