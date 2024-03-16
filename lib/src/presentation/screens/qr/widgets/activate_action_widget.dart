import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/domain/entities/qr_history/qr_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActivateActionWidget extends StatelessWidget {
  final Function(QrHistory) onTapActiveAction;
  final QrHistory qrHistory;

  const ActivateActionWidget({
    super.key,
    required this.onTapActiveAction,
    required this.qrHistory,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTapActiveAction(qrHistory);
      },
      child: Row(
        children: [
          SvgPicture.asset(
            ImagePaths.deActive,
            fit: BoxFit.scaleDown,
            color: ColorSchemes.redError.withOpacity(0.7),
            matchTextDirection: true,
          ),
          const SizedBox(width: 6),
          Text(
            S.of(context).activate,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: ColorSchemes.redError.withOpacity(0.7),
                  letterSpacing: -0.24,
                ),
          ),
        ],
      ),
    );
  }
}
