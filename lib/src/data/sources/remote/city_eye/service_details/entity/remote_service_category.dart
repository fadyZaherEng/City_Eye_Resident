import 'package:city_eye/src/domain/entities/services/service_category.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_service_category.g.dart';

@JsonSerializable()
final class RemoteServiceCategory {
  final int? id;
  final String? name;
  final String? code;
  final String? logo;

  const RemoteServiceCategory({
    this.id = 0,
    this.name = "",
    this.code = "",
    this.logo = "",
  });

  factory RemoteServiceCategory.fromJson(Map<String, dynamic> json) =>
      _$RemoteServiceCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteServiceCategoryToJson(this);
}

extension RemoteServiceCategoryExtension on RemoteServiceCategory {
  ServiceCategory mapToDomain() {
    return ServiceCategory(
      id: id ?? 0,
      name: name ?? "",
      code: code ?? "",
      logo: logo ?? "",
    );
  }
}
