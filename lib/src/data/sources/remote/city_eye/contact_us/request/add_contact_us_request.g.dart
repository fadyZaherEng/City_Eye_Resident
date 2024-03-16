// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_contact_us_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddContactUsRequest _$AddContactUsRequestFromJson(Map<String, dynamic> json) =>
    AddContactUsRequest(
      name: json['name'] as String? ?? "",
      email: json['email'] as String? ?? "",
      mobile: json['mobile'] as String? ?? "",
      countryId: json['countryId'] as int? ?? 0,
      message: json['message'] as String? ?? "",
    );

Map<String, dynamic> _$AddContactUsRequestToJson(
        AddContactUsRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'mobile': instance.mobile,
      'countryId': instance.countryId,
      'message': instance.message,
    };
