// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_qr_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteQrDetails _$RemoteQrDetailsFromJson(Map<String, dynamic> json) =>
    RemoteQrDetails(
      isValid: json['isValid'] as bool? ?? false,
      qrHistoryWithAnswer: json['qrCodeDetails'] == null
          ? const RemoteQrHistoryWithAnswer()
          : RemoteQrHistoryWithAnswer.fromJson(
              json['qrCodeDetails'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RemoteQrDetailsToJson(RemoteQrDetails instance) =>
    <String, dynamic>{
      'isValid': instance.isValid,
      'qrCodeDetails': instance.qrHistoryWithAnswer?.toJson(),
    };
