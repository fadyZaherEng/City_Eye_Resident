import 'package:city_eye/src/data/sources/remote/city_eye/service_details/entity/remote_service_category.dart';
import 'package:city_eye/src/domain/entities/services/service_package.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_service_package.g.dart';

@JsonSerializable(explicitToJson: true)
final class RemoteServicePackages {
  final int? id;
  final String? name;
  final bool? isCountType;
  final RemoteServiceCategory? serviceCategory;

  const RemoteServicePackages({
    this.id = 0,
    this.name = "",
    this.isCountType = false,
    this.serviceCategory = const RemoteServiceCategory(),
  });

  factory RemoteServicePackages.fromJson(Map<String, dynamic> json) =>
      _$RemoteServicePackagesFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteServicePackagesToJson(this);
}

extension RemoteServicePackagesExtension on RemoteServicePackages {
  ServicePackages mapToDomain() {
    return ServicePackages(
      id: id ?? 0,
      name: name ?? "",
      isCountType: isCountType ?? false,
      serviceCategory: serviceCategory!.mapToDomain(),
    );
  }
}
