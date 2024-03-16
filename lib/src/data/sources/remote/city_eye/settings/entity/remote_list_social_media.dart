import 'package:city_eye/src/data/sources/remote/city_eye/settings/entity/remote_social_media_type.dart';
import 'package:city_eye/src/domain/entities/settings/compound_social_media.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_list_social_media.g.dart';

@JsonSerializable(explicitToJson: true)
class RemoteListSocialMedia {
  final int? id;
  final String? value;
  final RemoteSocialMediaType? socialMediaType;

  const RemoteListSocialMedia({
    this.id = 0,
    this.value = "",
    this.socialMediaType = const RemoteSocialMediaType(),
  });

  factory RemoteListSocialMedia.fromJson(Map<String, dynamic> json) =>
      _$RemoteListSocialMediaFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteListSocialMediaToJson(this);
}

extension RemoteListSocialMediaExtension on RemoteListSocialMedia? {
  CompoundSocialMedia get mapToDomain => CompoundSocialMedia(
        id: this?.id ?? 0,
        value: this?.value ?? "",
        socialMediaType: this!.socialMediaType.mapToDomain,
      );
}

extension RemoteListSocialMediaDataExtension on List<RemoteListSocialMedia>? {
  List<CompoundSocialMedia> get mapToDomain =>
      this!.map((socialMedia) => socialMedia.mapToDomain).toList();
}
