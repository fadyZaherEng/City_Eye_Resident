// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_partner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemotePartner _$RemotePartnerFromJson(Map<String, dynamic> json) =>
    RemotePartner(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? "",
      code: json['code'] as String? ?? "",
      mobile: json['mobile'] as String? ?? "",
      logo: json['logo'] as String? ?? "",
      description: json['description'] as String? ?? "",
    );

Map<String, dynamic> _$RemotePartnerToJson(RemotePartner instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'mobile': instance.mobile,
      'logo': instance.logo,
      'description': instance.description,
    };
