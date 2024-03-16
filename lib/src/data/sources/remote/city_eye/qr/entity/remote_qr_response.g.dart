// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_qr_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteQrResponse _$RemoteQrResponseFromJson(Map<String, dynamic> json) =>
    RemoteQrResponse(
      questions: (json['questions'] as List<dynamic>?)
              ?.map((e) => RemoteQrQuestion.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      rules: (json['rules'] as List<dynamic>?)
              ?.map((e) => RemoteQrRule.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$RemoteQrResponseToJson(RemoteQrResponse instance) =>
    <String, dynamic>{
      'questions': instance.questions,
      'rules': instance.rules,
    };
