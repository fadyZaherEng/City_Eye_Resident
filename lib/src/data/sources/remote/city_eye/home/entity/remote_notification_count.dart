import 'package:city_eye/src/domain/entities/home/notification_count.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_notification_count.g.dart';

@JsonSerializable()
class RemoteNotificationCount {
  final int? count;

  const RemoteNotificationCount({
    this.count = 0,
  });

  factory RemoteNotificationCount.fromJson(Map<String, dynamic> json) =>
      _$RemoteNotificationCountFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteNotificationCountToJson(this);
}

extension RemoteNotificationCountExtension on RemoteNotificationCount {
  NotificationCount mapToDomain() {
    return NotificationCount(
      count: count ?? 0,
    );
  }
}
