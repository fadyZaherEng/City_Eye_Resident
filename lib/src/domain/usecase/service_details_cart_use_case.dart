import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/service_details/request/service_details_cart_request.dart';
import 'package:city_eye/src/domain/entities/service_details/service_details_cart.dart';
import 'package:city_eye/src/domain/repositories/service_details_cart_repository.dart';

final class ServiceDetailsCartUseCase {
  final ServiceDetailsCartRepository _servicePackageRepository;

  ServiceDetailsCartUseCase(this._servicePackageRepository);

  Future<DataState<List<ServiceDetailsCart>>> call(
          ServiceDetailsCartRequest request) async =>
      await _servicePackageRepository.getServicePackages(request);
}
