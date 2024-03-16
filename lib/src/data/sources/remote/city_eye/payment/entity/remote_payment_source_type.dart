import 'package:city_eye/src/domain/entities/payment/payment_source_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_payment_source_type.g.dart';

@JsonSerializable()
class RemotePaymentSourceType {
  final int? id;
  final String? name;
  final String? code;

  const RemotePaymentSourceType({
    this.id = 0,
    this.name = "",
    this.code = "",
  });

  factory RemotePaymentSourceType.fromJson(Map<String, dynamic> json) =>
      _$RemotePaymentSourceTypeFromJson(json);

  Map<String, dynamic> toJson() => _$RemotePaymentSourceTypeToJson(this);

}

extension RemotePaymentSourceTypeExtension on RemotePaymentSourceType {
  PaymentSourceType mapToDomain() => PaymentSourceType(
        id: id ?? 0,
        name: name ?? "",
        code: code ?? "",
      );
}
