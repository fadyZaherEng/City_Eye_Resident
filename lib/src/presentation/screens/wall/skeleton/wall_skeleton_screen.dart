import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/presentation/screens/wall/skeleton/wall_skeleton_item_widget.dart';
import 'package:city_eye/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:flutter/material.dart';

class WallSkeletonScreen extends StatefulWidget {
  const WallSkeletonScreen({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  State<WallSkeletonScreen> createState() => _WallSkeletonScreenState();
}

class _WallSkeletonScreenState extends State<WallSkeletonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBarWidget(
          context,
          title: S.of(context).wall,
          isHaveBackButton: false,
        ),
        body: Column(
          children: [
            Container(
              height: 3,
              color: ColorSchemes.border,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return const WallSkeletonItemWidget();
                  }),
            )
          ],
        ));
  }
}
