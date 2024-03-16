// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_comment_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteCommentUser _$RemoteCommentUserFromJson(Map<String, dynamic> json) =>
    RemoteCommentUser(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? "",
      image: json['image'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteCommentUserToJson(RemoteCommentUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
    };
