// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_events_attachments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteEventAttachments _$RemoteEventAttachmentsFromJson(
        Map<String, dynamic> json) =>
    RemoteEventAttachments(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? "",
      attachment: json['attachment'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteEventAttachmentsToJson(
        RemoteEventAttachments instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'attachment': instance.attachment,
    };
