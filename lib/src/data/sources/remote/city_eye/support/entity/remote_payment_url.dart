import 'package:city_eye/src/domain/entities/support/payment_url.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_payment_url.g.dart';

@JsonSerializable()
class RemotePaymentUrl {
  final String? paymentUrl;

  const RemotePaymentUrl({
    this.paymentUrl = "",
  });

  factory RemotePaymentUrl.fromJson(Map<String, dynamic> json) => _$RemotePaymentUrlFromJson(json);

  Map<String, dynamic> toJson() => _$RemotePaymentUrlToJson(this);

}

extension RemotePaymentUrlX on RemotePaymentUrl {
  PaymentUrl mapToDomain() {
    return PaymentUrl(
      paymentUrl: paymentUrl ?? "",
    );
  }
}