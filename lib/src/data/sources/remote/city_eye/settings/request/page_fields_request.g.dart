// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_fields_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageFieldsRequest _$PageFieldsRequestFromJson(Map<String, dynamic> json) =>
    PageFieldsRequest(
      compoundId: json['compoundId'] as int,
      userTypeId: json['userTypeId'] as int,
      generalExtrafield: (json['generalExtrafield'] as List<dynamic>)
          .map((e) => PageCodeRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PageFieldsRequestToJson(PageFieldsRequest instance) =>
    <String, dynamic>{
      'compoundId': instance.compoundId,
      'userTypeId': instance.userTypeId,
      'generalExtrafield': instance.generalExtrafield,
    };
