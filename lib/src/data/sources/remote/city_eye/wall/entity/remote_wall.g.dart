// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_wall.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteWall _$RemoteWallFromJson(Map<String, dynamic> json) => RemoteWall(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? "",
      description: json['description'] as String? ?? "",
      wallDate: json['wallDate'] as String? ?? "",
      createdBy: json['createdBy'] as String? ?? "",
      mainImage: json['mainImage'] as String? ?? "",
      wallAttachments: (json['wallAttachments'] as List<dynamic>?)
              ?.map((e) =>
                  RemoteWallAttachment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$RemoteWallToJson(RemoteWall instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'wallDate': instance.wallDate,
      'createdBy': instance.createdBy,
      'mainImage': instance.mainImage,
      'wallAttachments': instance.wallAttachments,
    };
