import 'package:city_eye/src/domain/entities/service_details/service_details_cart.dart';
import 'package:city_eye/src/domain/entities/settings/compound_currency.dart';
import 'package:city_eye/src/presentation/screens/service_details_cart/widgets/service_details_cart_item.dart';
import 'package:flutter/material.dart';

class ServicesDetailsCartWidget extends StatelessWidget {
  final List<ServiceDetailsCart> servicesDetailsCart;
  final Function(ServiceDetailsCart) onServiceDetailsCartChanged;
  final Function(ServiceDetailsCart) onAddTab;
  final Function(ServiceDetailsCart) onMinusTab;
  final CompoundCurrency currency;
  final Function(ServiceDetailsCart) openQuestions;

  const ServicesDetailsCartWidget({
    Key? key,
    required this.servicesDetailsCart,
    required this.onServiceDetailsCartChanged,
    required this.onAddTab,
    required this.onMinusTab,
    required this.currency,
    required this.openQuestions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: servicesDetailsCart.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              openQuestions(servicesDetailsCart[index]);
            },
            child: ServiceDetailsCartItem(
              serviceDetailsCart: servicesDetailsCart[index],
              onServiceDetailsCartChanged: onServiceDetailsCartChanged,
              onAddTab: onAddTab,
              onMinusTab: onMinusTab,
              currency: currency,
            ),
          );
        },
      ),
    );
  }
}
