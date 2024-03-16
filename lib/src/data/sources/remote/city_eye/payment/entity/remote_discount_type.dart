
import 'package:city_eye/src/domain/entities/payment/discount_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_discount_type.g.dart';

@JsonSerializable()
class RemoteDiscountType {
  final int? id;
  final String? type;
  final String? code;

  const RemoteDiscountType({
    this.id = 0,
    this.type = "",
    this.code = "",
  });


  factory RemoteDiscountType.fromJson(Map<String, dynamic> json) =>
      _$RemoteDiscountTypeFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteDiscountTypeToJson(this);
}

extension RemoteDiscountTypeExtension on RemoteDiscountType {
  DiscountType get mapToDomain {
    return DiscountType(
      id: id ?? 0,
      type: type ?? "",
      code: code ?? "",
    );
  }
}