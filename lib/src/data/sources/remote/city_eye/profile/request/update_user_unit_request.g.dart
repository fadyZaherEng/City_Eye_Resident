// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_unit_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateUserUnitRequest _$UpdateUserUnitRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateUserUnitRequest(
      id: json['id'] as int,
      gazNo: json['gasNo'] as String,
      telephone: json['telephone'] as String,
    );

Map<String, dynamic> _$UpdateUserUnitRequestToJson(
        UpdateUserUnitRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'gasNo': instance.gazNo,
      'telephone': instance.telephone,
    };
