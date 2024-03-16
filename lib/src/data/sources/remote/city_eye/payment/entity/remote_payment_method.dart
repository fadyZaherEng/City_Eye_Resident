import 'package:city_eye/src/domain/entities/payment/payment_method.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_payment_method.g.dart';

@JsonSerializable()
final class RemotePaymentMethod  {
  final int? id;
  final String? name;
  final String? code;

  const RemotePaymentMethod(
      {this.id = 0,
        this.name = "",
        this.code = ""});

  factory RemotePaymentMethod.fromJson(Map<String, dynamic> json) => _$RemotePaymentMethodFromJson(json);

  Map<String, dynamic> toJson() => _$RemotePaymentMethodToJson(this);
}


extension RemotePaymentMethodExtension on RemotePaymentMethod? {
  PaymentMethod get mapToDomain {
    return PaymentMethod(
      id: this?.id ?? 0,
      name: this?.name ?? "",
      code: this?.code ?? "",
    );
  }
}

extension RemotePaymentMethodsExtension on List<RemotePaymentMethod>? {
  List<PaymentMethod> get mapToDomain {
    return this?.map((paymentMethod) => paymentMethod.mapToDomain).toList() ?? [];
  }
}