import 'package:city_eye/src/domain/entities/landing/feature.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_feature.g.dart';

@JsonSerializable()
class RemoteFeature {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'logo')
  final String? logo;
  @JsonKey(name: 'description')
  final String? description;

  const RemoteFeature({
    this.id = 0,
    this.name = "",
    this.description = "",
    this.logo = "",
  });

  factory RemoteFeature.fromJson(Map<String, dynamic> json) =>
      _$RemoteFeatureFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteFeatureToJson(this);
}

extension RemoteFeatureExtension on RemoteFeature {
  Feature mapToDomain() {
    return Feature(
      id: id ?? 0,
      name: name ?? "",
      description: description ?? "",
      logo: logo ?? "",
    );
  }
}

extension RemoteFeatureListExtension on List<RemoteFeature>? {
  List<Feature> mapToDomain() {
    return this?.map((e) => e.mapToDomain()).toList() ?? [];
  }
}
