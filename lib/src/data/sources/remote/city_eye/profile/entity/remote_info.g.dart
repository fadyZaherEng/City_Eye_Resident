// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteInfo _$RemoteInfoFromJson(Map<String, dynamic> json) => RemoteInfo(
      image: json['image'] as String? ?? "",
      name: json['name'] as String? ?? "",
      email: json['email'] as String? ?? "",
      mobileNumber: json['mobileNumber'] as String? ?? "",
      extraFields: (json['extraFields'] as List<dynamic>?)
              ?.map((e) => RemotePageField.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$RemoteInfoToJson(RemoteInfo instance) =>
    <String, dynamic>{
      'image': instance.image,
      'name': instance.name,
      'email': instance.email,
      'mobileNumber': instance.mobileNumber,
      'extraFields': instance.extraFields,
    };
