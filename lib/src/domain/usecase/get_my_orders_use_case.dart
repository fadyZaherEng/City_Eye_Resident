import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/request/my_orders_request.dart';
import 'package:city_eye/src/domain/entities/support/orders.dart';
import 'package:city_eye/src/domain/repositories/support_repository.dart';

class GetMyOrdersUseCase {
  final SupportRepository _supportRepository;

  GetMyOrdersUseCase(this._supportRepository);

  Future<DataState<List<Orders>>> call(MyOrdersRequest myOrdersRequest) async {
    return _supportRepository.getMyOrders(myOrdersRequest);
  }
}
