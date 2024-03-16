import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/payment/request/payment_details_request.dart';
import 'package:city_eye/src/domain/entities/payment/payment.dart';
import 'package:city_eye/src/domain/repositories/payment_repository.dart';

final class GetPaymentDetailsUseCase {
  final PaymentRepository _paymentRepository;

  GetPaymentDetailsUseCase(this._paymentRepository);

  Future<DataState<Payment>> call(
      PaymentDetailsRequest paymentDetailsRequest) async {
    return await _paymentRepository.getPaymentDetails(paymentDetailsRequest);
  }
}
