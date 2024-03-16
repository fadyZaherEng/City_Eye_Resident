// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'compound_units_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompoundUnitsRequest _$CompoundUnitsRequestFromJson(
        Map<String, dynamic> json) =>
    CompoundUnitsRequest(
      userTypeId: json['userTypeId'] as int,
      compoundId: json['compoundId'] as int,
    );

Map<String, dynamic> _$CompoundUnitsRequestToJson(
        CompoundUnitsRequest instance) =>
    <String, dynamic>{
      'userTypeId': instance.userTypeId,
      'compoundId': instance.compoundId,
    };
