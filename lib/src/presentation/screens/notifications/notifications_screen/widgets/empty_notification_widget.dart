import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyNotificationWidget extends StatelessWidget {
  final Function() onRefresh;

  const EmptyNotificationWidget({required this.onRefresh, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(ImagePaths.emptyNotification),
        const SizedBox(
          height: 32.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            S
                .of(context)
                .noImportantNewsUpdatesOrNoticesFromCommunityManagement,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: ColorSchemes.black,
                ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 16),
        InkWell(
          onTap: onRefresh,
          child: SvgPicture.asset(
            ImagePaths.refresh,
            width: 32,
            height: 32,
          ),
        ),
      ],
    );
  }
}
