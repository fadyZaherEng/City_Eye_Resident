// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_lookup_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteLookupFile _$RemoteLookupFileFromJson(Map<String, dynamic> json) =>
    RemoteLookupFile(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? "",
      code: json['code'] as String? ?? "",
      extraValueOne: json['extraValue1'] as String? ?? "",
      extraValueTwo: json['extraValue2'] as String? ?? "",
      parentId: json['parentId'] as int? ?? 0,
      logo: json['logo'] as String? ?? "",
      sortNo: json['sortNo'] as int? ?? 0,
    );

Map<String, dynamic> _$RemoteLookupFileToJson(RemoteLookupFile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'extraValue1': instance.extraValueOne,
      'extraValue2': instance.extraValueTwo,
      'parentId': instance.parentId,
      'logo': instance.logo,
      'sortNo': instance.sortNo,
    };
