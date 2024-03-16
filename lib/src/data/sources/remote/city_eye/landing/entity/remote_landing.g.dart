// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_landing.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteLanding _$RemoteLandingFromJson(Map<String, dynamic> json) =>
    RemoteLanding(
      partners: (json['partners'] as List<dynamic>?)
              ?.map((e) => RemotePartner.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      features: (json['features'] as List<dynamic>?)
              ?.map((e) => RemoteFeature.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      socialMedia: (json['socialMedia'] as List<dynamic>?)
              ?.map(
                  (e) => RemoteSocialMedia.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$RemoteLandingToJson(RemoteLanding instance) =>
    <String, dynamic>{
      'partners': instance.partners,
      'features': instance.features,
      'socialMedia': instance.socialMedia,
    };
