// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_list_social_media.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteListSocialMedia _$RemoteListSocialMediaFromJson(
        Map<String, dynamic> json) =>
    RemoteListSocialMedia(
      id: json['id'] as int? ?? 0,
      value: json['value'] as String? ?? "",
      socialMediaType: json['socialMediaType'] == null
          ? const RemoteSocialMediaType()
          : RemoteSocialMediaType.fromJson(
              json['socialMediaType'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RemoteListSocialMediaToJson(
        RemoteListSocialMedia instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
      'socialMediaType': instance.socialMediaType?.toJson(),
    };
