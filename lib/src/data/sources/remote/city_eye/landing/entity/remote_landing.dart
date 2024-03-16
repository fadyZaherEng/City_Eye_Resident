import 'package:city_eye/src/data/sources/remote/city_eye/landing/entity/remote_feature.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/landing/entity/remote_partner.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/landing/entity/remote_social_media.dart';
import 'package:city_eye/src/domain/entities/landing/landing.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_landing.g.dart';

@JsonSerializable()
class RemoteLanding {
  @JsonKey(name: 'partners')
  final List<RemotePartner>? partners;
  @JsonKey(name: 'features')
  final List<RemoteFeature>? features;
  @JsonKey(name: 'socialMedia')
  final List<RemoteSocialMedia>? socialMedia;

  const RemoteLanding({
    this.partners = const [],
    this.features = const [],
    this.socialMedia = const [],
  });

  factory RemoteLanding.fromJson(Map<String, dynamic> json) =>
      _$RemoteLandingFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteLandingToJson(this);
}

extension RemoteLandingExtension on RemoteLanding {
  Landing mapToDomain() {
    return Landing(
      partners: (partners ?? []).mapToDomain(),
      features: (features ?? []).mapToDomain(),
      socialMedia: (socialMedia ?? []).mapToDomain(),
    );
  }
}
