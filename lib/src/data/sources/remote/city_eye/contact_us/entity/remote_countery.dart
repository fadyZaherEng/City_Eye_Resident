import 'package:city_eye/src/domain/entities/contact_us/country.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_countery.g.dart';

@JsonSerializable()
class RemoteCountry {
  final int? id;
  final String? name;
  final String? code;
  final String? extraValue1;
  final String? extraValue2;
  final int? parentId;
  final String? logo;
  final int? sortNo;

  RemoteCountry({
    this.id = 0,
    this.name = "",
    this.code = "",
    this.extraValue1 = "",
    this.extraValue2 = "",
    this.parentId = 0,
    this.logo = "",
    this.sortNo = 0,
  });

  factory RemoteCountry.fromJson(Map<String, dynamic> json) =>
      _$RemoteCountryFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteCountryToJson(this);
}

extension RemoteCountryExtension on RemoteCountry {
  Country get mapToDomain {
    return Country(
      id: id ?? 0,
      name: name ?? "",
      code: code ?? "",
      extraValue1: extraValue1 ?? "",
      extraValue2: extraValue2 ?? "",
      parentId: parentId ?? 0,
      logo: logo ?? "",
      sortNo: sortNo ?? 0,
    );
  }
}

extension RemoteCountriesExtension on List<RemoteCountry>? {
  List<Country> get mapToDomain {
    return this!.map((country) => country.mapToDomain).toList();
  }
}
