import 'package:city_eye/src/domain/entities/support/category.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_category.g.dart';

@JsonSerializable()
class RemoteCategory {
  final int? id;
  final String? code;
  final String? name;
  final String? logo;

  const RemoteCategory({
    this.id = 0,
    this.code = "",
    this.name = "",
    this.logo = "",
  });

  factory RemoteCategory.fromJson(Map<String, dynamic> json) =>
      _$RemoteCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteCategoryToJson(this);
}

extension CategoryExtension on RemoteCategory {
  Category mapToDomain() {
    return Category(
      id: id ?? 0,
      code: code ?? "",
      name: name ?? "",
      logo: logo ?? "",
    );
  }
}
