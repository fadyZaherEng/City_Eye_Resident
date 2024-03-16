// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemotePage _$RemotePageFromJson(Map<String, dynamic> json) => RemotePage(
      pageCode: json['pageCode'] as String? ?? "",
      fields: (json['extraFieldDtos'] as List<dynamic>?)
              ?.map((e) => RemotePageField.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$RemotePageToJson(RemotePage instance) =>
    <String, dynamic>{
      'pageCode': instance.pageCode,
      'extraFieldDtos': instance.fields,
    };
