// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_user_family_member_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddUserFamilyMemberRequest _$AddUserFamilyMemberRequestFromJson(
        Map<String, dynamic> json) =>
    AddUserFamilyMemberRequest(
      name: json['name'] as String?,
      mobileNumber: json['mobileNumber'] as String?,
      relationShipTypeId: json['relationShipTypeId'] as int?,
      countryCode: json['countryCode'] as String?,
      email: json['email'] as String?,
      attachment: json['attachment'] as String?,
    );

Map<String, dynamic> _$AddUserFamilyMemberRequestToJson(
        AddUserFamilyMemberRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'mobileNumber': instance.mobileNumber,
      'relationShipTypeId': instance.relationShipTypeId,
      'countryCode': instance.countryCode,
      'email': instance.email,
      'attachment': instance.attachment,
    };
