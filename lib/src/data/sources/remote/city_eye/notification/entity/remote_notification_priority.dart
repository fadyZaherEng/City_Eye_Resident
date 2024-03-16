import 'package:city_eye/src/domain/entities/notification/notification_priority.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_notification_priority.g.dart';

@JsonSerializable()
final class RemoteNotificationPriority {
  final int? id;
  final String? name;
  final String? code;
  final String? extra1;

  const RemoteNotificationPriority({
    this.id = 0,
    this.name = "",
    this.code = "",
    this.extra1 = "",
  });

  factory RemoteNotificationPriority.fromJson(Map<String, dynamic> json) =>
      _$RemoteNotificationPriorityFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteNotificationPriorityToJson(this);
}

extension RemoteNotificationPriorityExtension on RemoteNotificationPriority {
  NotificationPriority mapToDomain() {
    return NotificationPriority(
      id: id ?? 0,
      name: name ?? "",
      code: code ?? "",
      extra1: extra1 ?? "",
    );
  }
}
