import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/request/order_cancel_request.dart';
import 'package:city_eye/src/domain/repositories/support_repository.dart';

class MyOrderCancelUseCase {
  final SupportRepository _supportRepository;

  MyOrderCancelUseCase(this._supportRepository);

  Future<DataState> call(OrderCancelRequest orderCancelRequest) async {
    return await _supportRepository.cancelOrder(orderCancelRequest);
  }
}