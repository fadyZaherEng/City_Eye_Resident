// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_badge_identity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteBadgeIdentity _$RemoteBadgeIdentityFromJson(Map<String, dynamic> json) =>
    RemoteBadgeIdentity(
      id: json['id'] as int? ?? 0,
      qrImage: json['qrImage'] as String? ?? "",
      pinCode: json['pinCode'] as int? ?? 0,
      expiredDate: json['expiredDate'] as String? ?? "",
      users: json['users'] == null
          ? const RemoteBadgeUsers()
          : RemoteBadgeUsers.fromJson(json['users'] as Map<String, dynamic>),
      compoundUnits: json['compoundUnits'] == null
          ? const RemoteBadgeCompoundUnits()
          : RemoteBadgeCompoundUnits.fromJson(
              json['compoundUnits'] as Map<String, dynamic>),
      userType: json['userType'] == null
          ? const RemoteBadgeUserType()
          : RemoteBadgeUserType.fromJson(
              json['userType'] as Map<String, dynamic>),
      qrCodeStatus: json['qrCodeStatus'] == null
          ? const RemoteBadgeQrCodeStatus()
          : RemoteBadgeQrCodeStatus.fromJson(
              json['qrCodeStatus'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RemoteBadgeIdentityToJson(
        RemoteBadgeIdentity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'qrImage': instance.qrImage,
      'pinCode': instance.pinCode,
      'expiredDate': instance.expiredDate,
      'users': instance.users,
      'compoundUnits': instance.compoundUnits,
      'userType': instance.userType,
      'qrCodeStatus': instance.qrCodeStatus,
    };
