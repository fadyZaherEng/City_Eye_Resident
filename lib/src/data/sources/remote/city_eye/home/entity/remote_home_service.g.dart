// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_home_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteHomeService _$RemoteHomeServiceFromJson(Map<String, dynamic> json) =>
    RemoteHomeService(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? "",
      code: json['code'] as String? ?? "",
      extraValue1: json['extraValue1'] as String? ?? "",
      extraValue2: json['extraValue2'] as String? ?? "",
      parentId: json['parentId'] as int? ?? 0,
      logo: json['logo'] as String? ?? "",
      sortNo: json['sortNo'] as int? ?? 0,
    );

Map<String, dynamic> _$RemoteHomeServiceToJson(RemoteHomeService instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'extraValue1': instance.extraValue1,
      'extraValue2': instance.extraValue2,
      'parentId': instance.parentId,
      'logo': instance.logo,
      'sortNo': instance.sortNo,
    };
