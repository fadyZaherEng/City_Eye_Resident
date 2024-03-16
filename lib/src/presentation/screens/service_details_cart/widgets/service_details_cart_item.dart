import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/domain/entities/service_details/service_details_cart.dart';
import 'package:city_eye/src/domain/entities/settings/compound_currency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ServiceDetailsCartItem extends StatelessWidget {
  final ServiceDetailsCart serviceDetailsCart;
  final Function(ServiceDetailsCart) onServiceDetailsCartChanged;
  final Function(ServiceDetailsCart) onAddTab;
  final Function(ServiceDetailsCart) onMinusTab;
  final CompoundCurrency currency;
  const ServiceDetailsCartItem({
    Key? key,
    required this.serviceDetailsCart,
    required this.onServiceDetailsCartChanged,
    required this.onAddTab,
    required this.onMinusTab,
    required this.currency,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 205,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: const Color.fromRGBO(241, 241, 241, 1), width: 1),
          color: ColorSchemes.white,
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 4),
              color: Color.fromRGBO(0, 0, 0, 0.12),
              spreadRadius: 0,
              blurRadius: 32,
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration:  BoxDecoration(
              color: ColorSchemes.iconBackGround,
              borderRadius: const  BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  serviceDetailsCart.name,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.black,
                        letterSpacing: -0.24,
                      ),
                ),
                const Expanded(child: SizedBox()),
                Checkbox(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                  side: const BorderSide(
                    color: ColorSchemes.lightGray,
                  ),
                  activeColor: ColorSchemes.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                    4,
                  )),
                  tristate: true,
                  value: serviceDetailsCart.isSelected,
                  onChanged: (value) {
                    onServiceDetailsCartChanged(serviceDetailsCart);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              serviceDetailsCart.description,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: ColorSchemes.black,
                    letterSpacing: -0.24,
                  ),
            ),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Visibility(
                          visible:
                              serviceDetailsCart.quantity == 0 ? false : true,
                          child: Text(
                            "${serviceDetailsCart.quantity}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  letterSpacing: -0.24,
                                ),
                          ),
                        ),
                        Visibility(
                          visible: serviceDetailsCart.quantity != 0,
                          child: const SizedBox(
                            width: 8,
                          ),
                        ),
                        Visibility(
                          visible: serviceDetailsCart.quantity != 0,
                          child: Text(
                            "X",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  letterSpacing: -0.24,
                                ),
                          ),
                        ),
                        Visibility(
                          visible: serviceDetailsCart.quantity != 0,
                          child: const SizedBox(
                            width: 8,
                          ),
                        ),
                        Text(
                          "${serviceDetailsCart.price.toStringAsFixed(3)} ${currency.code}",
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    letterSpacing: -0.24,
                                  ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    RatingBar.builder(
                      initialRating: serviceDetailsCart.serviceRate,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 20,
                      ignoreGestures: true,
                      wrapAlignment: WrapAlignment.center,
                      glowRadius: 0.6,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                      itemBuilder: (context, _) => SvgPicture.asset(
                        ImagePaths.star,
                        fit: BoxFit.scaleDown,
                      ),
                      onRatingUpdate: (rating) {},
                    ),
                  ],
                ),
                const Expanded(child: SizedBox()),
                _buildActionButton(
                    icon: ImagePaths.minus,
                    backgroundColor: ColorSchemes.white,
                    onTap: () {
                      onMinusTab(serviceDetailsCart);
                    }),
                const SizedBox(width: 6),
                _buildActionButton(
                    icon: ImagePaths.add,
                    backgroundColor: ColorSchemes.primary,
                    onTap: () {
                      onAddTab(serviceDetailsCart);
                    }),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 1,
            color: ColorSchemes.lightGray,
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  S.of(context).totalOfService,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      letterSpacing: -0.24, color: ColorSchemes.gray),
                ),
                const Expanded(child: SizedBox()),
                Text(
                  "${(serviceDetailsCart.price * serviceDetailsCart.quantity).toStringAsFixed(3)} ${currency.code}",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: ColorSchemes.black,
                        letterSpacing: -0.24,
                      ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String icon,
    required Color backgroundColor,
    required Function() onTap,
  }) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            color: ColorSchemes.primary,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: SvgPicture.asset(
          icon,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}
