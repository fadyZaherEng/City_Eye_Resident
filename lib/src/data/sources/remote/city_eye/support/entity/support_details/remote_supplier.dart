import 'package:city_eye/src/domain/entities/support_details/supplier.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_supplier.g.dart';

@JsonSerializable()
class RemoteSupplier {
  final int? id;
  final String? name;
  final String? code;

  const RemoteSupplier({
    this.id = 0,
    this.name = "",
    this.code = "",
  });

  factory RemoteSupplier.fromJson(Map<String, dynamic> json) =>
      _$RemoteSupplierFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteSupplierToJson(this);
}

extension RemoteSupplierExtension on RemoteSupplier {
  Supplier mapToDomain() {
    return Supplier(
      id: id ?? 0,
      name: name ?? "",
      code: code ?? "",
    );
  }
}

extension RemoteSupplierListExtension on List<RemoteSupplier>? {
  List<Supplier> mapToDomain() {
    return this?.map((e) => e.mapToDomain()).toList() ?? [];
  }
}