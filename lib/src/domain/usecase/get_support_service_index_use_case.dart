import 'package:city_eye/src/domain/entities/home/home_support.dart';
import 'package:city_eye/src/domain/entities/support/support_service.dart';

class GetSupportServiceIndexUseCase {
  int call(List<HomeSupport> supportServices,
      HomeSupport selectedSupportService) {
    for (int i = 0; i < supportServices.length; i++) {
      if (supportServices[i].id == selectedSupportService.id) {
        return i;
      }
    }
    return 0;
  }
}
