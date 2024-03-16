import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/domain/entities/home/home_support.dart';
import 'package:city_eye/src/domain/entities/support/support_service.dart';
import 'package:city_eye/src/presentation/screens/support/widgets/support_service_card_widget.dart';
import 'package:city_eye/src/presentation/widgets/custom_empty_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SupportServicesWidget extends StatelessWidget {
  final List<HomeSupport> supportServices;
  final Function(HomeSupport) onTap;
  final Function() onPullToRefresh;

  const SupportServicesWidget({
    Key? key,
    required this.supportServices,
    required this.onTap,
    required this.onPullToRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: supportServices.isNotEmpty
          ? RefreshIndicator(
              onRefresh: () => onPullToRefresh(),
              child: GridView.builder(
                itemCount: supportServices.length,
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 0.0,
                  mainAxisSpacing: 16,
                  mainAxisExtent: 120,
                ),
                itemBuilder: (context, index) {
                  return SupportServiceCardWidget(
                    supportService: supportServices[index],
                    onTap: (supportService) {
                      onTap(supportService);
                    },
                  );
                },
              ),
            )
          : Column(children: [
              const SizedBox(height: 64),
              CustomEmptyListWidget(
                  imagePath: ImagePaths.noSupport,
                  text: S.of(context).noSupportFound,
                  onRefresh: onPullToRefresh),
            ]),
    );
  }
}
