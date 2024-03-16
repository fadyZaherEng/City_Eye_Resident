// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_delegated_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteDelegatedRequest _$DeleteDelegatedRequestFromJson(
        Map<String, dynamic> json) =>
    DeleteDelegatedRequest(
      id: json['id'] as int,
      isEnabled: json['isEnabled'] as bool,
    );

Map<String, dynamic> _$DeleteDelegatedRequestToJson(
        DeleteDelegatedRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'isEnabled': instance.isEnabled,
    };
