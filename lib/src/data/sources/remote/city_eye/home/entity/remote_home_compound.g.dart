// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_home_compound.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteHomeCompound _$RemoteHomeCompoundFromJson(Map<String, dynamic> json) =>
    RemoteHomeCompound(
      homeSections: (json['homeSections'] as List<dynamic>?)
              ?.map((e) =>
                  RemoteHomeCompoundItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      supportCategorys: (json['supportCategorys'] as List<dynamic>?)
              ?.map(
                  (e) => RemoteHomeSupport.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      servicesCategorys: (json['servicesCategorys'] as List<dynamic>?)
              ?.map(
                  (e) => RemoteHomeService.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      events: (json['events'] as List<dynamic>?)
              ?.map((e) => RemoteEvent.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      surveys: (json['surveys'] as List<dynamic>?)
              ?.map((e) => RemoteSurvey.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      extraFieldEvents: (json['extraFieldEvents'] as List<dynamic>?)
              ?.map((e) => RemoteExtraField.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$RemoteHomeCompoundToJson(RemoteHomeCompound instance) =>
    <String, dynamic>{
      'homeSections': instance.homeSections,
      'supportCategorys': instance.supportCategorys,
      'servicesCategorys': instance.servicesCategorys,
      'events': instance.events,
      'surveys': instance.surveys,
      'extraFieldEvents': instance.extraFieldEvents,
    };
