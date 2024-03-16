// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deactivate_qr_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeactivateQrRequest _$DeactivateQrRequestFromJson(Map<String, dynamic> json) =>
    DeactivateQrRequest(
      id: json['qrId'] as int,
      isEnabled: json['isEnabled'] as bool,
    );

Map<String, dynamic> _$DeactivateQrRequestToJson(
        DeactivateQrRequest instance) =>
    <String, dynamic>{
      'qrId': instance.id,
      'isEnabled': instance.isEnabled,
    };
