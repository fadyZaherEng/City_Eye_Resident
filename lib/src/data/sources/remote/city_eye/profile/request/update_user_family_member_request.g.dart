// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_family_member_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateUserFamilyMemberRequest _$UpdateUserFamilyMemberRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateUserFamilyMemberRequest(
      id: json['id'] as int?,
      name: json['name'] as String?,
      mobileNumber: json['mobileNumber'] as String?,
      relationShipTypeId: json['relationShipTypeId'] as int?,
      countryCode: json['countryCode'] as String?,
      email: json['email'] as String?,
      attachment: json['attachment'] as String?,
    );

Map<String, dynamic> _$UpdateUserFamilyMemberRequestToJson(
        UpdateUserFamilyMemberRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'mobileNumber': instance.mobileNumber,
      'relationShipTypeId': instance.relationShipTypeId,
      'countryCode': instance.countryCode,
      'email': instance.email,
      'attachment': instance.attachment,
    };
