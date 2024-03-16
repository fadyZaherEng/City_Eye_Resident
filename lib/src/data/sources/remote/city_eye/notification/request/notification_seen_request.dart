import 'package:json_annotation/json_annotation.dart';

part 'notification_seen_request.g.dart';

@JsonSerializable()
class NotificationSeenRequest {
  final int notificationId;

  NotificationSeenRequest({required this.notificationId});

  factory NotificationSeenRequest.fromJson(Map<String, dynamic> json) =>
      _$NotificationSeenRequestFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationSeenRequestToJson(this);
}
