import 'package:city_eye/src/domain/entities/settings/language.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_language.g.dart';

@JsonSerializable()
class RemoteLanguage {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'logo')
  final String? logo;

  const RemoteLanguage({
    this.id = 0,
    this.name = "",
    this.code = "",
    this.logo = "",
  });

  factory RemoteLanguage.fromJson(Map<String, dynamic> json) =>
      _$RemoteLanguageFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteLanguageToJson(this);
}

extension RemoteLanguageExtension on RemoteLanguage {
  Language mapToDomain() {
    return Language(
      id: id ?? 0,
      name: name ?? "",
      code: code ?? "",
      image: logo ?? "",
    );
  }
}

extension RemoteLanguagesExtension on List<RemoteLanguage>? {
  List<Language> mapToDomain() {
    return this?.map((e) => e.mapToDomain()).toList() ?? [];
  }
}
