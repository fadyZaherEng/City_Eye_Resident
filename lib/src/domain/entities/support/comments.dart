import 'package:city_eye/src/domain/entities/support/comment_user.dart';
import 'package:equatable/equatable.dart';

class Comments extends Equatable {
  final int id;
  final String message;
  final String date;
  final bool isImage;
  final CommentUser user;

  const Comments({
    this.id = 0,
    this.message = "",
    this.date = "",
    this.isImage = false,
    this.user = const CommentUser(),
  });

  @override
  List<Object?> get props => [
        id,
        message,
        date,
        isImage,
        user,
      ];
}
