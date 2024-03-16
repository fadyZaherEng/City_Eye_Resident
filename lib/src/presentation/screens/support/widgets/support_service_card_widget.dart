import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/domain/entities/home/home_support.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SupportServiceCardWidget extends StatelessWidget {
  final HomeSupport supportService;
  final Function(HomeSupport) onTap;

  const SupportServiceCardWidget({
    Key? key,
    required this.supportService,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(supportService),
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: const BoxDecoration(
              color: ColorSchemes.white,
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                    blurRadius: 32,
                    color: Color.fromRGBO(0, 0, 0, 0.12))
              ],
              borderRadius: BorderRadius.all(Radius.circular(16)),
              border: Border.fromBorderSide(
                BorderSide(
                  color: Color.fromRGBO(222, 222, 222, 1),
                ),
              ),
            ),
            child: SvgPicture.network(
              supportService.logo, //imageUrl
              fit: BoxFit.scaleDown,
              color: ColorSchemes.primary,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            supportService.name, //supportService.name
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: ColorSchemes.black,
                  letterSpacing: -0.24,
                ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}
