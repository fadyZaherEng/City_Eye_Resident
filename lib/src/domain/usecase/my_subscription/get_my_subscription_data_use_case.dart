import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/domain/entities/services/my_subscription.dart';
import 'package:city_eye/src/domain/repositories/service_details_cart_repository.dart';

class GetMySubscriptionDataUseCase {
  final ServiceDetailsCartRepository _serviceRepository;

  GetMySubscriptionDataUseCase(this._serviceRepository);

  Future<DataState<List<MySubscription>>> call() async =>
      await _serviceRepository.getMySubscriptions();
}
