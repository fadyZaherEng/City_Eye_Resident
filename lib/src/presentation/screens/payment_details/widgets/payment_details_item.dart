import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/domain/entities/payment/payment_details.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class PaymentDetailsItem extends StatelessWidget {
  final PaymentDetails paymentDetails;
  final String currency;

  const PaymentDetailsItem(
      {required this.paymentDetails, required this.currency, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Text(paymentDetails.itemName,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: ColorSchemes.gray,
                        fontSize: 14,
                        letterSpacing: -0.24,
                      )),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(S.of(context).quantity,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ColorSchemes.gray,
                      fontSize: 14,
                      letterSpacing: -0.24,
                    )),
            Visibility(
              visible: paymentDetails.discountValue != 0,
              child: Text(
                  "${paymentDetails.subTotal - paymentDetails.discountValue} $currency",
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: ColorSchemes.black,
                        letterSpacing: -0.24,
                      )),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                Directionality.of(context) == TextDirection.rtl
                    ? "\u200E${paymentDetails.unitPrice.toString()} x ${paymentDetails.quantity.toString()}"
                    : "${paymentDetails.quantity.toString()} x ${paymentDetails.unitPrice.toString()}",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ColorSchemes.black,
                      fontSize: 14,
                      letterSpacing: -0.24,
                    )),
            Text(
                "${(paymentDetails.quantity * paymentDetails.unitPrice).toString()} $currency",
                textAlign: TextAlign.end,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: ColorSchemes.gray,
                      decoration: paymentDetails.discountValue == 0
                          ? null
                          : TextDecoration.lineThrough,
                      letterSpacing: -0.24,
                    )),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: Text(paymentDetails.itemDescription,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: ColorSchemes.gray, letterSpacing: -0.24, height: 1.5)),
        ),
        const SizedBox(height: 16),
        const DottedLine(
          dashColor: ColorSchemes.gray,
          dashGapLength: 4,
          dashLength: 4,
          lineThickness: 1,
          direction: Axis.horizontal,
        ),
      ],
    );
  }
}
