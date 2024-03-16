import 'package:json_annotation/json_annotation.dart';

part 'event_details_request.g.dart';

@JsonSerializable()
final class EventDetailsRequest {
  final int eventId;

  const EventDetailsRequest({
    required this.eventId,
  });

  factory EventDetailsRequest.fromJson(Map<String, dynamic> json) =>
      _$EventDetailsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$EventDetailsRequestToJson(this);

}
