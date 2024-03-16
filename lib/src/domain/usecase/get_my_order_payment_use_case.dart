import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/request/payment_url_request.dart';
import 'package:city_eye/src/domain/entities/support/payment_url.dart';
import 'package:city_eye/src/domain/repositories/support_repository.dart';

class GetMyOrdersPaymentUseCase {
  final SupportRepository _supportRepository;

  GetMyOrdersPaymentUseCase(this._supportRepository);

  Future<DataState<PaymentUrl>> call(
      PaymentUrlRequest paymentUrlRequest) async {
    return _supportRepository.getPaymentUrl(paymentUrlRequest);
  }
}
