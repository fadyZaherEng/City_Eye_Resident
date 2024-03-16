// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_wall_attachment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteWallAttachment _$RemoteWallAttachmentFromJson(
        Map<String, dynamic> json) =>
    RemoteWallAttachment(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? "",
      attachment: json['attachment'] as String? ?? "",
      sortNo: json['sortNo'] as int? ?? 0,
    );

Map<String, dynamic> _$RemoteWallAttachmentToJson(
        RemoteWallAttachment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'attachment': instance.attachment,
      'sortNo': instance.sortNo,
    };
