import 'dart:developer';

import 'package:city_eye/src/domain/entities/home/home_service.dart';

final class FilterHomeServicesForSpecificServiceUseCase {
  List<HomeService> call(
      List<HomeService> homeServices, HomeService homeService) {
    List<HomeService> filteredHomeServices = [];
    filteredHomeServices = homeServices
        .where((service) => service.parentId == homeService.id)
        .toList();
    return filteredHomeServices;
  }
}
