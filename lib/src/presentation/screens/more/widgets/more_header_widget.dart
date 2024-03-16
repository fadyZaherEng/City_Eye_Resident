import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/domain/entities/sign_in/user.dart';
import 'package:city_eye/src/domain/entities/sign_in/user_unit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeletons/skeletons.dart';

class MoreHeaderWidget extends StatelessWidget {
  final User user;
  final UserUnit userUnit;
  final Function() onTapSwitchAction;
  final Function() onTapSelectCompound;
  final Function() onQRTab;
  final String compoundImage;
  final Function(String) onTabImageProfile;

  const MoreHeaderWidget({
    Key? key,
    required this.user,
    required this.userUnit,
    required this.onTapSwitchAction,
    required this.onTapSelectCompound,
    required this.onQRTab,
    required this.compoundImage,
    required this.onTabImageProfile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 60),
      width: double.infinity,
      color: const Color.fromRGBO(241, 241, 241, 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            S.of(context).more,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  letterSpacing: -0.24,
                  color: ColorSchemes.black,
                ),
          ),
          const SizedBox(
            height: 24,
          ),
          InkWell(
            onTap: () {
              onTabImageProfile(user.userInformation.image);
            },
            child: Container(
              clipBehavior: Clip.antiAlias,
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.orange,
                  width: 1,
                ),
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: Image.network(
                  user.userInformation.image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return SvgPicture.asset(
                      ImagePaths.avatar,
                      fit: BoxFit.scaleDown,
                    );
                  },
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: SkeletonLine(
                          style: SkeletonLineStyle(
                        width: double.infinity,
                        height: double.infinity,
                        borderRadius: BorderRadius.circular(
                          4,
                        ),
                      )),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                user.userInformation.name,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      letterSpacing: -0.24,
                      color: ColorSchemes.black,
                    ),
              ),
              const SizedBox(
                width: 8,
              ),
              InkWell(
                onTap: () {
                  onQRTab();
                },
                child: SvgPicture.asset(
                  ImagePaths.scanQR,
                  fit: BoxFit.scaleDown,
                  color: ColorSchemes.primary,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 36,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              fit: StackFit.loose,
              alignment: Alignment.center,
              children: [
                Text(
                  "${userUnit.compoundName} ${userUnit.userTypeName} - ${userUnit.unitName}",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        letterSpacing: -0.24,
                      ),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                ),
                const SizedBox(width: 8),
                Positioned.directional(
                  textDirection: Directionality.of(context),
                  end: 16,
                  child: Row(
                    children: [
                      Visibility(
                        visible: user.userUnits.length > 1,
                        child: InkWell(
                          onTap: onTapSwitchAction,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SvgPicture.asset(
                                width: 50,
                                height: 50,
                                ImagePaths.switchSplash,
                                fit: BoxFit.cover,
                                color: ColorSchemes.primary,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: ColorSchemes.greyDivider,
                                    // color of the border
                                    width: 2, // width of the border
                                  ),
                                ),
                                child: ClipOval(
                                  child: Image.network(
                                    compoundImage,
                                    height: 24,
                                    width: 24,
                                    fit: BoxFit.scaleDown,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            _buildPlaceHolderImage(),
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return const SizedBox(
                                          width: 32,
                                          height: 32,
                                          child: SkeletonAvatar(
                                            style: SkeletonAvatarStyle(
                                              shape: BoxShape.circle,
                                            ),
                                          ));
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: user.userUnits.length > 1,
                        child: const SizedBox(width: 6),
                      ),
                      InkWell(
                          onTap: onTapSelectCompound,
                          child: SvgPicture.asset(
                            ImagePaths.arrowDown,
                            fit: BoxFit.scaleDown,
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceHolderImage() {
    return SvgPicture.asset(
      ImagePaths.switchCompound,
      width: 20,
      height: 20,
      fit: BoxFit.fill,
    );
  }
}
