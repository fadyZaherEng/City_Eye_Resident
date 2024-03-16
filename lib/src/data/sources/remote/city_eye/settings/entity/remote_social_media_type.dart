import 'package:city_eye/src/domain/entities/settings/social_media_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_social_media_type.g.dart';

@JsonSerializable()
final class RemoteSocialMediaType {
  final int? id;
  final String? name;
  final String? code;
  final String? logo;

 const RemoteSocialMediaType({
    this.id = 0,
    this.name = "",
    this.code = "",
    this.logo = "",
  });

  factory RemoteSocialMediaType.fromJson(Map<String, dynamic> json) =>
      _$RemoteSocialMediaTypeFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteSocialMediaTypeToJson(this);
}

extension RemoteSocialMediaTypeExtension on RemoteSocialMediaType? {
  SocialMediaType get mapToDomain => SocialMediaType(
        id: this?.id ?? 0,
        code: this?.code ?? "",
        name: this?.name ?? "",
        logo: this?.logo ?? "",
      );
}
