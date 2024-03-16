import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/utils/extensions/color_extension.dart';
import 'package:city_eye/src/domain/entities/support/status.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class AnimatedStepLineWidget extends StatelessWidget {
  final Status status;

  const AnimatedStepLineWidget({
    Key? key,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      padding: const EdgeInsets.all(0),
      percent: 1.0,
      backgroundColor: Colors.white,
      progressColor: status.colorCode.toColor(),
      animation: true,
      lineHeight: 2,
      animationDuration: 1000,
      barRadius: const Radius.circular(12),
      isRTL: Directionality.of(context) == TextDirection.rtl ? true : false,
    );
  }

  Color _getStatusColor(Status status) {
    if (status.isCompleted && status.captionStatusCode != "cancelled") {
      return ColorSchemes.green;
    } else {
      return status.colorCode.toColor();
    }
  }
}
