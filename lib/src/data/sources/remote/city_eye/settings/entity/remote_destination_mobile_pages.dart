import 'package:city_eye/src/domain/entities/offers/destination_mobile_pages.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_destination_mobile_pages.g.dart';

@JsonSerializable()
class RemoteDestinationMobilePages {
  final int? id;
  final String? name;
  final String? code;

  const RemoteDestinationMobilePages({
    this.id = 0,
    this.name = "",
    this.code = "",
  });

  factory RemoteDestinationMobilePages.fromJson(Map<String, dynamic> json) =>
      _$RemoteDestinationMobilePagesFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteDestinationMobilePagesToJson(this);
}

extension RemoteDestinationMobilePagesExtension
    on RemoteDestinationMobilePages {
  DestinationMobilePages mapToDomain() {
    return DestinationMobilePages(
      id: id ?? 0,
      name: name ?? "",
      code: code ?? "",
    );
  }
}
