// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_otp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteOTP _$RemoteOTPFromJson(Map<String, dynamic> json) => RemoteOTP(
      userId: json['userId'] as int? ?? 0,
      newOTPnumber: json['newOTPnumber'] as String? ?? "",
      expireDate: json['expireDate'] as String? ?? "",
      unit: json['unit'] == null
          ? const RemoteUserUnit()
          : RemoteUserUnit.fromJson(json['unit'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RemoteOTPToJson(RemoteOTP instance) => <String, dynamic>{
      'userId': instance.userId,
      'newOTPnumber': instance.newOTPnumber,
      'expireDate': instance.expireDate,
      'unit': instance.unit,
    };
