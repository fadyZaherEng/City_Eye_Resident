import 'package:json_annotation/json_annotation.dart';

part 'enable_disable_notifications.g.dart';

@JsonSerializable()
class EnableDisableNotificationsRequest {
  final bool status;

  EnableDisableNotificationsRequest({
    required this.status,
  });

  factory EnableDisableNotificationsRequest.fromJson(Map<String, dynamic> json) =>
      _$EnableDisableNotificationsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$EnableDisableNotificationsRequestToJson(this);
}
