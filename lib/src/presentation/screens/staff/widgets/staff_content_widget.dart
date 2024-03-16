import 'package:city_eye/flavors.dart';
import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/constants.dart';
import 'package:city_eye/src/domain/entities/staff/staff.dart';
import 'package:city_eye/src/presentation/screens/staff/widgets/staff_image_widget.dart';
import 'package:city_eye/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:city_eye/src/presentation/widgets/custom_button_widget.dart';
import 'package:city_eye/src/presentation/widgets/custom_empty_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StaffContentWidget extends StatefulWidget {
  final Function() onBackButtonPressed;
  final Function({
    required String phoneNumber,
  }) onTapPhoneNumber;
  final List<Staff> stuff;
  final Function() onPullToRefresh;
  final Function(String) onTapStuffImage;

  const StaffContentWidget({
    Key? key,
    required this.onBackButtonPressed,
    required this.stuff,
    required this.onTapPhoneNumber,
    required this.onPullToRefresh,
    required this.onTapStuffImage,
  }) : super(key: key);

  @override
  State<StaffContentWidget> createState() => _StaffContentWidgetState();
}

class _StaffContentWidgetState extends State<StaffContentWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarWidget(
        context,
        title: S.of(context).staff,
        isHaveBackButton: true,
        onBackButtonPressed: widget.onBackButtonPressed,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          right: 16,
          left: 16,
          top: 16,
        ),
        child: widget.stuff.isNotEmpty
            ? RefreshIndicator(
                onRefresh: () => widget.onPullToRefresh(),
                child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: widget.stuff.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 15,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 93,
                                  width: 93,
                                  child: Container(
                                    width: double.infinity,
                                    height: 93,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                        50,
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          widget.onTapStuffImage(
                                            widget.stuff[index].image,
                                          );
                                        },
                                        child: StaffImageWidget(
                                          image: widget.stuff[index].image,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          _name(
                                              name: widget.stuff[index].name,
                                              isManager: widget.stuff[index]
                                                      .staffJobType.code
                                                      .toLowerCase() ==
                                                  "manager"),
                                          _position(
                                            isManager: widget.stuff[index]
                                                    .staffJobType.code
                                                    .toLowerCase() ==
                                                "manager",
                                            position: widget
                                                .stuff[index].staffJobType.name,
                                            height: 24.0,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          widget.onTapPhoneNumber(
                                            phoneNumber:
                                                widget.stuff[index].mobile,
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              matchTextDirection: true,
                                              ImagePaths.mobile,
                                              color: ColorSchemes.primary,
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              widget.stuff[index].mobile,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                    color: ColorSchemes.black,
                                                    letterSpacing: -0.24,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            matchTextDirection: true,
                                            ImagePaths.timeWork,
                                            color: ColorSchemes.primary,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            widget.stuff[index].workingHours,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                  color: ColorSchemes.black,
                                                  letterSpacing: -0.24,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible:
                                index == widget.stuff.length - 1 ? false : true,
                            child: Container(
                              height: 1,
                              color: ColorSchemes.lightGray,
                            ),
                          )
                        ],
                      );
                    }),
              )
            : CustomEmptyListWidget(
                imagePath: ImagePaths.historyEmptyScreen,
                text: S.of(context).noStuffYet,
                onRefresh: () {
                  widget.onPullToRefresh();
                },
              ),
      ),
    );
  }

  Widget _name({
    required String name,
    required bool isManager,
  }) {
    if (isManager) {
      return Text(
        name,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: ColorSchemes.black,
              letterSpacing: -0.24,
            ),
      );
    } else {
      return Text(
        name,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: ColorSchemes.gray,
              letterSpacing: -0.24,
            ),
      );
    }
  }

  Widget _position({
    required String position,
    required bool isManager,
    required double height,
  }) {
    if (isManager) {
      return CustomButtonWidget(
        fontWeight: Constants.fontWeightRegular,
        onTap: () => Null,
        text: position,
        height: height,
        buttonBorderRadius: 8,
        backgroundColor: F.isNiceTouch
            ? ColorSchemes.ghadeerDarkBlue
            : ColorSchemes.primary,
      );
    } else {
      return CustomButtonWidget(
        onTap: () => Null,
        fontWeight: Constants.fontWeightRegular,
        backgroundColor: ColorSchemes.white,
        borderColor: ColorSchemes.primary,
        textColor: ColorSchemes.primary,
        text: position,
        height: height,
        buttonBorderRadius: 8,
      );
    }
  }
}
