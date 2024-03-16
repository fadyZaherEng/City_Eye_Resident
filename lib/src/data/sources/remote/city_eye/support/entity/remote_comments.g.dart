// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_comments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteComments _$RemoteCommentsFromJson(Map<String, dynamic> json) =>
    RemoteComments(
      id: json['id'] as int? ?? 0,
      message: json['message'] as String? ?? "",
      date: json['date'] as String? ?? "",
      isImage: json['isImage'] as bool? ?? false,
      user: json['user'] == null
          ? const RemoteCommentUser()
          : RemoteCommentUser.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RemoteCommentsToJson(RemoteComments instance) =>
    <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'date': instance.date,
      'isImage': instance.isImage,
      'user': instance.user,
    };
