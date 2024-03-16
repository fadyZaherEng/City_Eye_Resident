import 'package:city_eye/src/data/sources/remote/city_eye/support/entity/remote_comment_user.dart';
import 'package:city_eye/src/domain/entities/support/comments.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_comments.g.dart';

@JsonSerializable()
class RemoteComments {
  final int id;
  final String message;
  final String date;
  final bool isImage;
  final RemoteCommentUser user;

  const RemoteComments({
    this.id = 0,
    this.message = "",
    this.date = "",
    this.isImage = false,
    this.user = const RemoteCommentUser(),
  });

  factory RemoteComments.fromJson(Map<String, dynamic> json) =>
      _$RemoteCommentsFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteCommentsToJson(this);
}

extension RemoteCommentsExtension on RemoteComments {
  Comments mapToDomain() {
    return Comments(
      id: id,
      message: message,
      date: date,
      isImage: isImage,
      user: user.mapToDomain(),
    );
  }
}

extension RemoteCommentsListExtension on List<RemoteComments>? {
  List<Comments> mapToDomain() {
    return this?.map((e) => e.mapToDomain()).toList() ?? [];
  }
}