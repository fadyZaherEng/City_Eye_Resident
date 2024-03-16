import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/domain/entities/payment/payment_request_payment_methods.dart';
import 'package:city_eye/src/presentation/screens/payment_details/widgets/payment_method_bottom_sheet_widget.dart';
import 'package:city_eye/src/presentation/widgets/bottom_sheet_widget.dart';
import 'package:flutter/material.dart';

Future showPaymentMethodBottomSheet({
  required BuildContext context,
  required double height,
  required List<PaymentRequestPaymentMethods> paymentMethod,
  required Function(PaymentRequestPaymentMethods) onPaymentMethodSelected,
}) async {
  double getHeight(List<PaymentRequestPaymentMethods> paymentMethod, BuildContext context) {
    double height = 100;
    for (int i = 0; i < paymentMethod.length; i++) {
      height += 60;
    }

    if (height < MediaQuery.of(context).size.height * 0.7) {
      return height;
    }
    return MediaQuery.of(context).size.height * 0.7;
  }

  ScrollPhysics? getLanguageScrollPhysics(double height) {
    if (height < MediaQuery.of(context).size.height * 0.7) {
      return const NeverScrollableScrollPhysics();
    }
    return null;
  }

  return await showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    enableDrag: false,
    isScrollControlled: true,
    builder: (context) => Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: BottomSheetWidget(
        titleLabel: S.of(context).selectPaymentMethod,
        height: getHeight(paymentMethod, context),
        content: PaymentMethodBottomSheetWidget(
            paymentMethod: paymentMethod,
            onPaymentMethodSelected: onPaymentMethodSelected,
            scrollPhysics:
                getLanguageScrollPhysics(getHeight(paymentMethod, context))),
      ),
    ),
  );
}
