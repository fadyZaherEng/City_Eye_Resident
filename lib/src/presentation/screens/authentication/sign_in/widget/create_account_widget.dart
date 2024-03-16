import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:flutter/material.dart';

class CreateAccountWidget extends StatelessWidget {
  final Function() onTap;

  const CreateAccountWidget({
    Key? key,
    required this.onTap,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 16,
          ),
          child: Container(
            height: 1.5,
            color: ColorSchemes.lightGray,
            width: double.infinity,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 32,
              horizontal: 16
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  S.of(context).dontHaveAnAccount,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: ColorSchemes.black,
                        letterSpacing: -0.13,
                      ),
                ),
                Text(
                  S.of(context).createAccount,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: ColorSchemes.secondary,
                        letterSpacing: -0.13,
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
