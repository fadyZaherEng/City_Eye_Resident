import 'package:city_eye/flavors.dart';
import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/presentation/widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  final Function() signIn;
  final Function() signUp;

  const HeaderSection({
    Key? key,
    required this.signIn,
    required this.signUp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      children: [
        Container(
          padding: const EdgeInsetsDirectional.only(start: 16),
          decoration: BoxDecoration(
            color: ColorSchemes.primary.withOpacity(0.04),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 16,
              ),
              Text(
                S.of(context).heyThere,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      letterSpacing: -0.16,
                      color: ColorSchemes.black,
                    ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                S.of(context).logInOrCreateAccount,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      letterSpacing: -0.13,
                      color: ColorSchemes.black,
                    ),
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  CustomButtonWidget(
                    onTap: signIn,
                    text: S.of(context).signIn,
                    textColor: ColorSchemes.white,
                    height: 40,
                    backgroundColor: F.isNiceTouch
                        ? ColorSchemes.ghadeerDarkBlue
                        : ColorSchemes.primary,
                  ),
                  const SizedBox(
                    width: 32,
                  ),
                  InkWell(
                    onTap: signUp,
                    child: Text(
                      S.of(context).signUp,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: ColorSchemes.primary,
                            letterSpacing: -0.13,
                          ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
        Positioned.directional(
          bottom: -30,
          end: 0,
          textDirection: Directionality.of(context),
          child: Image.asset(
            ImagePaths.handHoldingPhone,
            matchTextDirection: true,
          ),
        ),
      ],
    );
  }
}
