import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/domain/entities/service_details/service_details_cart.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class CartListItem extends StatelessWidget {
  final ServiceDetailsCart servicesDetailsCart;
  final String compoundCurrency;

  const CartListItem(
      {required this.servicesDetailsCart,
      required this.compoundCurrency,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const DottedLine(
          dashColor: ColorSchemes.gray,
          dashGapLength: 4,
          dashLength: 4,
          lineThickness: 1,
        ),
        const SizedBox(height: 16),
        Text(
          servicesDetailsCart.name,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                letterSpacing: -0.24,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
        ),
        const SizedBox(height: 16),
        Text(
          servicesDetailsCart.description,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: ColorSchemes.black,
                letterSpacing: -0.24,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).totalOfServices,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: ColorSchemes.gray,
                        letterSpacing: -0.24,
                        fontWeight: FontWeight.w400,
                      ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: servicesDetailsCart.quantity > 1,
                      child: Row(
                        children: [
                          Text(
                            "${servicesDetailsCart.quantity} x",
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: ColorSchemes.black,
                                      letterSpacing: -0.24,
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                          const SizedBox(width: 4),
                        ],
                      ),
                    ),
                    Text(
                      servicesDetailsCart.price.toString() + compoundCurrency,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            letterSpacing: -0.24,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).total,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: ColorSchemes.gray,
                        letterSpacing: -0.24,
                        fontWeight: FontWeight.w400,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  "${servicesDetailsCart.quantity * servicesDetailsCart.price} $compoundCurrency",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: ColorSchemes.black,
                        letterSpacing: -0.24,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
