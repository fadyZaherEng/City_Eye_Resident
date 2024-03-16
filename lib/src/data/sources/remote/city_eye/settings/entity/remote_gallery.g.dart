// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_gallery.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteGallery _$RemoteGalleryFromJson(Map<String, dynamic> json) =>
    RemoteGallery(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? "",
      description: json['description'] as String? ?? "",
      galleryDate: json['galleryDate'] as String? ?? "",
      createdBy: json['createdBy'] as String? ?? "",
      mainImage: json['mainImage'] as String? ?? "",
      galleryAttachments: (json['galleryAttachments'] as List<dynamic>?)
              ?.map((e) =>
                  RemoteGalleryAttachment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <RemoteGalleryAttachment>[],
    );

Map<String, dynamic> _$RemoteGalleryToJson(RemoteGallery instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'galleryDate': instance.galleryDate,
      'createdBy': instance.createdBy,
      'mainImage': instance.mainImage,
      'galleryAttachments':
          instance.galleryAttachments?.map((e) => e.toJson()).toList(),
    };
