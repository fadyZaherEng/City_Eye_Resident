
import 'package:city_eye/src/domain/entities/payment/payment_status.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_payment_status.g.dart';

@JsonSerializable()
class RemotePaymentStatus {
  final int? id;
  final String? name;
  final String? code;
  final String? extraValue1;

  const RemotePaymentStatus({
    this.id = 0,
    this.name = "",
    this.code = "",
    this.extraValue1 = "",
  });


  factory RemotePaymentStatus.fromJson(Map<String, dynamic> json) =>
      _$RemotePaymentStatusFromJson(json);

  Map<String, dynamic> toJson() => _$RemotePaymentStatusToJson(this);

}

extension RemotePaymentStatusExtension on RemotePaymentStatus {
  PaymentStatus get mapToDomain {
    return PaymentStatus(
      id: id ?? 0,
      name: name ?? "",
      code: code ?? "",
      extraValue1: extraValue1 ?? "",
    );
  }
}