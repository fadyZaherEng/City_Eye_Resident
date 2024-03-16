import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/service_details/request/submit_service_details_cart_request.dart';
import 'package:city_eye/src/domain/entities/service_details/submit_service_details_cart.dart';
import 'package:city_eye/src/domain/repositories/service_details_cart_repository.dart';

final class SubmitServiceDetailsCartUseCase {
  final ServiceDetailsCartRepository _serviceDetailsCartRepository;

  SubmitServiceDetailsCartUseCase(this._serviceDetailsCartRepository);

  Future<DataState<SubmitServiceDetailsCart>> call(
          List<SubmitServiceDetailsCartRequest>
              submitServiceDetailsCartRequest) async =>
      await _serviceDetailsCartRepository
          .submitServiceDetailsCart(submitServiceDetailsCartRequest);
}
