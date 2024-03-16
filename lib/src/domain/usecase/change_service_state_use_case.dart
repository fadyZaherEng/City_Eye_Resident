import 'package:city_eye/src/domain/entities/service_details/service_details_cart.dart';

class ChangeServiceStateUseCase {
  List<ServiceDetailsCart> call(
    List<ServiceDetailsCart> servicesDetailsCart,
    ServiceDetailsCart selectedServiceDetailsCart,
  ) {
    for (var i = 0; i < servicesDetailsCart.length; i++) {
      if (servicesDetailsCart[i].id == selectedServiceDetailsCart.id) {
        if (servicesDetailsCart[i].isSelected) {
          servicesDetailsCart[i] = servicesDetailsCart[i].copyWith(
            isSelected: false,
            quantity: 0,
            totalPrice: 0.0,
          );

          for (int j = 0;
              j < servicesDetailsCart[i].servicePackageQuestions.length;
              j++) {
            servicesDetailsCart[i].servicePackageQuestions[j] =
                servicesDetailsCart[i].servicePackageQuestions[j].copyWith(
                      value: "",
                      choices: servicesDetailsCart[i]
                          .servicePackageQuestions[j]
                          .choices
                          .map(
                        (choice) {
                          return choice.copyWith(
                            isSelected: false,
                          );
                        },
                      ).toList(),
                    );
          }
        } else {
          servicesDetailsCart[i] = servicesDetailsCart[i].copyWith(
            isSelected: true,
            quantity: 1,
            totalPrice: servicesDetailsCart[i].price.toDouble(),
          );
        }
        break;
      }
    }
    return servicesDetailsCart;
  }
}
