import 'package:city_eye/src/domain/entities/settings/multi_media_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_compound_multi_media_configration_dto_multi_media_type.g.dart';

@JsonSerializable()
final class RemoteCompoundMultiMediaConfigrationDtoMultiMediaType {
  final int? id;
  final String? code;
  final String? logo;

  const RemoteCompoundMultiMediaConfigrationDtoMultiMediaType({
    this.id = 0,
    this.code = "",
    this.logo = "",
  });

  factory RemoteCompoundMultiMediaConfigrationDtoMultiMediaType.fromJson(
          Map<String, dynamic> json) =>
      _$RemoteCompoundMultiMediaConfigrationDtoMultiMediaTypeFromJson(json);

  Map<String, dynamic> toJson() =>
      _$RemoteCompoundMultiMediaConfigrationDtoMultiMediaTypeToJson(this);
}

extension RemoteCompoundMultiMediaConfigrationDtoMultiMediaTypeExtension
    on RemoteCompoundMultiMediaConfigrationDtoMultiMediaType? {
  MultiMediaType get mapToDomain =>
      MultiMediaType(
        id: this?.id ?? 0,
        code: this?.code ?? "",
        logo: this?.logo ?? "",
      );
}
