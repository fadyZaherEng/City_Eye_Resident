// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_gallery_attachment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteGalleryAttachment _$RemoteGalleryAttachmentFromJson(
        Map<String, dynamic> json) =>
    RemoteGalleryAttachment(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? "",
      attachment: json['attachment'] as String? ?? "",
      sortNo: json['sortNo'] as int? ?? 0,
    );

Map<String, dynamic> _$RemoteGalleryAttachmentToJson(
        RemoteGalleryAttachment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'attachment': instance.attachment,
      'sortNo': instance.sortNo,
    };
