import 'package:city_eye/flavors.dart';
import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/base/widget/base_stateful_widget.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/presentation/widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoInternetScreen extends BaseStatefulWidget {
  final Function() tryAgainAction;

  const NoInternetScreen({
    super.key,
    required this.tryAgainAction,
  });

  @override
  BaseState<BaseStatefulWidget> baseCreateState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends BaseState<NoInternetScreen> {
  @override
  Widget baseBuild(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              ImagePaths.noInternet,
              fit: BoxFit.scaleDown,
            ),
            const SizedBox(height: 30),
            Text(S.of(context).noInternetConnection,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      letterSpacing: -0.16,
                      color: ColorSchemes.primary,
                    )),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                  S
                      .of(context)
                      .noInternetConnectionFoundCheckYourConnectionOrTryAgain,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        letterSpacing: -0.24,
                        color: ColorSchemes.black,
                      )),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 105,
              ),
              child: CustomButtonWidget(
                onTap: widget.tryAgainAction,
                text: S.of(context).tryAgain,
                width: double.infinity,
                backgroundColor: F.isNiceTouch
                    ? ColorSchemes.ghadeerDarkBlue
                    : ColorSchemes.primary,
              ),
            )
          ],
        ),
      ),
    );
  }
}
