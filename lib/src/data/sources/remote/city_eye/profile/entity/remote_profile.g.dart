// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteProfile _$RemoteProfileFromJson(Map<String, dynamic> json) =>
    RemoteProfile(
      info: json['profile'] == null
          ? const RemoteInfo()
          : RemoteInfo.fromJson(json['profile'] as Map<String, dynamic>),
      profileUnit: json['unit'] == null
          ? const RemoteProfileUnit()
          : RemoteProfileUnit.fromJson(json['unit'] as Map<String, dynamic>),
      files: (json['files'] as List<dynamic>?)
              ?.map(
                  (e) => RemoteProfileFile.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      familyMembers: (json['familyMember'] as List<dynamic>?)
              ?.map(
                  (e) => RemoteFamilyMember.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      cars: (json['cars'] as List<dynamic>?)
              ?.map((e) => RemoteCar.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$RemoteProfileToJson(RemoteProfile instance) =>
    <String, dynamic>{
      'profile': instance.info,
      'unit': instance.profileUnit,
      'files': instance.files,
      'familyMember': instance.familyMembers,
      'cars': instance.cars,
    };
