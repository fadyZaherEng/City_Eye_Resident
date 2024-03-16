import 'package:json_annotation/json_annotation.dart';


part 'comments_request.g.dart';

@JsonSerializable()
class CommentsRequest {
  final int requestId;

  CommentsRequest({
    required this.requestId,
  });

  factory CommentsRequest.fromJson(Map<String, dynamic> json) => _$CommentsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CommentsRequestToJson(this);
}
