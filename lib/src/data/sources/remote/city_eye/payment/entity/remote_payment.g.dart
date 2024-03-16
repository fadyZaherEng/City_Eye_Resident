// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemotePayment _$RemotePaymentFromJson(Map<String, dynamic> json) =>
    RemotePayment(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? "",
      description: json['description'] as String? ?? "",
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      discount: (json['discount'] as num?)?.toDouble() ?? 0.0,
      totalamount: (json['totalamount'] as num?)?.toDouble() ?? 0.0,
      paymentDate: json['paymentDate'] as String? ?? "",
      paymentRef: json['paymentRef'] as String? ?? "",
      invoiceNumber: json['invoiceNumber'] as String? ?? "",
      paymentResponse: json['paymentResponse'] as String? ?? "",
      paymentTransactionId: json['paymentTransactionId'] as String? ?? "",
      isPaid: json['isPaid'] as bool? ?? false,
      paymentResponseDate: json['paymentResponseDate'] as String? ?? "",
      createDate: json['createDate'] as String? ?? "",
      dueDate: json['dueDate'] as String? ?? "",
      isIncludeTax: json['isIncludeTax'] as bool? ?? false,
      isIncludeVat: json['isIncludeVat'] as bool? ?? false,
      tax: (json['tax'] as num?)?.toDouble() ?? 0.0,
      vat: (json['vat'] as num?)?.toDouble() ?? 0.0,
      taxValue: (json['taxValue'] as num?)?.toDouble() ?? 0.0,
      vatValue: (json['vatValue'] as num?)?.toDouble() ?? 0.0,
      paymentSourceType: json['paymentSourceType'] == null
          ? const RemotePaymentSourceType()
          : RemotePaymentSourceType.fromJson(
              json['paymentSourceType'] as Map<String, dynamic>),
      currency: json['currency'] == null
          ? const RemoteCurrency()
          : RemoteCurrency.fromJson(json['currency'] as Map<String, dynamic>),
      paymentMethod: json['paymentMethod'] == null
          ? const RemotePaymentMethod()
          : RemotePaymentMethod.fromJson(
              json['paymentMethod'] as Map<String, dynamic>),
      paymentStatus: json['paymentStatus'] == null
          ? const RemotePaymentStatus()
          : RemotePaymentStatus.fromJson(
              json['paymentStatus'] as Map<String, dynamic>),
      paymentDetails: (json['paymentDetails'] as List<dynamic>?)
              ?.map((e) =>
                  RemotePaymentDetails.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      paymentRequestPaymentMethods:
          (json['paymentRequestPaymentMethods'] as List<dynamic>?)
                  ?.map((e) => RemotePaymentRequestPaymentMethods.fromJson(
                      e as Map<String, dynamic>))
                  .toList() ??
              const [],
    );

Map<String, dynamic> _$RemotePaymentToJson(RemotePayment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'amount': instance.amount,
      'discount': instance.discount,
      'totalamount': instance.totalamount,
      'paymentDate': instance.paymentDate,
      'paymentRef': instance.paymentRef,
      'paymentResponse': instance.paymentResponse,
      'paymentTransactionId': instance.paymentTransactionId,
      'invoiceNumber': instance.invoiceNumber,
      'isPaid': instance.isPaid,
      'paymentResponseDate': instance.paymentResponseDate,
      'createDate': instance.createDate,
      'dueDate': instance.dueDate,
      'isIncludeTax': instance.isIncludeTax,
      'isIncludeVat': instance.isIncludeVat,
      'tax': instance.tax,
      'vat': instance.vat,
      'taxValue': instance.taxValue,
      'vatValue': instance.vatValue,
      'paymentSourceType': instance.paymentSourceType,
      'currency': instance.currency,
      'paymentMethod': instance.paymentMethod,
      'paymentStatus': instance.paymentStatus,
      'paymentDetails': instance.paymentDetails,
      'paymentRequestPaymentMethods': instance.paymentRequestPaymentMethods,
    };
