import 'package:city_eye/src/domain/entities/service_details/service_details_cart.dart';

class GetTotalPriceUseCase {
  double call(
    List<ServiceDetailsCart> servicesDetailsCart,
  ) {
    double totalPrice = 0;
    for (var i = 0; i < servicesDetailsCart.length; i++) {
      totalPrice += servicesDetailsCart[i].price * servicesDetailsCart[i].quantity;
    }
    return totalPrice;
  }
}
