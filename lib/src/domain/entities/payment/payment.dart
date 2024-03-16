import 'package:city_eye/src/domain/entities/payment/currency.dart';
import 'package:city_eye/src/domain/entities/payment/payment_details.dart';
import 'package:city_eye/src/domain/entities/payment/payment_method.dart';
import 'package:city_eye/src/domain/entities/payment/payment_request_payment_methods.dart';
import 'package:city_eye/src/domain/entities/payment/payment_source_type.dart';
import 'package:city_eye/src/domain/entities/payment/payment_status.dart';
import 'package:equatable/equatable.dart';

class Payment extends Equatable {
  final int id;
  final String title;
  final String description;
  final double amount;
  final double discount;
  final double totalAmount;
  final String paymentDate;
  final String paymentRef;
  final String paymentResponse;
  final String paymentTransactionId;
  final bool isPaid;
  final String paymentResponseDate;
  final String createDate;
  final String invoiceNumber;
  final String dueDate;
  final bool isIncludeTax;
  final bool isIncludeVat;
  final double tax;
  final double vat;
  final double taxValue;
  final double vatValue;
  final PaymentSourceType paymentSourceType;
  final Currency currency;
  final PaymentMethod paymentMethod;
  final PaymentStatus paymentStatus;
  final List<PaymentDetails> paymentDetails;
  final List<PaymentRequestPaymentMethods> paymentRequestPaymentMethods;

  const Payment({
    this.id = 0,
    this.title = "",
    this.description = "",
    this.invoiceNumber = "",
    this.amount = 0.0,
    this.discount = 0.0,
    this.totalAmount = 0.0,
    this.paymentDate = "",
    this.paymentRef = "",
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
    this.paymentSourceType = const PaymentSourceType(),
    this.currency = const Currency(),
    this.paymentMethod = const PaymentMethod(),
    this.paymentStatus = const PaymentStatus(),
    this.paymentDetails = const [],
    this.paymentRequestPaymentMethods = const [],
  });

  @override
  List<Object> get props => [
        id,
        title,
        description,
        amount,
        discount,
        totalAmount,
        paymentDate,
        paymentRef,
        paymentResponse,
        paymentTransactionId,
        isPaid,
        paymentResponseDate,
        createDate,
        dueDate,
        isIncludeTax,
        isIncludeVat,
        tax,
        vat,
        taxValue,
        vatValue,
        paymentSourceType,
        currency,
        paymentMethod,
        paymentStatus,
        paymentDetails,
        paymentRequestPaymentMethods,
      ];
}
