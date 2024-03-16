import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/convert_timestamp_to_date_format.dart';
import 'package:city_eye/src/core/utils/english_numbers.dart';
import 'package:city_eye/src/domain/entities/support/orders.dart';
import 'package:city_eye/src/presentation/screens/support/utils/orders_keys.dart';
import 'package:city_eye/src/presentation/screens/support/widgets/animated_setp_line_widget.dart';
import 'package:city_eye/src/presentation/screens/support/widgets/setp_line_widget.dart';
import 'package:city_eye/src/presentation/screens/support/widgets/step_circle_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderCardWidget extends StatelessWidget {
  final Orders order;
  final int orderType;
  final Function() onCancel;
  final Function() onPayNow;
  final Function() onComment;
  final Function() onRate;
  final Color borderColor;

  const OrderCardWidget({
    Key? key,
    required this.order,
    required this.orderType,
    required this.onCancel,
    required this.onPayNow,
    required this.onComment,
    required this.onRate,
    this.borderColor = ColorSchemes.cardSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: borderColor,
              width: 1,
            ),
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 4),
                blurRadius: 16,
                spreadRadius: 0,
                color: Color.fromRGBO(0, 0, 0, 0.12),
              ),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Text(
                          "${S.of(context).id} : ${order.id}",
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: ColorSchemes.black,
                                    letterSpacing: -0.13,
                                  ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: ColorSchemes.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: ColorSchemes.primary,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.network(
                                order.category.logo != ""
                                    ? order.category.logo
                                    : ImagePaths.frame,
                                color: ColorSchemes.primary,
                                fit: BoxFit.scaleDown,
                                width: 22,
                                height: 22,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                order.category.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: ColorSchemes.primary,
                                      letterSpacing: -0.24,
                                    ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Text(
                          "${S.of(context).time}: ",
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: ColorSchemes.black,
                                    letterSpacing: -0.24,
                                  ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          Directionality.of(context).name ==
                                  TextDirection.rtl.name
                              ? "\u200E${"\u200E${order.time}".split('-').reversed.join(' - ').toString()}"
                              : order.time,
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: ColorSchemes.gray,
                                    letterSpacing: -0.24,
                                  ),
                        ),
                        const Spacer(),
                        Text(
                          "${S.of(context).date}: ",
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: ColorSchemes.black,
                                    letterSpacing: -0.24,
                                  ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          order.date != ''
                              ? englishNumbers(convertTimestampToDateFormat(order.date))
                              : "",
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: ColorSchemes.gray,
                                    letterSpacing: -0.24,
                                  ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            StepCircleWidget(
                              status: order.statusList[0],
                            ),
                            Expanded(
                              child: AnimatedStepLineWidget(
                                status: order.statusList[1],
                              ),
                            ),
                            StepCircleWidget(
                              status: order.statusList[1],
                            ),
                            Expanded(
                              child: AnimatedStepLineWidget(
                                status: order.statusList[2],
                              ),
                            ),
                            StepCircleWidget(
                              status: order.statusList[2],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 36),
                  ],
                ),
              ),
              Container(
                height: 1.5,
                color: ColorSchemes.border,
              ),
              _buildFooter(context, orderType)
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Padding _buildFooter(BuildContext context, int orderType) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: orderType == 1
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildIconTextWidget(
                  context: context,
                  imagePath: ImagePaths.cancelRate,
                  text: S.of(context).cancel,
                  onTap: onCancel,
                ),
                order.statusList.last.captionStatusCode ==
                        OrdersKeys.NeedPayment
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _footerDivider(),
                          const SizedBox(width: 16),
                          _buildIconTextWidget(
                            context: context,
                            imagePath: ImagePaths.payNow,
                            text: S.of(context).payNow,
                            onTap: onPayNow,
                          ),
                          const SizedBox(width: 16),
                          _footerDivider(),
                        ],
                      )
                    : _footerDivider(),
                _buildIconTextWidget(
                  context: context,
                  imagePath: ImagePaths.comment,
                  text: S.of(context).comment,
                  onTap: onComment,
                ),
              ],
            )
          : order.statusList.last.captionStatusCode == OrdersKeys.Cancelled
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 50,
                      child: _buildIconTextWidget(
                        context: context,
                        imagePath: ImagePaths.comment,
                        text: S.of(context).comment,
                        onTap: onComment,
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildIconTextWidget(
                      context: context,
                      imagePath: ImagePaths.rateStar,
                      text: S.of(context).rate,
                      onTap: onRate,
                    ),
                    _footerDivider(),
                    _buildIconTextWidget(
                      context: context,
                      imagePath: ImagePaths.comment,
                      text: S.of(context).comment,
                      onTap: onComment,
                    ),
                  ],
                ),
    );
  }

  Widget _footerDivider() {
    return Container(
      height: 50,
      width: 1,
      color: ColorSchemes.gray,
    );
  }

  Widget _buildIconTextWidget({
    required BuildContext context,
    required String imagePath,
    required String text,
    required Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(
            imagePath,
            width: 24,
            height: 24,
            color: ColorSchemes.gray,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: ColorSchemes.gray,
                  letterSpacing: -0.24,
                ),
          )
        ],
      ),
    );
  }
}
