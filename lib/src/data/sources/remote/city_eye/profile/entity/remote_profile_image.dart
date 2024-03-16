import 'package:city_eye/src/domain/entities/profile/profile_image.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_profile_image.g.dart';

@JsonSerializable()
class RemoteProfileImage {
  @JsonKey(name: 'image')
  final String? image;

  const RemoteProfileImage({
    this.image = "",
  });

  factory RemoteProfileImage.fromJson(Map<String, dynamic> json) =>
      _$RemoteProfileImageFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteProfileImageToJson(this);
}

extension RemoteProfileImageExtension on RemoteProfileImage {
  ProfileImage mapToDomain() {
    return ProfileImage(
      image: image ?? "",
    );
  }
}


