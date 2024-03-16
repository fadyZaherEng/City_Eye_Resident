import 'package:equatable/equatable.dart';

class CommentUser extends Equatable {
  final int id;
  final String name;
  final String image;

  const CommentUser({
    this.id = 0,
    this.name = "",
    this.image = "",
  });

  @override
  List<Object?> get props => [
        id,
        name,
        image,
      ];
}
