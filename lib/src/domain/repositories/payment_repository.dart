import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/payment/request/payment_details_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/payment/request/payment_request.dart';
import 'package:city_eye/src/domain/entities/payment/payment.dart';

abstract interface class PaymentRepository {
  Future<DataState<List<Payment>>> getPayments();

  Future<DataState<String>> getPaymentUrl(PaymentRequest paymentRequest);

  Future<DataState<Payment>> getPaymentDetails(PaymentDetailsRequest paymentDetailsRequest);
}
