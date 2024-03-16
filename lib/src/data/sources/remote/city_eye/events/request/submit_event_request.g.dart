// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submit_event_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmitEventRequest _$SubmitEventRequestFromJson(Map<String, dynamic> json) =>
    SubmitEventRequest(
      eventid: json['eventid'] as int,
      eventOptionId: json['eventOptionId'] as int,
      transactionId: json['transactionId'] as int,
      calendarRef: json['calendarRef'] as String,
      questionAnswer: (json['questionAnswer'] as List<dynamic>)
          .map((e) => EventQuestionRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubmitEventRequestToJson(SubmitEventRequest instance) =>
    <String, dynamic>{
      'eventid': instance.eventid,
      'eventOptionId': instance.eventOptionId,
      'transactionId': instance.transactionId,
      'calendarRef': instance.calendarRef,
      'questionAnswer': instance.questionAnswer,
    };
