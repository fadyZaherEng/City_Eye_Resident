// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_password_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangePasswordRequest _$ChangePasswordRequestFromJson(
        Map<String, dynamic> json) =>
    ChangePasswordRequest(
      newPassword: json['newPassword'] as String,
      confirmPassword: json['confirmPassword'] as String,
      oldPassword: json['oldPassword'] as String,
    );

Map<String, dynamic> _$ChangePasswordRequestToJson(
        ChangePasswordRequest instance) =>
    <String, dynamic>{
      'newPassword': instance.newPassword,
      'confirmPassword': instance.confirmPassword,
      'oldPassword': instance.oldPassword,
    };
