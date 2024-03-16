import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/domain/entities/home/home_support.dart';
import 'package:city_eye/src/domain/entities/support/support_service.dart';
import 'package:city_eye/src/presentation/screens/support_details/widgets/support_service_details_card_widget.dart';
import 'package:flutter/material.dart';

class SupportServicesDetailsWidget extends StatelessWidget {
  final List<HomeSupport> supportServices;
  final HomeSupport selectedSupportService;
  final ScrollController scrollController;
  final Function(HomeSupport) onTab;

  const SupportServicesDetailsWidget({
    Key? key,
    required this.supportServices,
    required this.selectedSupportService,
    required this.scrollController,
    required this.onTab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      width: double.infinity,
      child: ListView.builder(
        controller: scrollController,
        itemCount: supportServices.length,
        scrollDirection: Axis.horizontal,
        physics: ScrollPhysics(),
        itemBuilder: (context, index) {
          return SupportServiceDetailsCardWidget(
            supportService: supportServices[index],
            onTap: (supportService) {
              onTab(supportService);
            },
            textColor: _setTextColor(supportServices[index]),
            cardBackgroundColor:
                _setCardBackgroundColor(supportServices[index]),
            iconBackgroundColor:
                _setIconBackgroundColor(supportServices[index]),
          );
        },
      ),
    );
  }

  bool _isSelected(HomeSupport supportService) {
    return supportService.id == selectedSupportService.id;
  }

  Color _setCardBackgroundColor(HomeSupport supportService) {
    return _isSelected(supportService)
        ? ColorSchemes.primary
        : ColorSchemes.white;
  }

  Color _setIconBackgroundColor(HomeSupport supportService) {
    return _isSelected(supportService)
        ? ColorSchemes.white
        : ColorSchemes.otpShadow;
  }

  Color _setTextColor(HomeSupport supportService) {
    return _isSelected(supportService)
        ? ColorSchemes.white
        : ColorSchemes.black;
  }
}
