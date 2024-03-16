import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/domain/entities/home/home_service.dart';
import 'package:city_eye/src/presentation/screens/home/widgets/service_items_widget.dart';
import 'package:city_eye/src/presentation/widgets/custom_empty_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ServiceSection extends StatelessWidget {
  final List<HomeService> services;
  final Function(HomeService) onTap;

  const ServiceSection(
      {Key? key, this.services = const [], required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(S.of(context).services,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: ColorSchemes.black, letterSpacing: -0.24)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: services.isEmpty
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
                          ImagePaths.noServicesHome,
                          fit: BoxFit.scaleDown,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          S.of(context).thereIsNoServices,
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
              : ServiceItemsWidget(
                  services: services,
                  onTap: (item) {
                    onTap(item);
                  },
                ),
        ),
      ],
    );
  }
}
