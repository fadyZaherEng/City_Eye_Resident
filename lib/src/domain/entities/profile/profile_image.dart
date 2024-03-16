import 'package:equatable/equatable.dart';

class ProfileImage extends Equatable {
  final String image;

  const ProfileImage({
    this.image = "",
  });


  ProfileImage copyWith({
    String? image,
  }) {
    return ProfileImage(
      image: image ?? this.image,
    );
  }

  @override
  List<Object?> get props => [
    image,
  ];
}
