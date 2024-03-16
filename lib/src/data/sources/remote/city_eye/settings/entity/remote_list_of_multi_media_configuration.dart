import 'package:city_eye/src/data/sources/remote/city_eye/settings/entity/remote_compound_multi_media_configration_dto.dart';
import 'package:city_eye/src/domain/entities/settings/multi_media_configuration.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_list_of_multi_media_configuration.g.dart';

@JsonSerializable(explicitToJson: true)
final class RemoteListOfMultiMediaConfiguration {
 final int? id;
 final  int? pageId;
 final String? pageCode;
 final List<RemoteCompoundMultiMediaConfigrationDtos>?
      compoundMultiMediaConfigrationDtos;

 const RemoteListOfMultiMediaConfiguration({
    this.id = 0,
    this.pageId = 0,
    this.pageCode = "",
    this.compoundMultiMediaConfigrationDtos = const [],
  });

  factory RemoteListOfMultiMediaConfiguration.fromJson(
          Map<String, dynamic> json) =>
      _$RemoteListOfMultiMediaConfigurationFromJson(json);

  Map<String, dynamic> toJson() =>
      _$RemoteListOfMultiMediaConfigurationToJson(this);
}

extension RemoteListOfMultiMediaConfigurationExtension
    on RemoteListOfMultiMediaConfiguration? {
  MultiMediaConfiguration get mapToDomain =>
      MultiMediaConfiguration(
        id: this?.id ?? 0,
        pageCode: this?.pageCode ?? "",
        pageId: this?.pageId ?? 0,
        compoundMultiMediaConfiguration:
            this!.compoundMultiMediaConfigrationDtos.mapToDomain,
      );
}

extension RemoteListOfMultiMediaConfigurationDataExtension
    on List<RemoteListOfMultiMediaConfiguration>? {
  List<MultiMediaConfiguration> get mapToDomain =>
      this!.map((media) => media.mapToDomain).toList();
}
