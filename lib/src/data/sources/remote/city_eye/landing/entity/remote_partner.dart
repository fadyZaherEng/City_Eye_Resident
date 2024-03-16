import 'package:city_eye/src/domain/entities/landing/partner.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_partner.g.dart';

@JsonSerializable()
class RemotePartner {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'mobile')
  final String? mobile;
  @JsonKey(name: 'logo')
  final String? logo;
  @JsonKey(name: 'description')
  final String? description;

  const RemotePartner({
    this.id = 0,
    this.name = "",
    this.code = "",
    this.mobile = "",
    this.logo = "",
    this.description = "",
  });

  factory RemotePartner.fromJson(Map<String, dynamic> json) =>
      _$RemotePartnerFromJson(json);

  Map<String, dynamic> toJson() => _$RemotePartnerToJson(this);
}

extension RemotePartnerExtension on RemotePartner {
  Partner mapToDomain() {
    return Partner(
      id: id ?? 0,
      name: name ?? "",
      description: description ?? "",
      logo: logo ?? "",
    );
  }
}

extension RemotePartnerListExtension on List<RemotePartner>? {
  List<Partner> mapToDomain() {
    return this?.map((e) => e.mapToDomain()).toList() ?? [];
  }
}
