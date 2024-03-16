import 'dart:async';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/di/data_layer_injector.dart';
import 'package:city_eye/src/domain/entities/wall/wall.dart';
import 'package:city_eye/src/domain/entities/wall/wall_attachment.dart';
import 'package:city_eye/src/domain/usecase/get_wall_item_id_use_case.dart';
import 'package:city_eye/src/domain/usecase/set_wall_item_id_use_case.dart';
import 'package:city_eye/src/presentation/screens/wall/widget/wall_item_widget.dart';
import 'package:city_eye/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:flutter/material.dart';

class WallContentWidget extends StatefulWidget {
  final List<Wall> walls;
  final void Function({
    required int imageIndex,
    required List<WallAttachment> images,
  }) onTapImage;
  final Function() onPullToRefresh;
  final Function(GlobalKey) onScrollToItem;
  final Color borderColor;

  const WallContentWidget({
    Key? key,
    required this.walls,
    required this.onTapImage,
    required this.onPullToRefresh,
    required this.onScrollToItem,
    this.borderColor = ColorSchemes.white,
  }) : super(key: key);

  @override
  State<WallContentWidget> createState() => _WallContentWidgetState();
}

class _WallContentWidgetState extends State<WallContentWidget> {
  var itemCount = 0;
  var _key;
  var scrollToId = 0;

  @override
  void initState() {
    scrollToId = GetWallItemIdUseCase(injector())();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarWidget(
        context,
        title: S.of(context).wall,
        isHaveBackButton: false,
      ),
      body: RefreshIndicator(
        onRefresh: () => widget.onPullToRefresh(),
        child: SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                Container(
                  height: 3,
                  color: ColorSchemes.border,
                ),
                Column(
                  children: [
                    ListView.builder(
                        itemCount: widget.walls.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          itemCount++;
                          if (scrollToId != 0 &&
                              widget.walls[index].id == scrollToId) {
                            _key = widget.walls[index].key;
                          }
                          if (itemCount <= widget.walls.length &&
                              _key != null) {
                            widget.onScrollToItem(_key);
                          }
                          return WallItemWidget(
                            key: widget.walls[index].key,
                            walls: widget.walls[index],
                            borderColor: widget.walls[index].id == scrollToId &&
                                    _key != null
                                ? widget.borderColor
                                : ColorSchemes.white,
                            index: index == widget.walls.length - 1 ? 0 : 1,
                            onTapImage: ({
                              required int imageIndex,
                              required List<WallAttachment> images,
                            }) {
                              widget.onTapImage(
                                imageIndex: imageIndex,
                                images: images,
                              );
                            },
                          );
                        }),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
