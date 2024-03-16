import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/presentation/screens/landing/skeleton/skeleton_features_widget.dart';
import 'package:city_eye/src/presentation/screens/landing/skeleton/skeleton_header_widget.dart';
import 'package:city_eye/src/presentation/screens/landing/skeleton/skeleton_partners_widget.dart';
import 'package:city_eye/src/presentation/screens/landing/skeleton/skeleton_slider_widget.dart';
import 'package:city_eye/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonLandingScreen extends StatelessWidget {
  const SkeletonLandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarWidget(
        context,
        title: "City Eye",
        imagePath: ImagePaths.logo,
        isHaveBackButton: false,
        backgroundColor: ColorSchemes.primary.withOpacity(0.04),
      ),
      floatingActionButton: const SkeletonAvatar(
        style: SkeletonAvatarStyle(
          width: 48,
          height: 48,
          shape: BoxShape.circle,
        ),
      ),
      body: const SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            SkeletonHeaderWidget(),
            SizedBox(height: 24),
            SkeletonSliderWidget(),
            SizedBox(height: 24),
            SkeletonPartnersWidget(),
            SizedBox(height: 24),
            SkeletonFeaturesWidget(),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
