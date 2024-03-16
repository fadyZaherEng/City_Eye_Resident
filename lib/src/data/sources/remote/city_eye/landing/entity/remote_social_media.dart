import 'package:city_eye/src/domain/entities/landing/social_media.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_social_media.g.dart';

@JsonSerializable()
class RemoteSocialMedia {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'logo')
  final String? logo;
  @JsonKey(name: 'extraValue1')
  final String? extraValueOne;
  @JsonKey(name: 'extraValue2')
  final String? extraValueTwo;
  @JsonKey(name: 'parentId')
  final int? parentId;
  @JsonKey(name: 'sortNo')
  final int? sortNo;

  const RemoteSocialMedia({
    this.id = 0,
    this.name = "",
    this.code = "",
    this.logo = "",
    this.extraValueOne = "",
    this.extraValueTwo = "",
    this.parentId = 0,
    this.sortNo = 0,
  });

  factory RemoteSocialMedia.fromJson(Map<String, dynamic> json) =>
      _$RemoteSocialMediaFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteSocialMediaToJson(this);
}

extension RemoteSocialMediaExtension on RemoteSocialMedia {
  SocialMedia mapToDomain() {
    return SocialMedia(
      id: id ?? 0,
      name: name ?? "",
      code: code ?? "",
      logo: logo ?? "",
      extraValueOne: extraValueOne ?? "",
      extraValueTwo: extraValueTwo ?? "",
      parentId: parentId ?? 0,
      sortNumber: sortNo ?? 0,
    );
  }
}

extension RemoteFeatureListExtension on List<RemoteSocialMedia>? {
  List<SocialMedia> mapToDomain() {
    return this?.map((e) => e.mapToDomain()).toList() ?? [];
  }
}
