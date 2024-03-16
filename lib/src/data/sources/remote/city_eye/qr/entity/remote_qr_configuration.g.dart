// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_qr_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteQrConfiguration _$RemoteQrConfigurationFromJson(
        Map<String, dynamic> json) =>
    RemoteQrConfiguration(
      qrMessage: json['qrMessage'] as String? ?? "",
      guestTypes: (json['guestTypes'] as List<dynamic>?)
              ?.map((e) => RemoteGuestsType.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      qrCompoundConfiguration: json['compoundConfigration'] == null
          ? const RemoteQrCompoundConfiguration()
          : RemoteQrCompoundConfiguration.fromJson(
              json['compoundConfigration'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RemoteQrConfigurationToJson(
        RemoteQrConfiguration instance) =>
    <String, dynamic>{
      'qrMessage': instance.qrMessage,
      'guestTypes': instance.guestTypes,
      'compoundConfigration': instance.qrCompoundConfiguration,
    };
