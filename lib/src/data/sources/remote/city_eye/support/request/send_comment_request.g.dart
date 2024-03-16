// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_comment_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendCommentRequest _$SendCommentRequestFromJson(Map<String, dynamic> json) =>
    SendCommentRequest(
      requestId: json['requestId'] as int,
      message: json['message'] as String,
      isImage: json['isImage'] as bool,
    );

Map<String, dynamic> _$SendCommentRequestToJson(SendCommentRequest instance) =>
    <String, dynamic>{
      'requestId': instance.requestId,
      'message': instance.message,
      'isImage': instance.isImage,
    };
