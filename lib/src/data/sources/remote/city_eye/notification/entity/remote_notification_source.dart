import 'package:city_eye/src/domain/entities/notification/notification_source.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_notification_source.g.dart';

@JsonSerializable()
final class RemoteNotificationSource {
  final int? id;
  final String? name;
  final String? code;

  const RemoteNotificationSource({
    this.id = 0,
    this.name = "",
    this.code = "",
  });

  factory RemoteNotificationSource.fromJson(Map<String, dynamic> json) =>
      _$RemoteNotificationSourceFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteNotificationSourceToJson(this);
}

extension RemoteNotificationSourceExtension on RemoteNotificationSource {
  NotificationSource mapToDomain() {
    return NotificationSource(
      id: id ?? 0,
      name: name ?? "",
      code: code ?? "",
    );
  }
}
