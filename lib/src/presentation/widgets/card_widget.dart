import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final Widget widget;
  final String title;
  final String subtitle;
  final List<BoxShadow> boxShadows;
  final Color borderColor;
  final Color color;

  const CardWidget(
      {Key? key,
      required this.widget,
      required this.title,
      required this.subtitle,
      this.borderColor = Colors.transparent,
      this.color = ColorSchemes.white,
      this.boxShadows = const [
        BoxShadow(
          offset: Offset(0, 4),
          blurRadius: 24,
          spreadRadius: 0,
          color: ColorSchemes.lightGray,
        )
      ]})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
        border: Border.all(color: borderColor),
        boxShadow: boxShadows,
        color: color,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 16,
          ),
          widget,
          const SizedBox(
            height: 8,
          ),
          Text(
            title.trim(),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: ColorSchemes.black,
                  letterSpacing: -0.24,
                ),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            maxLines: 1,
          ),
          const SizedBox(
            height: 12,
          ),
          SizedBox(
            width: 132,
            child: Text(
              subtitle.trim(),
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: ColorSchemes.gray,
                    letterSpacing: -0.24,
                  ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
