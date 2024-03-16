import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/domain/entities/home/home_service.dart';
import 'package:city_eye/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:city_eye/src/presentation/widgets/circular_icon.dart';
import 'package:flutter/material.dart';

class ServiceDetailsContentWidget extends StatefulWidget {
  final Function() onBackButtonPressed;
  final void Function(HomeService homeService) onTapService;
  final String title;
  final List<HomeService> serviceDetails;

  const ServiceDetailsContentWidget({
    Key? key,
    required this.onBackButtonPressed,
    required this.title,
    required this.serviceDetails,
    required this.onTapService,
  }) : super(key: key);

  @override
  State<ServiceDetailsContentWidget> createState() =>
      _ServiceDetailsContentWidgetState();
}

class _ServiceDetailsContentWidgetState
    extends State<ServiceDetailsContentWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarWidget(
        context,
        title: widget.title,
        isHaveBackButton: true,
        onBackButtonPressed: widget.onBackButtonPressed,
      ),
      body: ListView.builder(
          itemCount: widget.serviceDetails.length,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                widget.onTapService(widget.serviceDetails[index]);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircularIcon(
                          boxShadows: const [
                            BoxShadow(
                              offset: Offset(0, 4),
                              blurRadius: 15,
                              spreadRadius: 0,
                              color: Color.fromRGBO(23, 43, 77, 0.16),
                            ),
                          ],
                          isNetworkImage:
                              widget.serviceDetails[index].logo.isNotEmpty
                                  ? true
                                  : false,
                          imagePath:
                              widget.serviceDetails[index].logo.isNotEmpty
                                  ? widget.serviceDetails[index].logo
                                  : ImagePaths.frame,
                          backgroundColor: ColorSchemes.iconBackGround,
                          iconSize: 48,
                          iconColor: ColorSchemes.primary,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          widget.serviceDetails[index].name,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: ColorSchemes.black,
                                    letterSpacing: -0.24,
                                  ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: ColorSchemes.lightGray,
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
