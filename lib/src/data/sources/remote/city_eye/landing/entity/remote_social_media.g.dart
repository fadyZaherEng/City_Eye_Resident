// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_social_media.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteSocialMedia _$RemoteSocialMediaFromJson(Map<String, dynamic> json) =>
    RemoteSocialMedia(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? "",
      code: json['code'] as String? ?? "",
      logo: json['logo'] as String? ?? "",
      extraValueOne: json['extraValue1'] as String? ?? "",
      extraValueTwo: json['extraValue2'] as String? ?? "",
      parentId: json['parentId'] as int? ?? 0,
      sortNo: json['sortNo'] as int? ?? 0,
    );

Map<String, dynamic> _$RemoteSocialMediaToJson(RemoteSocialMedia instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'logo': instance.logo,
      'extraValue1': instance.extraValueOne,
      'extraValue2': instance.extraValueTwo,
      'parentId': instance.parentId,
      'sortNo': instance.sortNo,
    };
