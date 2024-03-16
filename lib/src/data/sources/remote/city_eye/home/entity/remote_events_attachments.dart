import 'package:city_eye/src/domain/entities/home/events_attachments.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_events_attachments.g.dart';

@JsonSerializable()
class RemoteEventAttachments {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'attachment')
  final String? attachment;

  const RemoteEventAttachments({
    this.id = 0,
    this.name = "",
    this.attachment = "",
  });

  factory RemoteEventAttachments.fromJson(Map<String, dynamic> json) =>
      _$RemoteEventAttachmentsFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteEventAttachmentsToJson(this);
}

extension RemoteEventAttachmentsExtension on RemoteEventAttachments {
  EventAttachments mapToDomain() {
    return EventAttachments(
      id: id ?? 0,
      name: name ?? "",
      attachment: attachment ?? "",
    );
  }
}

extension RemoteEventAttachmentsListExtension on List<RemoteEventAttachments> {
  List<EventAttachments> mapToDomain() {
    return map((e) => e.mapToDomain()).toList();
  }
}
