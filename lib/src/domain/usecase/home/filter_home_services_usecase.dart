import 'package:city_eye/src/domain/entities/home/home_service.dart';

final class FilterHomeServicesUseCase {
  List<HomeService> call(List<HomeService> homeServices) {
    List<HomeService> filteredHomeServices = [];
    filteredHomeServices =
        homeServices.where((service) => service.parentId == 0).toList();
    return filteredHomeServices;
  }
}
