// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_lookup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteLookup _$RemoteLookupFromJson(Map<String, dynamic> json) => RemoteLookup(
      lookupCode: json['lookupCode'] as String? ?? "",
      files: (json['lookupFiles'] as List<dynamic>?)
              ?.map((e) => RemoteLookupFile.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$RemoteLookupToJson(RemoteLookup instance) =>
    <String, dynamic>{
      'lookupCode': instance.lookupCode,
      'lookupFiles': instance.files,
    };
