import 'package:city_eye/src/domain/entities/service_details/service_details_cart.dart';

class AddServiceDetailsUseCase {
  List<ServiceDetailsCart> call(
    List<ServiceDetailsCart> servicesDetailsCart,
    ServiceDetailsCart selectedServiceDetailsCart,
  ) {
    for (var i = 0; i < servicesDetailsCart.length; i++) {
      if (servicesDetailsCart[i].id == selectedServiceDetailsCart.id) {
        servicesDetailsCart[i] = servicesDetailsCart[i].copyWith(
          isSelected: true,
          quantity: servicesDetailsCart[i].quantity + 1,
        );
        break;
      }
    }
    return servicesDetailsCart;
  }
}
