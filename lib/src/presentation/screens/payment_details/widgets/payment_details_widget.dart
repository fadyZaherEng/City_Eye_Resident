import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/utils/convert_timestamp_to_date_format.dart';
import 'package:city_eye/src/core/utils/english_numbers.dart';
import 'package:city_eye/src/core/utils/extensions/color_extension.dart';
import 'package:city_eye/src/core/utils/payments_key.dart';
import 'package:city_eye/src/domain/entities/payment/payment.dart';
import 'package:city_eye/src/presentation/screens/payment_details/widgets/payment_details_item.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:super_banners/super_banners.dart';

class PaymentDetailsWidget extends StatelessWidget {
  final Payment payment;

  const PaymentDetailsWidget({super.key, required this.payment});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        alignment: Directionality.of(context) == TextDirection.ltr
            ? Alignment.topLeft
            : Alignment.topRight,
        children: [
          Directionality(
            textDirection: Directionality.of(context),
            child: CornerBanner(
              bannerPosition: Directionality.of(context) == TextDirection.ltr
                  ? CornerBannerPosition.topLeft
                  : CornerBannerPosition.topRight,
              bannerColor: payment.paymentStatus.extraValue1.toColor(),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 2,
                ),
                child: Text(payment.paymentStatus.name,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: ColorSchemes.white,
                          fontSize: 14,
                          letterSpacing: -0.24,
                        )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    const Expanded(child: SizedBox(width: 20)),
                    Text(S.of(context).invoice,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: ColorSchemes.gray,
                              fontSize: 14,
                              letterSpacing: -0.24,
                            )),
                    SizedBox(
                      width: 140,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(payment.invoiceNumber.toString(),
                            textAlign: TextAlign.end,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: ColorSchemes.black,
                                  fontSize: 14,
                                  letterSpacing: -0.24,
                                )),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Expanded(child: SizedBox(width: 20)),
                    Text(S.of(context).invoiceForm,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: ColorSchemes.gray,
                              fontSize: 14,
                              letterSpacing: -0.24,
                            )),
                    SizedBox(
                      width: 140,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(payment.paymentSourceType.name,
                            textAlign: TextAlign.end,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: ColorSchemes.black,
                                  fontSize: 14,
                                  letterSpacing: -0.24,
                                )),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Expanded(child: SizedBox(width: 20)),
                    Text(S.of(context).dueDate,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: ColorSchemes.gray,
                              fontSize: 14,
                              letterSpacing: -0.24,
                            )),
                    SizedBox(
                      width: 140,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                            englishNumbers(convertTimestampToDateIntoFormat(
                                payment.dueDate)),
                            textAlign: TextAlign.end,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: ColorSchemes.black,
                                  fontSize: 14,
                                  letterSpacing: -0.24,
                                )),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Expanded(child: SizedBox(width: 20)),
                    Text(S.of(context).invoiceDate,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: ColorSchemes.gray,
                              fontSize: 14,
                              letterSpacing: -0.24,
                            )),
                    SizedBox(
                      width: 140,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                            englishNumbers(convertTimestampToDateIntoFormat(
                                payment.createDate)),
                            textAlign: TextAlign.end,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: ColorSchemes.black,
                                  fontSize: 14,
                                  letterSpacing: -0.24,
                                )),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const DottedLine(
                  dashColor: ColorSchemes.gray,
                  dashGapLength: 4,
                  dashLength: 4,
                  lineThickness: 1,
                  direction: Axis.horizontal,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: payment.paymentDetails.length,
                  itemBuilder: (context, index) {
                    return PaymentDetailsItem(
                      paymentDetails: payment.paymentDetails[index],
                      currency: payment.currency.code,
                    );
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(S.of(context).subtotal,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: ColorSchemes.black,
                              letterSpacing: -0.24,
                            )),
                    Text(
                        "${payment.amount.toString()} ${payment.currency.code}",
                        textAlign: TextAlign.end,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: ColorSchemes.black,
                              letterSpacing: -0.24,
                            )),
                  ],
                ),
                const SizedBox(height: 8),
                Visibility(
                  visible: payment.isIncludeTax,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              "${S.of(context).tax21} (${payment.tax.toString()} %)",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: ColorSchemes.gray,
                                    letterSpacing: -0.24,
                                  )),
                          Text(
                              "${payment.taxValue.toString()} ${payment.currency.code}",
                              textAlign: TextAlign.end,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color: ColorSchemes.black,
                                    letterSpacing: -0.24,
                                  )),
                        ],
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
                Visibility(
                  visible: payment.isIncludeVat,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              "${S.of(context).vat14} (${payment.vat.toString()} %)",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: ColorSchemes.gray,
                                    letterSpacing: -0.24,
                                  )),
                          Text(
                              "${payment.vatValue.toString()} ${payment.currency.code}",
                              textAlign: TextAlign.end,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color: ColorSchemes.black,
                                    letterSpacing: -0.24,
                                  )),
                        ],
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(S.of(context).discount,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: ColorSchemes.gray,
                              letterSpacing: -0.24,
                            )),
                    Text(
                        "${payment.discount.toString()} ${payment.currency.code}",
                        textAlign: TextAlign.end,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: ColorSchemes.black,
                              letterSpacing: -0.24,
                            )),
                  ],
                ),
                const SizedBox(height: 12),
                const DottedLine(
                  dashColor: ColorSchemes.gray,
                  dashGapLength: 4,
                  dashLength: 4,
                  lineThickness: 1,
                  direction: Axis.horizontal,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(S.of(context).total,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: ColorSchemes.black,
                              letterSpacing: -0.24,
                            )),
                    Text(
                        "${payment.totalAmount.toString()} ${payment.currency.code}",
                        textAlign: TextAlign.end,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: ColorSchemes.black,
                              fontSize: 18,
                              letterSpacing: -0.24,
                            )),
                  ],
                ),
                if (payment.paymentStatus.code == PaymentsKey.paid) ...[
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).paymentMethod,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: ColorSchemes.black,
                          letterSpacing: -0.24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        payment.paymentMethod.name,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: ColorSchemes.black,
                              letterSpacing: -0.24,
                            ),
                      )
                    ],
                  ),
                ],
                const SizedBox(height: 80),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
