// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_offers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteOffers _$RemoteOffersFromJson(Map<String, dynamic> json) => RemoteOffers(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? "",
      description: json['description'] as String? ?? "",
      iSRedirectUrl: json['iSRedirectURL'] as bool? ?? false,
      redirectUrl: json['redirectURL'] as String? ?? "",
      startDate: json['startDate'] as String? ?? "",
      endDate: json['endDate'] as String? ?? "",
      attachment: json['attachment'] as String? ?? "",
      remoteDestinationMobilePages: json['destinationMobilePages'] == null
          ? null
          : RemoteDestinationMobilePages.fromJson(
              json['destinationMobilePages'] as Map<String, dynamic>),
      destinationSourceId: json['destinationSourceId'] as int?,
    );

Map<String, dynamic> _$RemoteOffersToJson(RemoteOffers instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'iSRedirectURL': instance.iSRedirectUrl,
      'redirectURL': instance.redirectUrl,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'attachment': instance.attachment,
      'destinationMobilePages': instance.remoteDestinationMobilePages,
      'destinationSourceId': instance.destinationSourceId,
    };
