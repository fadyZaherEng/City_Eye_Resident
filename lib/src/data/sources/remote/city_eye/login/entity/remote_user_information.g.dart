// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_user_information.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteUserInformation _$RemoteUserInformationFromJson(
        Map<String, dynamic> json) =>
    RemoteUserInformation(
      id: json['id'] as int? ?? -1,
      userName: json['userName'] as String? ?? '',
      fullName: json['fullName'] as String? ?? '',
      email: json['email'] as String? ?? '',
      mobile: json['mobile'] as String? ?? '',
      image: json['image'] as String? ?? '',
      status: json['status'] as bool? ?? false,
      otpStatus: json['otpStatus'] as bool? ?? false,
      subscriberId: json['subscriberId'] as int? ?? 0,
      contractDate: json['contractDate'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteUserInformationToJson(
        RemoteUserInformation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'fullName': instance.fullName,
      'email': instance.email,
      'mobile': instance.mobile,
      'image': instance.image,
      'status': instance.status,
      'otpStatus': instance.otpStatus,
      'subscriberId': instance.subscriberId,
      'contractDate': instance.contractDate,
    };
