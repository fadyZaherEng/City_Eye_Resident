import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/payment/request/payment_request.dart';
import 'package:city_eye/src/domain/repositories/payment_repository.dart';

final class GetPaymentUrlUseCase {
  final PaymentRepository _paymentRepository;

  GetPaymentUrlUseCase(this._paymentRepository);

  Future<DataState<String>> call(PaymentRequest paymentRequest) async {
    return await _paymentRepository.getPaymentUrl(paymentRequest);
  }
}
