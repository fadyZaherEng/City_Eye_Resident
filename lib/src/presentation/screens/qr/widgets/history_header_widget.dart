import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/presentation/widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';

class HistoryHeaderWidget extends StatelessWidget {
  final String firstPageTitle;
  final String secondPageTitle;
  final Function() onTabFirstButton;
  final Function() onTabSecondButton;
  final int type;

  const HistoryHeaderWidget({
    super.key,
    required this.firstPageTitle,
    required this.secondPageTitle,
    required this.onTabFirstButton,
    required this.onTabSecondButton,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            right: 16,
            left: 15,
            top: 16,
            bottom: 16,
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: ColorSchemes.cardSelected,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: Row(
                children: [
                  Expanded(
                    child: CustomButtonWidget(
                      height: 40,
                      text: firstPageTitle,
                      backgroundColor: _backgroundColor(1),
                      textColor: _textColor(1),
                      onTap: onTabFirstButton,
                    ),
                  ),
                  Expanded(
                    child: CustomButtonWidget(
                      height: 40,
                      text: secondPageTitle,
                      backgroundColor: _backgroundColor(2),
                      textColor: _textColor(2),
                      onTap: onTabSecondButton,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          height: 2,
          color: ColorSchemes.border,
        ),
        const SizedBox(height: 16)
      ],
    );
  }

  Color _backgroundColor(int tempType) {
    return type == tempType ? ColorSchemes.primary : ColorSchemes.cardSelected;
  }

  Color _textColor(int tempType) {
    return type == tempType ? ColorSchemes.white : ColorSchemes.gray;
  }
}
