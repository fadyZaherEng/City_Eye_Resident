import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MoreItemWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final Function() onTap;
  final bool isVisible;

  const MoreItemWidget({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.onTap,
    this.isVisible = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isVisible ? InkWell(
      onTap: (){
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              imagePath,
              width: 24,
              height: 24,
              fit: BoxFit.scaleDown,
            ),
            const SizedBox(
              width: 14,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    letterSpacing: -0.24,
                    color: ColorSchemes.black,
                  ),
            ),
            const Expanded(child: SizedBox()),
            Icon(
              Icons.arrow_forward_ios_sharp,
              size: 18,
              color: ColorSchemes.gray,
            )
          ],
        ),
      ),
    ) : const SizedBox.shrink();
  }
}
