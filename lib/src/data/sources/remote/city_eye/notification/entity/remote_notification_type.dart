import 'package:city_eye/src/domain/entities/notification/notification_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_notification_type.g.dart';

@JsonSerializable()
final class RemoteNotificationType {
  final int? id;
  final String? name;
  final String? code;

  const RemoteNotificationType({
    this.id = 0,
    this.name = "",
    this.code = "",
  });

  factory RemoteNotificationType.fromJson(Map<String, dynamic> json) =>
      _$RemoteNotificationTypeFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteNotificationTypeToJson(this);
}

extension RemoteNotificationTypeExtension on RemoteNotificationType {
  NotificationType mapToDomain() {
    return NotificationType(
      id: id ?? 0,
      name: name ?? "",
      code: code ?? "",
    );
  }
}
