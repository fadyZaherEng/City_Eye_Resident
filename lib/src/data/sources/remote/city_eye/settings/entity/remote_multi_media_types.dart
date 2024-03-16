import 'package:city_eye/src/domain/entities/settings/multi_media_types.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_multi_media_types.g.dart';

@JsonSerializable()
final class RemoteMultiMediaTypes {
  final  int? id;
  final bool? isVisible;
  final String? code;

 const RemoteMultiMediaTypes({
    this.id = 0,
    this.isVisible = false,
    this.code = "",
  });

  factory RemoteMultiMediaTypes.fromJson(Map<String, dynamic> json) =>
      _$RemoteMultiMediaTypesFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteMultiMediaTypesToJson(this);
}

extension RemoteMultiMediaTypesExtension on RemoteMultiMediaTypes? {
  MultiMediaTypes get mapToDomain => MultiMediaTypes(
        id: this?.id ?? 0,
        code: this?.code ?? "",
        isVisible: this?.isVisible ?? false,
      );
}

extension ListRemoteMultiMediaTypesExtension on List<RemoteMultiMediaTypes>? {
  List<MultiMediaTypes> get mapToDomain => this!
      .map(
        (media) => media.mapToDomain,
      )
      .toList();
}
