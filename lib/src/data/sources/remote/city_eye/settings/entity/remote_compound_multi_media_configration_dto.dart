import 'package:city_eye/src/data/sources/remote/city_eye/settings/entity/remote_compound_multi_media_configration_dto_multi_media_type.dart';
import 'package:city_eye/src/domain/entities/settings/compound_multi_media_configuration.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_compound_multi_media_configration_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class RemoteCompoundMultiMediaConfigrationDtos {
  final int? id;
  final bool? isVisible;
  final int? minCount;
  final int? maxCount;
  final int? maxTime;
  final int? maxSize;
  final bool? isMulti;
  final RemoteCompoundMultiMediaConfigrationDtoMultiMediaType? multiMediaType;

  const RemoteCompoundMultiMediaConfigrationDtos({
    this.id = 0,
    this.isVisible = false,
    this.minCount = 0,
    this.maxCount = 0,
    this.maxTime = 0,
    this.maxSize = 0,
    this.isMulti = false,
    this.multiMediaType =
        const RemoteCompoundMultiMediaConfigrationDtoMultiMediaType(),
  });

  factory RemoteCompoundMultiMediaConfigrationDtos.fromJson(
          Map<String, dynamic> json) =>
      _$RemoteCompoundMultiMediaConfigrationDtosFromJson(json);

  Map<String, dynamic> toJson() =>
      _$RemoteCompoundMultiMediaConfigrationDtosToJson(this);
}

extension RemoteCompoundMultiMediaConfigrationDtoExtension
    on RemoteCompoundMultiMediaConfigrationDtos? {
  CompoundMultiMediaConfiguration get mapToDomain =>
      CompoundMultiMediaConfiguration(
        id: this?.id ?? 0,
        isVisible: this?.isVisible ?? false,
        isMulti: this?.isMulti ?? false,
        maxCount: this?.maxCount ?? 0,
        maxSize: this?.maxSize ?? 0,
        maxTime: this?.maxTime ?? 0,
        minCount: this?.minCount ?? 0,
        multiMediaType: this!.multiMediaType.mapToDomain,
      );
}

extension ListRemoteCompoundMultiMediaConfigrationDtoExtension
    on List<RemoteCompoundMultiMediaConfigrationDtos>? {
  List<CompoundMultiMediaConfiguration> get mapToDomain =>
      this!.map((media) => media.mapToDomain).toList();
}
