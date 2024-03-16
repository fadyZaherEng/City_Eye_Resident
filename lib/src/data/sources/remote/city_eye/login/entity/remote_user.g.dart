// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteUser _$RemoteUserFromJson(Map<String, dynamic> json) => RemoteUser(
      userInformation: json['userInfo'] == null
          ? const RemoteUserInformation()
          : RemoteUserInformation.fromJson(
              json['userInfo'] as Map<String, dynamic>),
      units: (json['unitLists'] as List<dynamic>?)
              ?.map((e) => RemoteUserUnit.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      token: json['token'] as String? ?? '',
      userDeviceInfo: json['userDeviceInfo'] == null
          ? const RemoteUserDeviceInfo()
          : RemoteUserDeviceInfo.fromJson(
              json['userDeviceInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RemoteUserToJson(RemoteUser instance) =>
    <String, dynamic>{
      'userInfo': instance.userInformation,
      'unitLists': instance.units,
      'token': instance.token,
      'userDeviceInfo': instance.userDeviceInfo,
    };
