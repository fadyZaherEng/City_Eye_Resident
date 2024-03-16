// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_compound_configration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteCompoundConfigration _$RemoteCompoundConfigrationFromJson(
        Map<String, dynamic> json) =>
    RemoteCompoundConfigration(
      listOfMultiMediaConfiguration:
          (json['listOfMultiMediaConfiguration'] as List<dynamic>?)
                  ?.map((e) => RemoteListOfMultiMediaConfiguration.fromJson(
                      e as Map<String, dynamic>))
                  .toList() ??
              const [],
      listSocialMedia: (json['listSocialMedia'] as List<dynamic>?)
              ?.map((e) =>
                  RemoteListSocialMedia.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      listOfPageSections: (json['listOfPageSections'] as List<dynamic>?)
              ?.map((e) =>
                  RemoteListOfPageSections.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      compoundSetting: json['compoundsetting'] == null
          ? const RemoteCompoundSetting()
          : RemoteCompoundSetting.fromJson(
              json['compoundsetting'] as Map<String, dynamic>),
      vat: json['vat'] as int? ?? 0,
      tax: json['tax'] as int? ?? 0,
    );

Map<String, dynamic> _$RemoteCompoundConfigrationToJson(
        RemoteCompoundConfigration instance) =>
    <String, dynamic>{
      'listOfMultiMediaConfiguration': instance.listOfMultiMediaConfiguration
          ?.map((e) => e.toJson())
          .toList(),
      'listSocialMedia':
          instance.listSocialMedia?.map((e) => e.toJson()).toList(),
      'listOfPageSections':
          instance.listOfPageSections?.map((e) => e.toJson()).toList(),
      'compoundsetting': instance.compoundSetting?.toJson(),
      'vat': instance.vat,
      'tax': instance.tax,
    };
