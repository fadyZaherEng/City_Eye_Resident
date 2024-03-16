// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_profile_unit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteProfileUnit _$RemoteProfileUnitFromJson(Map<String, dynamic> json) =>
    RemoteProfileUnit(
      id: json['id'] as int? ?? 0,
      unitId: json['unitId'] as int? ?? 0,
      userType: json['userType'] == null
          ? const RemoteType()
          : RemoteType.fromJson(json['userType'] as Map<String, dynamic>),
      compoundId: json['compoundId'] as int? ?? 0,
      compoundName: json['compoundName'] as String? ?? "",
      unitNO: json['unitNO'] as String? ?? "",
      unitName: json['unitName'] as String? ?? "",
      gazNo: json['gasNO'] as String? ?? "",
      telephone: json['telephone'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteProfileUnitToJson(RemoteProfileUnit instance) =>
    <String, dynamic>{
      'id': instance.id,
      'unitId': instance.unitId,
      'userType': instance.userType,
      'compoundId': instance.compoundId,
      'compoundName': instance.compoundName,
      'unitNO': instance.unitNO,
      'unitName': instance.unitName,
      'gasNO': instance.gazNo,
      'telephone': instance.telephone,
    };
