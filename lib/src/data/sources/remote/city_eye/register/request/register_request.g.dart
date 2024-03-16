// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) =>
    RegisterRequest(
      unitId: json['unitId'] as String,
      userTypeId: json['UserTypeId'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      mobileNumber: json['mobileNumber'] as String,
      password: json['password'] as String,
      files: (json['Files'] as List<dynamic>)
          .map((e) => RegisterFile.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RegisterRequestToJson(RegisterRequest instance) =>
    <String, dynamic>{
      'unitId': instance.unitId,
      'UserTypeId': instance.userTypeId,
      'name': instance.name,
      'email': instance.email,
      'mobileNumber': instance.mobileNumber,
      'password': instance.password,
      'Files': instance.files,
    };
