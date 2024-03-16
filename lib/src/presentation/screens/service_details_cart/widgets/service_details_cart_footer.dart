import 'package:city_eye/flavors.dart';
import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/presentation/widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';

class ServiceDetailsCartFooter extends StatelessWidget {
  final double totalPrice;
  final String currency;
  final Function() onContinueTap;

  const ServiceDetailsCartFooter({
    Key? key,
    required this.totalPrice,
    required this.currency,
    required this.onContinueTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: ColorSchemes.white,
      child: Column(
        children: [
          const SizedBox(
            height: 26,
          ),
          Row(
            children: [
              Text(
                S.of(context).total,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ColorSchemes.black,
                      letterSpacing: -0.24,
                    ),
              ),
              const Expanded(child: SizedBox()),
              Text(
                "${totalPrice.toStringAsFixed(3)} $currency",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: ColorSchemes.black,
                      letterSpacing: -0.24,
                    ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          CustomButtonWidget(
            onTap: () {
              onContinueTap();
            },
            text: S.of(context).continuee,
            width: double.infinity,
            height: 50,
            backgroundColor: F.isNiceTouch
                ? ColorSchemes.ghadeerDarkBlue
                : ColorSchemes.primary,
          ),
        ],
      ),
    );
  }
}
