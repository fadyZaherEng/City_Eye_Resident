import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/domain/entities/home/home_support.dart';
import 'package:city_eye/src/domain/entities/support/support_service.dart';
import 'package:city_eye/src/presentation/widgets/circular_icon.dart';
import 'package:flutter/material.dart';

class SupportItemWidget extends StatelessWidget {
  final HomeSupport item;
  final Function(HomeSupport) onTap;

  const SupportItemWidget({Key? key, required this.item, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(item);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          CircularIcon(
            iconSize: 28,
            isNetworkImage: item.logo != "",
            imagePath: item.logo != "" ? item.logo : ImagePaths.frame,
            boxShadows: const [
              BoxShadow(
                offset: Offset(0, 4),
                blurRadius: 24,
                spreadRadius: 0,
                color: Color.fromRGBO(23, 43, 77, 0.16),
              ),
            ],
            backgroundColor: ColorSchemes.iconBackGround,
            iconColor: ColorSchemes.primary,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: 80,
            child: Text(
              item.name,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    letterSpacing: -0.24,
                    color: ColorSchemes.black,
                  ),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
