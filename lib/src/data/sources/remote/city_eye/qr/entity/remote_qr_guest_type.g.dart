// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_qr_guest_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteQrGuestType _$RemoteQrGuestTypeFromJson(Map<String, dynamic> json) =>
    RemoteQrGuestType(
      id: json['id'] as int? ?? 0,
      code: json['code'] as String? ?? "",
      name: json['name'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteQrGuestTypeToJson(RemoteQrGuestType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
    };
