// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_type_qr_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteTypeQrHistory _$RemoteTypeQrHistoryFromJson(Map<String, dynamic> json) =>
    RemoteTypeQrHistory(
      id: json['id'] as int? ?? 0,
      code: json['code'] as String? ?? "",
      name: json['name'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteTypeQrHistoryToJson(
        RemoteTypeQrHistory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
    };
