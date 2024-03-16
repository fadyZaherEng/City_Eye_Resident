import 'package:city_eye/src/domain/entities/settings/compound_setting.dart';
import 'package:city_eye/src/domain/entities/settings/multi_media_configuration.dart';
import 'package:city_eye/src/domain/entities/settings/page_section.dart';
import 'package:city_eye/src/domain/entities/settings/compound_social_media.dart';
import 'package:equatable/equatable.dart';

final class CompoundConfiguration extends Equatable {
  final List<MultiMediaConfiguration> listOfMultiMediaConfiguration;
  final List<CompoundSocialMedia> listSocialMedia;
  final List<PageSection> listOfPageSections;
  final CompoundSetting compoundSetting;
  final int vat;
  final int tax;

  const CompoundConfiguration({
    this.listOfMultiMediaConfiguration = const [],
    this.listSocialMedia = const [],
    this.listOfPageSections = const [],
    this.compoundSetting = const CompoundSetting(),
    this.vat = 0,
    this.tax = 0,
  });

  @override
  List<Object?> get props => [
        listOfMultiMediaConfiguration,
        listSocialMedia,
        listOfPageSections,
        compoundSetting,
        vat,
        tax,
      ];

  Map<String, dynamic> toMap() {
    return {
      'listOfMultiMediaConfiguration':
          listOfMultiMediaConfiguration.map((e) => e.toMap()).toList(),
      'listSocialMedia': listSocialMedia.map((e) => e.toMap()).toList(),
      'listOfPageSections': listOfPageSections.map((e) => e.toMap()).toList(),
      'compoundSetting': compoundSetting.toMap(),
      'vat': vat,
      'tax': tax,
    };
  }

  factory CompoundConfiguration.fromMap(Map<String, dynamic> map) {
    return CompoundConfiguration(
      listOfMultiMediaConfiguration: List<MultiMediaConfiguration>.from(
          map['listOfMultiMediaConfiguration']
              ?.map((x) => MultiMediaConfiguration.fromMap(x))),
      listSocialMedia: List<CompoundSocialMedia>.from(
          map['listSocialMedia']?.map((x) => CompoundSocialMedia.fromMap(x))),
      listOfPageSections: List<PageSection>.from(
          map['listOfPageSections']?.map((x) => PageSection.fromMap(x))),
      compoundSetting: CompoundSetting.fromMap(map['compoundSetting']),
      vat: map['vat'] as int,
      tax: map['tax'] as int,
    );
  }
}
