import 'package:city_eye/flavors.dart';
import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/show_snack_bar.dart';
import 'package:city_eye/src/domain/entities/home/home_service.dart';
import 'package:city_eye/src/domain/entities/service_details/service_details_cart.dart';
import 'package:city_eye/src/presentation/screens/my_cart/widgets/cart_list_item.dart';
import 'package:city_eye/src/presentation/widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

class MyCartWidget extends StatefulWidget {
  final List<ServiceDetailsCart> servicesDetailsCart;
  final HomeService serviceDetails;
  final Function(String) onApplyButtonPressed;
  final Function() onCheckNowButtonPressed;
  final String compoundCurrency;
  final String parentServiceName;

  const MyCartWidget(
      {required this.parentServiceName,
      required this.servicesDetailsCart,
      required this.serviceDetails,
      required this.onApplyButtonPressed,
      required this.onCheckNowButtonPressed,
      required this.compoundCurrency,
      super.key});

  @override
  State<MyCartWidget> createState() => _MyCartWidgetState();
}

class _MyCartWidgetState extends State<MyCartWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: ColorSchemes.paymentCardColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    widget.parentServiceName,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 48),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 75,
                      height: 75,
                      decoration: BoxDecoration(
                        color: ColorSchemes.paymentCardColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: SvgPicture.asset(
                          ImagePaths.homeClean,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text(
                            widget.serviceDetails.name,
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: ColorSchemes.black,
                                      letterSpacing: -0.24,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "#35432 ", // TODO: Replace with text from API
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: ColorSchemes.black,
                                    letterSpacing: -0.24,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14),
                          ),
                          const SizedBox(height: 8),
                          RatingBar.builder(
                            initialRating: 3,
                            minRating: 1,
                            direction: Axis.horizontal,
                            itemPadding: const EdgeInsets.symmetric(
                                horizontal: 2, vertical: 0),
                            itemCount: 5,
                            itemSize: 12,
                            ignoreGestures: true,
                            allowHalfRating: false,
                            itemBuilder: (context, index) {
                              if (index < 3) {
                                return SvgPicture.asset(
                                  ImagePaths.ratingStarYellow,
                                  width: 8,
                                  height: 8,
                                  fit: BoxFit.scaleDown,
                                );
                              } else {
                                return SvgPicture.asset(
                                  ImagePaths.ratingStarGrey,
                                  width: 8,
                                  height: 8,
                                  fit: BoxFit.scaleDown,
                                );
                              }
                            },
                            onRatingUpdate: (rating) {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: widget.servicesDetailsCart.length,
                  itemBuilder: (context, index) {
                    return CartListItem(
                      compoundCurrency: widget.compoundCurrency,
                      servicesDetailsCart: widget.servicesDetailsCart[index],
                    );
                  },
                ),
              ],
            ),
          ),
          Container(
            height: 2,
            color: ColorSchemes.greyDivider,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Text(
                  S.of(context).getDiscount,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: ColorSchemes.black,
                        letterSpacing: -0.24,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 24),
                disCountWidget(),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Container(
            height: 2,
            color: ColorSchemes.greyDivider,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Text(
                  S.of(context).paymentSummery,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: ColorSchemes.black,
                        letterSpacing: -0.24,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(S.of(context).subtotal,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: ColorSchemes.black,
                              letterSpacing: -0.24,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            )),
                    Text(getSubTotal() + widget.compoundCurrency,
                        textAlign: TextAlign.end,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: ColorSchemes.black,
                              letterSpacing: -0.24,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            )),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${S.of(context).tax} (${21} %)",
                        // TODO: Replace 21 to percent from API
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: ColorSchemes.gray,
                              letterSpacing: -0.24,
                            )),
                    Text("1680.00 KWD", // TODO: Replace with text from API
                        textAlign: TextAlign.end,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: ColorSchemes.black,
                              letterSpacing: -0.24,
                            )),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${S.of(context).vat} (${14} %)",
                        // TODO: Replace 14 to percent from API
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: ColorSchemes.gray,
                              letterSpacing: -0.24,
                            )),
                    Text("1120.00 KWD", // TODO: Replace with text from API
                        textAlign: TextAlign.end,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: ColorSchemes.black,
                              letterSpacing: -0.24,
                            )),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(S.of(context).deliveryFees,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: ColorSchemes.gray,
                              letterSpacing: -0.24,
                            )),
                    Text("10.00 KWD", // TODO: Replace with text from API
                        textAlign: TextAlign.end,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: ColorSchemes.black,
                              letterSpacing: -0.24,
                            )),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(S.of(context).discount,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: ColorSchemes.gray,
                              letterSpacing: -0.24,
                            )),
                    Text("220.00 KWD", // TODO: Replace with text from API
                        textAlign: TextAlign.end,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: ColorSchemes.black,
                              letterSpacing: -0.24,
                            )),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Container(
            height: 2,
            color: ColorSchemes.greyDivider,
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: ColorSchemes.primary,
                          width: 1.5,
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, top: 3, bottom: 2),
                          child: Text(
                            widget.servicesDetailsCart.length.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: ColorSchemes.primary,
                                  letterSpacing: -0.24,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      S.of(context).total,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: ColorSchemes.black,
                            letterSpacing: -0.24,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "${double.parse(getTotal()) + 220} ${widget.compoundCurrency}",
                      // todo change 220 with real values
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: ColorSchemes.gray,
                            letterSpacing: -0.24,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.lineThrough,
                          ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      getTotal() + widget.compoundCurrency,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: ColorSchemes.black,
                            letterSpacing: -0.24,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(16),
            child: CustomButtonWidget(
              width: double.infinity,
              text: S.of(context).checkNow,
              backgroundColor: F.isNiceTouch
                  ? ColorSchemes.ghadeerDarkBlue
                  : ColorSchemes.primary,
              onTap: () {
                widget.onCheckNowButtonPressed();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget disCountWidget() {
    return TextField(
      controller: _controller,
      onChanged: (value) {
        _controller.text = value;
      },
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: ColorSchemes.black,
            letterSpacing: -0.13,
          ),
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: ColorSchemes.border),
              borderRadius: BorderRadius.circular(12)),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: ColorSchemes.border),
              borderRadius: BorderRadius.circular(12)),
          errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: ColorSchemes.redError),
              borderRadius: BorderRadius.circular(12)),
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: ColorSchemes.border),
              borderRadius: BorderRadius.circular(12)),
          prefixIcon: SvgPicture.asset(
            ImagePaths.discountIcon,
            width: 24,
            height: 24,
            fit: BoxFit.scaleDown,
          ),
          suffixIcon: InkWell(
            onTap: () {
              if (_controller.text.isNotEmpty) {
                widget.onApplyButtonPressed(_controller.text);
              }else {
                showSnackBar(
                    context: context,
                    message: S.of(context).pleaseEnterACouponCode,
                    color: ColorSchemes.snackBarError,
                    icon: ImagePaths.error);
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: ColorSchemes.paymentCardColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  S.of(context).couponApply,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        letterSpacing: -0.24,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          labelStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: /* widget.errorMessage == null
                      ? */
                    ColorSchemes.gray,
                // : ColorSchemes.redError,
                letterSpacing: -0.24,
              ),
          errorMaxLines: 2),
    );
  }

  String getSubTotal() {
    double subTotal = 0;
    for (int i = 0; i < widget.servicesDetailsCart.length; i++) {
      subTotal += widget.servicesDetailsCart[i].price *
          widget.servicesDetailsCart[i].quantity;
    }
    return subTotal.toString();
  }

  String getTotal() {
    double total = 0;
    total = double.parse(getSubTotal()) +
        1680 +
        1120 +
        10 -
        220; // todo change with real values
    return total.toString();
  }
}
