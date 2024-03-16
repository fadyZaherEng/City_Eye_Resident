import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/domain/entities/gallery/gallery.dart';
import 'package:city_eye/src/domain/entities/gallery/gallery_attachment.dart';
import 'package:city_eye/src/presentation/screens/gallery_screen/widgets/gallery_item_widget.dart';
import 'package:city_eye/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:flutter/material.dart';

class GalleryContentWidget extends StatefulWidget {
  final List<Gallery> gallery;
  final Function() onBackButtonPressed;
  final void Function({
    required int imageIndex,
    required List<GalleryAttachment> images,
  }) onTapImage;
  final Function() onPullToRefresh;

  const GalleryContentWidget({
    Key? key,
    required this.onBackButtonPressed,
    required this.gallery,
    required this.onTapImage,
    required this.onPullToRefresh,
  }) : super(key: key);

  @override
  State<GalleryContentWidget> createState() => _GalleryContentWidgetState();
}

class _GalleryContentWidgetState extends State<GalleryContentWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarWidget(
        context,
        title: S.of(context).gallery,
        isHaveBackButton: true,
        onBackButtonPressed: widget.onBackButtonPressed,
      ),
      body: Column(
        children: [
          Container(
            height: 3,
            color: ColorSchemes.border,
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: ()=> widget.onPullToRefresh(),
              child: ListView.builder(
                  itemCount: widget.gallery.length,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return GalleryItemWidget(
                      gallery: widget.gallery[index],
                      isLastItem:
                          index == widget.gallery.length - 1 ? true : false,
                      onTapImage: ({
                        required int imageIndex,
                        required List<GalleryAttachment> images,
                      }) {
                        widget.onTapImage(
                          imageIndex: imageIndex,
                          images: images,
                        );
                      },
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }
}
