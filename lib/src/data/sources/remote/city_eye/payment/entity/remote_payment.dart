import 'package:city_eye/src/data/sources/remote/city_eye/payment/entity/remote_currency.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/payment/entity/remote_payment_details.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/payment/entity/remote_payment_method.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/payment/entity/remote_payment_request_payment_methods.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/payment/entity/remote_payment_source_type.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/payment/entity/remote_payment_status.dart';
import 'package:city_eye/src/domain/entities/payment/payment.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_payment.g.dart';

@JsonSerializable()
final class RemotePayment {
  final int? id;
  final String? title;
  final String? description;
  final double? amount;
  final double? discount;
  final double? totalamount;
  final String? paymentDate;
  final String? paymentRef;
  final String? paymentResponse;
  final String? paymentTransactionId;
  final String? invoiceNumber;
  final bool? isPaid;
  final String? paymentResponseDate;
  final String? createDate;
  final String? dueDate;
  final bool? isIncludeTax;
  final bool? isIncludeVat;
  final double? tax;
  final double? vat;
  final double? taxValue;
  final double? vatValue;
  final RemotePaymentSourceType paymentSourceType;
  final RemoteCurrency? currency;
  final RemotePaymentMethod? paymentMethod;
  final RemotePaymentStatus? paymentStatus;
  final List<RemotePaymentDetails>? paymentDetails;
  final List<RemotePaymentRequestPaymentMethods>? paymentRequestPaymentMethods;

  const RemotePayment({
    this.id = 0,
    this.title = "",
    this.description = "",
    this.amount = 0.0,
    this.discount = 0.0,
    this.totalamount = 0.0,
    this.paymentDate = "",
    this.paymentRef = "",
    this.invoiceNumber = "",
    this.paymentResponse = "",
    this.paymentTransactionId = "",
    this.isPaid = false,
    this.paymentResponseDate = "",
    this.createDate = "",
    this.dueDate = "",
    this.isIncludeTax = false,
    this.isIncludeVat = false,
    this.tax = 0.0,
    this.vat = 0.0,
    this.taxValue = 0.0,
    this.vatValue = 0.0,
    this.paymentSourceType = const RemotePaymentSourceType(),
    this.currency = const RemoteCurrency(),
    this.paymentMethod = const RemotePaymentMethod(),
    this.paymentStatus = const RemotePaymentStatus(),
    this.paymentDetails = const [],
    this.paymentRequestPaymentMethods = const [],
  });


  factory RemotePayment.fromJson(Map<String, dynamic> json) =>
      _$RemotePaymentFromJson(json);

  Map<String, dynamic> toJson() => _$RemotePaymentToJson(this);
}

extension RemotePaymentExtension on RemotePayment {
  Payment get mapToDomain {
    return Payment(
      id: id ?? 0,
      title: title ?? "",
      description: description ?? "",
      invoiceNumber: invoiceNumber ?? "",
      amount: amount ?? 0,
      discount: discount ?? 0,
      totalAmount: totalamount ?? 0,
      paymentDate: paymentDate ?? "",
      paymentRef: paymentRef ?? "",
      paymentResponse: paymentResponse ?? "",
      paymentTransactionId: paymentTransactionId ?? "",
      isPaid: isPaid ?? false,
      paymentResponseDate: paymentResponseDate ?? "",
      createDate: createDate ?? "",
      dueDate: dueDate ?? "",
      isIncludeTax: isIncludeTax ?? false,
      isIncludeVat: isIncludeVat ?? false,
      tax: tax ?? 0,
      vat: vat ?? 0,
      taxValue: taxValue ?? 0,
      vatValue: vatValue ?? 0,
      paymentSourceType: paymentSourceType.mapToDomain(),
      currency: (currency ?? const RemoteCurrency()).mapToDomain,
      paymentMethod: (paymentMethod ?? const RemotePaymentMethod()).mapToDomain,
      paymentStatus: (paymentStatus ?? const RemotePaymentStatus()).mapToDomain,
      paymentDetails: (paymentDetails ?? []).map((e) => e.mapToDomain).toList(),
      paymentRequestPaymentMethods: (paymentRequestPaymentMethods ?? []).mapToDomain,
    );
  }
}

extension ListRemotePaymentExtension on List<RemotePayment> {
  List<Payment> get mapToDomain {
    return map((e) => e.mapToDomain).toList();
  }
}
