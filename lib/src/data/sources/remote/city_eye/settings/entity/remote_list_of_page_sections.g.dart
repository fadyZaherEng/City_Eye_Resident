// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_list_of_page_sections.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteListOfPageSections _$RemoteListOfPageSectionsFromJson(
        Map<String, dynamic> json) =>
    RemoteListOfPageSections(
      id: json['id'] as int? ?? 0,
      pageId: json['pageId'] as int? ?? 0,
      pageCode: json['pageCode'] as String? ?? "",
      multiMediaTypes: (json['multiMediaTypes'] as List<dynamic>?)
              ?.map((e) =>
                  RemoteMultiMediaTypes.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$RemoteListOfPageSectionsToJson(
        RemoteListOfPageSections instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pageId': instance.pageId,
      'pageCode': instance.pageCode,
      'multiMediaTypes':
          instance.multiMediaTypes?.map((e) => e.toJson()).toList(),
    };
