// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submit_community_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmitCommunityRequest _$SubmitCommunityRequestFromJson(
        Map<String, dynamic> json) =>
    SubmitCommunityRequest(
      description: json['description'] as String,
      extraFieldAnswers: (json['extraFieldAnswers'] as List<dynamic>)
          .map((e) =>
              ExtraFieldAnswersRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubmitCommunityRequestToJson(
        SubmitCommunityRequest instance) =>
    <String, dynamic>{
      'description': instance.description,
      'extraFieldAnswers': instance.extraFieldAnswers,
    };
