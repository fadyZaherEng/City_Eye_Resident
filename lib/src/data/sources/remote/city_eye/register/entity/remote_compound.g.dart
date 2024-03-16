// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_compound.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteCompound _$RemoteCompoundFromJson(Map<String, dynamic> json) =>
    RemoteCompound(
      cityid: json['cityid'] as int? ?? 0,
      compoundId: json['compoundId'] as int? ?? 0,
      cityname: json['cityname'] as String? ?? "",
      compoubdName: json['compoubdName'] as String? ?? "",
      compoundLogo: json['compoundLogo'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteCompoundToJson(RemoteCompound instance) =>
    <String, dynamic>{
      'cityid': instance.cityid,
      'compoundId': instance.compoundId,
      'cityname': instance.cityname,
      'compoubdName': instance.compoubdName,
      'compoundLogo': instance.compoundLogo,
    };
