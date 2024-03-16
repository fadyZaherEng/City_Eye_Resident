import 'package:city_eye/src/domain/entities/service_details/service_details_cart.dart';

class MinusServiceDetailsUseCase {
  List<ServiceDetailsCart> call(
    List<ServiceDetailsCart> servicesDetailsCart,
    ServiceDetailsCart selectedServiceDetailsCart,
  ) {
    for (var i = 0; i < servicesDetailsCart.length; i++) {
      if (servicesDetailsCart[i].id == selectedServiceDetailsCart.id) {
        if (servicesDetailsCart[i].quantity > 0) {
          servicesDetailsCart[i] = servicesDetailsCart[i].copyWith(
            quantity: servicesDetailsCart[i].quantity - 1,
          );
          if (servicesDetailsCart[i].quantity == 0) {
            servicesDetailsCart[i] = servicesDetailsCart[i].copyWith(
              isSelected: false,
            );
            for (int j = 0;
                j < servicesDetailsCart[i].servicePackageQuestions.length;
                j++) {
              servicesDetailsCart[i].servicePackageQuestions[j] =
                  servicesDetailsCart[i]
                      .servicePackageQuestions[j]
                      .copyWith(value: null);
            }
          }
        }
        break;
      }
    }
    return servicesDetailsCart;
  }
}
