import 'package:city_eye/src/data/sources/remote/city_eye/settings/entity/remote_compound_setting.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/entity/remote_list_of_multi_media_configuration.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/entity/remote_list_of_page_sections.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/entity/remote_list_social_media.dart';
import 'package:city_eye/src/domain/entities/settings/compound_configuration.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_compound_configration.g.dart';

@JsonSerializable(explicitToJson: true)
class RemoteCompoundConfigration {
  final List<RemoteListOfMultiMediaConfiguration>?
      listOfMultiMediaConfiguration;
  final List<RemoteListSocialMedia>? listSocialMedia;
  final List<RemoteListOfPageSections>? listOfPageSections;
  @JsonKey(name: 'compoundsetting')
  final RemoteCompoundSetting? compoundSetting;
  final int? vat;
  final int? tax;

  const RemoteCompoundConfigration({
    this.listOfMultiMediaConfiguration = const [],
    this.listSocialMedia = const [],
    this.listOfPageSections = const [],
    this.compoundSetting = const RemoteCompoundSetting(),
    this.vat = 0,
    this.tax = 0,
  });

  factory RemoteCompoundConfigration.fromJson(Map<String, dynamic> json) =>
      _$RemoteCompoundConfigrationFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteCompoundConfigrationToJson(this);
}

extension RemoteCompoundConfigrationExtension on RemoteCompoundConfigration? {
  CompoundConfiguration get mapToDomain => CompoundConfiguration(
        compoundSetting: this!.compoundSetting.mapToDomain,
        listOfMultiMediaConfiguration:
            this!.listOfMultiMediaConfiguration.mapToDomain,
        listOfPageSections: this!.listOfPageSections.mapToDomain,
        listSocialMedia: this!.listSocialMedia.mapToDomain,
        tax: this!.tax ?? 0,
        vat: this!.vat ?? 0,
      );
}
