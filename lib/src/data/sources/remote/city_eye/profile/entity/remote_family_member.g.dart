// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_family_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteFamilyMember _$RemoteFamilyMemberFromJson(Map<String, dynamic> json) =>
    RemoteFamilyMember(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? "",
      mobileNumber: json['mobileNumber'] as String? ?? "",
      relationShipType: json['relationShipType'] == null
          ? const RemoteType()
          : RemoteType.fromJson(
              json['relationShipType'] as Map<String, dynamic>),
      email: json['email'] as String? ?? "",
      attachment: json['attachment'] as String? ?? "",
      countryCode: json['countryCode'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteFamilyMemberToJson(RemoteFamilyMember instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'mobileNumber': instance.mobileNumber,
      'relationShipType': instance.relationShipType,
      'email': instance.email,
      'attachment': instance.attachment,
      'countryCode': instance.countryCode,
    };
