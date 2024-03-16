// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_city_compound.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteCityCompound _$RemoteCityCompoundFromJson(Map<String, dynamic> json) =>
    RemoteCityCompound(
      cityid: json['cityid'] as int? ?? 0,
      parentId: json['parentId'] as int? ?? 0,
      cityname: json['cityname'] as String? ?? "",
      compounds: (json['compounds'] as List<dynamic>?)
              ?.map((e) => RemoteCompound.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$RemoteCityCompoundToJson(RemoteCityCompound instance) =>
    <String, dynamic>{
      'cityid': instance.cityid,
      'parentId': instance.parentId,
      'cityname': instance.cityname,
      'compounds': instance.compounds,
    };
