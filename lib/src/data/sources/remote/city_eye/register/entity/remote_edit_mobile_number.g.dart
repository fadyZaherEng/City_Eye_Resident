// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_edit_mobile_number.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteEditMobileNumber _$RemoteEditMobileNumberFromJson(
        Map<String, dynamic> json) =>
    RemoteEditMobileNumber(
      newOTPnumber: json['newOTPnumber'] as String? ?? "",
      expireDate: json['expireDate'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteEditMobileNumberToJson(
        RemoteEditMobileNumber instance) =>
    <String, dynamic>{
      'newOTPnumber': instance.newOTPnumber,
      'expireDate': instance.expireDate,
    };
