import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/constants.dart';
import 'package:city_eye/src/domain/entities/payment/payment_request_payment_methods.dart';
import 'package:city_eye/src/presentation/widgets/custom_radio_button_widget.dart';
import 'package:flutter/material.dart';

class PaymentMethodBottomSheetWidget extends StatelessWidget {
  final List<PaymentRequestPaymentMethods> paymentMethod;
  final Function(PaymentRequestPaymentMethods) onPaymentMethodSelected;
  final ScrollPhysics? scrollPhysics;

  const PaymentMethodBottomSheetWidget({
    Key? key,
    required this.paymentMethod,
    required this.onPaymentMethodSelected,
    this.scrollPhysics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: scrollPhysics,
      itemCount: paymentMethod.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            InkWell(
              onTap: () => onPaymentMethodSelected(paymentMethod[index]),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: Image.network(
                        paymentMethod[index].paymentMethod.name,
                        width: 24,
                        height: 24,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            ImagePaths.flagPlaceHolder,
                            fit: BoxFit.fill,
                            width: 24,
                            height: 24,
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      paymentMethod[index].paymentMethod.name,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: Constants.fontWeightRegular,
                            letterSpacing: -0.24,
                            color: paymentMethod[index].isSelected
                                ? ColorSchemes.primary
                                : ColorSchemes.gray,
                          ),
                    ),
                    const Expanded(child: SizedBox()),
                    CustomRadioButtonWidget(
                      isSelected: paymentMethod[index].isSelected,
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: index != paymentMethod.length - 1,
              child: Container(
                height: 0.6,
                width: double.infinity,
                color: ColorSchemes.border,
              ),
            )
          ],
        );
      },
    );
  }
}
