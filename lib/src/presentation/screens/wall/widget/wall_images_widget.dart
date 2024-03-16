import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/domain/entities/wall/wall_attachment.dart';
import 'package:city_eye/src/presentation/screens/wall/widget/wall_image_widget.dart';
import 'package:flutter/material.dart';

class WallImagesWidget extends StatefulWidget {
  final List<WallAttachment> wallAttachments;
  final void Function({
    required int imageIndex,
    required List<WallAttachment> images,
  }) onTapImage;

  const WallImagesWidget({
    Key? key,
    required this.onTapImage,
    required this.wallAttachments,
  }) : super(
          key: key,
        );

  @override
  State<WallImagesWidget> createState() => _WallImagesWidgetState();
}

class _WallImagesWidgetState extends State<WallImagesWidget> {
  int _imagesCount = 0;

  @override
  void initState() {
    _imagesCount = widget.wallAttachments.length - 3;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.wallAttachments.length == 1
          ? 190
          : widget.wallAttachments.isNotEmpty
              ? 85
              : 0,
      child: widget.wallAttachments.length == 1
          ? Padding(
              padding: const EdgeInsets.only(
                top: 16,
                bottom: 16,
              ),
              child: GestureDetector(
                  onTap: () => _onTapImage(
                        imageIndex: 0,
                        image: widget.wallAttachments[0].attachment,
                      ),
                  child: Container(
                      width: double.infinity,
                      height: 53,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            8,
                          ),
                          child: WallImageWidget(
                            image: widget.wallAttachments[0].attachment,
                          )))))
          : ListView.builder(
              itemCount: widget.wallAttachments.length >= 4
                  ? 3
                  : widget.wallAttachments.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (
                BuildContext context,
                int index,
              ) {
                return Padding(
                  padding: const EdgeInsets.only(
                    top: 16,
                    right: 16,
                    bottom: 16,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      _onTapImage(
                        imageIndex: index,
                        image: widget.wallAttachments[index].attachment,
                      );
                    },
                    child: Container(
                      width: 89,
                      height: 53,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          8,
                        ),
                        child: widget.wallAttachments.length <= 3
                            ? WallImageWidget(
                                image: widget.wallAttachments[index].attachment,
                              )
                            : Stack(
                                fit: StackFit.expand,
                                children: [
                                  WallImageWidget(
                                    image: widget
                                        .wallAttachments[index].attachment,
                                  ),
                                  index == 2
                                      ? Container(
                                          color: ColorSchemes.blackOpacity,
                                          child: Center(
                                            child: Text(
                                              "+$_imagesCount",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                    color: ColorSchemes.white,
                                                  ),
                                            ),
                                          ),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  void _onTapImage({
    required int imageIndex,
    required String image,
  }) {
    widget.onTapImage(
      imageIndex: imageIndex,
      images: widget.wallAttachments,
    );
  }
}
