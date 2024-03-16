import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/domain/entities/payment/payment.dart';
import 'package:city_eye/src/domain/repositories/payment_repository.dart';

final class GetPaymentsUseCase {
  final PaymentRepository _paymentRepository;

  GetPaymentsUseCase(this._paymentRepository);

  Future<DataState<List<Payment>>> call() async {
    return await _paymentRepository.getPayments();
  }
}
