import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:flutter/material.dart';

class ForgetPasswordWidget extends StatelessWidget {
  final Function() onTap;

  const ForgetPasswordWidget({
    Key? key,
    required this.onTap,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Text(
          S.of(context).forgotPasswordQuestion,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: ColorSchemes.black,
                letterSpacing: -0.13,
              ),
        ));
  }
}
