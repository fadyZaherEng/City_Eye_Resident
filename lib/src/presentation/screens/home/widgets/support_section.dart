import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/domain/entities/home/home_service.dart';
import 'package:city_eye/src/domain/entities/home/home_support.dart';
import 'package:city_eye/src/domain/entities/support/support_service.dart';
import 'package:city_eye/src/presentation/screens/home/widgets/support_items_widget.dart';
import 'package:city_eye/src/presentation/widgets/custom_empty_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SupportSection extends StatelessWidget {
  final List<HomeSupport> items;
  final Function(HomeSupport) onTap;

  const SupportSection({Key? key, this.items = const [], required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(S.of(context).maintenance,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: ColorSchemes.black, letterSpacing: -0.24)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: items.isEmpty
              ? Container(
                  height: 120,
                  width: double.infinity,
                  margin: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 24,
                        spreadRadius: 0,
                        color: ColorSchemes.lightGray,
                      )
                    ],
                    color: ColorSchemes.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          ImagePaths.noSupportHome,
                          fit: BoxFit.scaleDown,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          S.of(context).thereIsNoMaintenance,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: ColorSchemes.black,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                )
              : SupportItemsWidget(
                  items: items,
                  onTap: (item) {
                    onTap(item);
                  },
                ),
        ),
      ],
    );
  }
}
