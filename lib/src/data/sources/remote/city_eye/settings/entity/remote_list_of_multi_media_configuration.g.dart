// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_list_of_multi_media_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteListOfMultiMediaConfiguration
    _$RemoteListOfMultiMediaConfigurationFromJson(Map<String, dynamic> json) =>
        RemoteListOfMultiMediaConfiguration(
          id: json['id'] as int? ?? 0,
          pageId: json['pageId'] as int? ?? 0,
          pageCode: json['pageCode'] as String? ?? "",
          compoundMultiMediaConfigrationDtos:
              (json['compoundMultiMediaConfigrationDtos'] as List<dynamic>?)
                      ?.map((e) =>
                          RemoteCompoundMultiMediaConfigrationDtos.fromJson(
                              e as Map<String, dynamic>))
                      .toList() ??
                  const [],
        );

Map<String, dynamic> _$RemoteListOfMultiMediaConfigurationToJson(
        RemoteListOfMultiMediaConfiguration instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pageId': instance.pageId,
      'pageCode': instance.pageCode,
      'compoundMultiMediaConfigrationDtos': instance
          .compoundMultiMediaConfigrationDtos
          ?.map((e) => e.toJson())
          .toList(),
    };
