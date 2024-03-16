import 'package:city_eye/src/domain/entities/support/comment_user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_comment_user.g.dart';

@JsonSerializable()
class RemoteCommentUser {
  final int? id;
  final String? name;
  final String? image;

  const RemoteCommentUser({
    this.id = 0,
    this.name = "",
    this.image = "",
  });

  factory RemoteCommentUser.fromJson(Map<String, dynamic> json) =>
      _$RemoteCommentUserFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteCommentUserToJson(this);
}

extension CategoryExtension on RemoteCommentUser {
  CommentUser mapToDomain() {
    return CommentUser(
      id: id ?? 0,
      name: name ?? "",
      image: image ?? "",
    );
  }
}
