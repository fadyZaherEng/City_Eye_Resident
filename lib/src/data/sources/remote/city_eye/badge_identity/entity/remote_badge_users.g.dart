// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_badge_users.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteBadgeUsers _$RemoteBadgeUsersFromJson(Map<String, dynamic> json) =>
    RemoteBadgeUsers(
      id: json['id'] as int? ?? 0,
      fullName: json['fullName'] as String? ?? "",
      userName: json['userName'] as String? ?? "",
      mobile: json['mobile'] as String? ?? "",
      email: json['email'] as String? ?? "",
      subscriberId: json['subscriberId'] as int? ?? 0,
      image: json['image'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteBadgeUsersToJson(RemoteBadgeUsers instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'userName': instance.userName,
      'mobile': instance.mobile,
      'email': instance.email,
      'subscriberId': instance.subscriberId,
      'image': instance.image,
    };
