// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_create_qr_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteCreateQrResponse _$RemoteCreateQrResponseFromJson(
        Map<String, dynamic> json) =>
    RemoteCreateQrResponse(
      qrId: json['qrId'] as int? ?? 0,
      qrImage: json['qrImage'] as String? ?? "",
      qrPdf: json['qrPdf'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteCreateQrResponseToJson(
        RemoteCreateQrResponse instance) =>
    <String, dynamic>{
      'qrId': instance.qrId,
      'qrImage': instance.qrImage,
      'qrPdf': instance.qrPdf,
    };
