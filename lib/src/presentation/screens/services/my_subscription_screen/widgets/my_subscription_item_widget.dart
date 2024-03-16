import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/convert_timestamp_to_date_format.dart';
import 'package:city_eye/src/domain/entities/services/my_subscription.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MySubscriptionItemWidget extends StatelessWidget {
  final MySubscription mySubscription;
  final String currency;
  final Color borderColor;
  final Function(MySubscription) onQRTab;

  const MySubscriptionItemWidget({
    required this.mySubscription,
    required this.currency,
    required this.onQRTab,
    this.borderColor = ColorSchemes.white,
    required
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 6, bottom: 6, left: 12, right: 12),
          child: Container(
            decoration: BoxDecoration(
                color: ColorSchemes.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: borderColor, width: 1),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 4),
                    blurRadius: 15,
                    spreadRadius: 5,
                    color: Color.fromRGBO(0, 0, 0, 0.12),
                  ),
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      Text(
                        mySubscription.servicePackages.name,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: ColorSchemes.black,
                              letterSpacing: -0.24,
                            ),
                      ),
                      const Expanded(child: SizedBox()),
                      InkWell(
                        onTap: () {
                          onQRTab(mySubscription);
                        },
                        child: SvgPicture.asset(
                          ImagePaths.scanQR,
                          fit: BoxFit.scaleDown,
                          color: ColorSchemes.primary,
                        ),
                      )
                    ],
                  ),
                ),
                const Divider(
                  thickness: 1,
                  color: ColorSchemes.lightGray,
                  height: 1,
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      SvgPicture.network(
                        mySubscription.servicePackages.serviceCategory.logo,
                        height: 20,
                        width: 20,
                        color: ColorSchemes.primary,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Text(
                          mySubscription.servicePackages.serviceCategory.name,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: ColorSchemes.black,
                                    letterSpacing: -0.24,
                                  ),
                        ),
                      ),
                      SizedBox(
                        width: 80,
                        child: Text(
                          "${mySubscription.price} $currency / month",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: ColorSchemes.black,
                                    letterSpacing: -0.24,
                                  ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        ImagePaths.timeWork1,
                        height: 20,
                        width: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Text(
                          !mySubscription.servicePackages.isCountType
                              ? S.of(context).expireDate
                              : S.of(context).sessionNo,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: ColorSchemes.black,
                                    letterSpacing: -0.24,
                                  ),
                        ),
                      ),
                      SizedBox(
                        width: 80,
                        child: Text(
                          !mySubscription.servicePackages.isCountType
                              ? convertTimestampToDateFormat(
                                  mySubscription.expireDate)
                              : "${"${mySubscription.sessionNo} "} ${S.of(context).sessions}",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.end,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: ColorSchemes.gray,
                                    fontSize: 12,
                                    letterSpacing: -0.24,
                                  ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
