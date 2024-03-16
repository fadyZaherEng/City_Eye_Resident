import 'package:json_annotation/json_annotation.dart';

part 'send_comment_request.g.dart';

@JsonSerializable()
class SendCommentRequest {
  final int requestId;
  final String message;
  final bool isImage;

  SendCommentRequest({
    required this.requestId,
    required this.message,
    required this.isImage,
  });

  factory SendCommentRequest.fromJson(Map<String, dynamic> json) =>
      _$SendCommentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SendCommentRequestToJson(this);

  Map<String, dynamic> toMap() {
    return {
      'requestId': requestId,
      'message': message,
      'isImage': isImage,
    };
  }

  factory SendCommentRequest.fromMap(Map<String, dynamic> map) {
    return SendCommentRequest(
      requestId: map['requestId'] as int,
      message: map['message'] as String,
      isImage: map['isImage'] as bool,
    );
  }
}