// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validate_mobile_number_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValidateMobileNumberRequest _$ValidateMobileNumberRequestFromJson(
        Map<String, dynamic> json) =>
    ValidateMobileNumberRequest(
      mobileNumber: json['mobileNumber'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$ValidateMobileNumberRequestToJson(
        ValidateMobileNumberRequest instance) =>
    <String, dynamic>{
      'mobileNumber': instance.mobileNumber,
      'email': instance.email,
    };
