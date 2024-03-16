import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/domain/entities/qr_history/qr_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DeactivateActionWidget extends StatelessWidget {
  final Function(QrHistory) onTapDeActiveAction;
  final QrHistory qrHistory;

  const DeactivateActionWidget({
    super.key,
    required this.onTapDeActiveAction,
    required this.qrHistory,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTapDeActiveAction(qrHistory);
      },
      child: Row(
        children: [
          SvgPicture.asset(
            ImagePaths.deActive,
            fit: BoxFit.scaleDown,
            matchTextDirection: true,
          ),
          const SizedBox(width: 6),
          Text(
            S.of(context).deactivate,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: ColorSchemes.black,
                  letterSpacing: -0.24,
                ),
          ),
        ],
      ),
    );
  }
}
