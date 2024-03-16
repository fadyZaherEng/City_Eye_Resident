import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/domain/entities/home/home_service.dart';
import 'package:city_eye/src/presentation/widgets/card_widget.dart';
import 'package:city_eye/src/presentation/widgets/circular_icon.dart';
import 'package:flutter/material.dart';

class ServiceItemsWidget extends StatelessWidget {
  final List<HomeService> services;
  final Function(HomeService) onTap;

  const ServiceItemsWidget(
      {Key? key, this.services = const [], required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        height: 150,
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
        child: Row(
            children: services
                .map((element) => GestureDetector(
                      onTap: () {
                        onTap(element);
                      },
                      child: CardWidget(
                          widget: CircularIcon(
                            iconSize: 28,
                            isNetworkImage: element.logo != "",
                            imagePath: element.logo != "" ? element.logo : ImagePaths.frame,
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
                          title: element.name,
                          subtitle: "${S.of(context).byWithSpase}: ${element.name}",
                          boxShadows: const [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.12),
                              offset: Offset(0, 1),
                              blurRadius: 20,
                              spreadRadius: 1,
                            )
                          ]),
                    ))
                .toList()),
      ),
    );
  }
}
