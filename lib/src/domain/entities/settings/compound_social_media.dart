import 'package:city_eye/src/domain/entities/settings/social_media_type.dart';
import 'package:equatable/equatable.dart';

class CompoundSocialMedia extends Equatable {
  final int id;
  final String value;
  final SocialMediaType socialMediaType;

  const CompoundSocialMedia({
    this.id = 0,
    this.value = "",
    this.socialMediaType = const SocialMediaType(),
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'value': value,
      'socialMediaType': socialMediaType.toMap()
    };
  }

  factory CompoundSocialMedia.fromMap(Map<String, dynamic> map) {
    return CompoundSocialMedia(
      id: map['id'] as int,
      value: map['value'] as String,
      socialMediaType: SocialMediaType.fromMap(map['socialMediaType']),
    );
  }

  @override
  List<Object> get props => [
        id,
        value,
        socialMediaType,
      ];
}
