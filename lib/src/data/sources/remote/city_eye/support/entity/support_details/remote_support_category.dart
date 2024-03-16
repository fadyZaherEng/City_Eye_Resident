import 'package:city_eye/src/data/sources/remote/city_eye/support/entity/support_details/remote_rules.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/entity/support_details/remote_supplier.dart';
import 'package:city_eye/src/domain/entities/support_details/support_category.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_support_category.g.dart';

@JsonSerializable()
class RemoteSupportCategory {
  final int? id;
  final String? name;
  final String? code;
  final bool? isSupplier;
  final RemoteSupplier? supplier;
  final RemoteRules? rules;

  const RemoteSupportCategory({
    this.id = 0,
    this.name = "",
    this.code = "",
    this.isSupplier = false,
    this.supplier = const RemoteSupplier(),
    this.rules = const RemoteRules(),
  });

  factory RemoteSupportCategory.fromJson(Map<String, dynamic> json) =>
      _$RemoteSupportCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteSupportCategoryToJson(this);
}

extension SupportCategoryExtension on RemoteSupportCategory {
  SupportCategory mapToDomain() {
    return SupportCategory(
      id: id ?? 0,
      name: name ?? "",
      code: code ?? "",
      isSupplier: isSupplier ?? false,
      supplier: (supplier ?? const RemoteSupplier()).mapToDomain(),
      rules: (rules ?? const RemoteRules()).mapToDomain(),
    );
  }
}

extension SupportCategoryListExtension on List<RemoteSupportCategory>? {
  List<SupportCategory> mapToDomain() {
    return this?.map((e) => e.mapToDomain()).toList() ?? [];
  }
}
