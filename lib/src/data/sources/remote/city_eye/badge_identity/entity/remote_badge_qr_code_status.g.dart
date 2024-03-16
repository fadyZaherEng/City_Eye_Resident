// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_badge_qr_code_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteBadgeQrCodeStatus _$RemoteBadgeQrCodeStatusFromJson(
        Map<String, dynamic> json) =>
    RemoteBadgeQrCodeStatus(
      id: json['id'] as int? ?? 0,
      code: json['code'] as String? ?? "",
      name: json['name'] as String? ?? "",
      color: json['color'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteBadgeQrCodeStatusToJson(
        RemoteBadgeQrCodeStatus instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'color': instance.color,
    };
