import 'package:city_eye/src/data/sources/remote/city_eye/payment/entity/remote_payment_method.dart';
import 'package:city_eye/src/domain/entities/payment/payment_request_payment_methods.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_payment_request_payment_methods.g.dart';

@JsonSerializable()
class RemotePaymentRequestPaymentMethods {
  final int? id;
  final RemotePaymentMethod? paymentMethod;

  const RemotePaymentRequestPaymentMethods({
    this.id = 0,
    this.paymentMethod = const RemotePaymentMethod(),
  });

  factory RemotePaymentRequestPaymentMethods.fromJson(
          Map<String, dynamic> json) =>
      _$RemotePaymentRequestPaymentMethodsFromJson(json);

  Map<String, dynamic> toJson() =>
      _$RemotePaymentRequestPaymentMethodsToJson(this);

}

extension RemotePaymentRequestPaymentMethodsExtension
    on RemotePaymentRequestPaymentMethods {
  PaymentRequestPaymentMethods get mapToDomain {
    return PaymentRequestPaymentMethods(
      id: id ?? 0,
      paymentMethod: paymentMethod.mapToDomain,
      isSelected: false,
    );
  }
}

extension ListRemotePaymentRequestPaymentMethodsExtension
    on List<RemotePaymentRequestPaymentMethods> {
  List<PaymentRequestPaymentMethods> get mapToDomain {
    return map((e) => e.mapToDomain).toList();
  }
}
