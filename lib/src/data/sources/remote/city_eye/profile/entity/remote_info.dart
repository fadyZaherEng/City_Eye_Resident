import 'package:city_eye/src/data/sources/remote/city_eye/settings/entity/remote_page_field.dart';
import 'package:city_eye/src/domain/entities/profile/info.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_info.g.dart';

@JsonSerializable()
class RemoteInfo {
  @JsonKey(name: 'image')
  final String? image;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'mobileNumber')
  final String? mobileNumber;
  @JsonKey(name: 'extraFields')
  final List<RemotePageField>? extraFields;

  const RemoteInfo({
    this.image = "",
    this.name = "",
    this.email = "",
    this.mobileNumber = "",
    this.extraFields = const [],
  });


  factory RemoteInfo.fromJson(Map<String, dynamic> json) =>
      _$RemoteInfoFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteInfoToJson(this);
}

extension RemoteInfoExtension on RemoteInfo {
  Info mapToDomain() {
    return Info(
      image: image ?? "",
      name: name ?? "",
      email: email ?? "",
      mobileNumber: mobileNumber ?? "",
      fields: extraFields?.map((e) => e.mapToDomain()).toList() ?? [],
    );
  }
}