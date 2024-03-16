// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_qr_rule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteQrRule _$RemoteQrRuleFromJson(Map<String, dynamic> json) => RemoteQrRule(
      id: json['id'] as int? ?? 0,
      qrCodeConfigrationId: json['qrCodeConfigrationId'] as int? ?? 0,
      guestType: json['guestType'] == null
          ? const RemoteQrGuestType()
          : RemoteQrGuestType.fromJson(
              json['guestType'] as Map<String, dynamic>),
      rules: json['rules'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteQrRuleToJson(RemoteQrRule instance) =>
    <String, dynamic>{
      'id': instance.id,
      'qrCodeConfigrationId': instance.qrCodeConfigrationId,
      'guestType': instance.guestType,
      'rules': instance.rules,
    };
