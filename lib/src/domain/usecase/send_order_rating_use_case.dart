import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/request/order_rating_request.dart';
import 'package:city_eye/src/domain/repositories/support_repository.dart';

class SendOrderRatingUseCase {
  final SupportRepository _supportRepository;

  SendOrderRatingUseCase(this._supportRepository);

  Future<DataState> call(OrderRatingRequest orderRatingRequest) async {
    return await _supportRepository.sendOrderRating(orderRatingRequest);
  }
}
