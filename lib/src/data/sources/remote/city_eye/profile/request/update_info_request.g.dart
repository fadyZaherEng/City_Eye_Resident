// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_info_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateInfoRequest _$UpdateInfoRequestFromJson(Map<String, dynamic> json) =>
    UpdateInfoRequest(
      name: json['name'] as String,
      email: json['email'] as String,
      mobileNumber: json['mobileNumber'] as String,
      extraFields: (json['extraFields'] as List<dynamic>)
          .map((e) => InfoFileRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UpdateInfoRequestToJson(UpdateInfoRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'mobileNumber': instance.mobileNumber,
      'extraFields': instance.extraFields,
    };
