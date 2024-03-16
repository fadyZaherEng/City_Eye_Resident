import 'package:city_eye/flavors.dart';
import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/presentation/widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';

class FooterWidget extends StatelessWidget {
  final Function() loginAction;
  final Function(int currentIndex) onTapCompoundSaveContinueAction;
  final Function(int currentIndex) onTapProfileSaveContinueAction;
  final Function(int currentIndex) onTapDocumentsSaveContinueAction;
  final int currentIndex;

  const FooterWidget({
    Key? key,
    required this.loginAction,
    required this.onTapCompoundSaveContinueAction,
    required this.onTapProfileSaveContinueAction,
    required this.onTapDocumentsSaveContinueAction,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomButtonWidget(
            onTap: () {
              switch (currentIndex) {
                case 1:
                  onTapCompoundSaveContinueAction(2);
                  break;
                case 2:
                  onTapProfileSaveContinueAction(3);
                  break;
                case 3:
                  onTapDocumentsSaveContinueAction(3);
                  break;
              }
            },
            text: S.of(context).saveContinue,
            width: double.infinity,
            backgroundColor: F.isNiceTouch
                ? ColorSchemes.ghadeerDarkBlue
                : ColorSchemes.primary,
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.only(
            left: 16,
          ),
          child: Container(
            height: 1,
            color: ColorSchemes.lightGray,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 32,
            horizontal: 16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                S.of(context).alreadyHaveAnAccount,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: ColorSchemes.black,
                      letterSpacing: -0.13,
                    ),
              ),
              InkWell(
                onTap: loginAction,
                child: Text(
                  S.of(context).login,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: ColorSchemes.secondary,
                        letterSpacing: -0.13,
                      ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
