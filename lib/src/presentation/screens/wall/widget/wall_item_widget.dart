import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/constants.dart';
import 'package:city_eye/src/core/utils/convert_timestamp_to_date_format.dart';
import 'package:city_eye/src/core/utils/english_numbers.dart';
import 'package:city_eye/src/domain/entities/wall/wall.dart';
import 'package:city_eye/src/domain/entities/wall/wall_attachment.dart';
import 'package:city_eye/src/presentation/screens/wall/widget/wall_images_widget.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class WallItemWidget extends StatefulWidget {
  final Wall walls;
  final int index;
  final void Function({
    required int imageIndex,
    required List<WallAttachment> images,
  }) onTapImage;
  final Color borderColor;

  const WallItemWidget({
    Key? key,
    required this.walls,
    required this.index,
    required this.onTapImage,
    this.borderColor = ColorSchemes.white,
  }) : super(
          key: key,
        );

  @override
  State<WallItemWidget> createState() => _WallItemWidgetState();
}

class _WallItemWidgetState extends State<WallItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(
            8,
          ),
          child: Container(
            padding: const EdgeInsets.all(
              8,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: widget.borderColor,
                width: 1,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 38,
                      height: 38,
                      child: ClipOval(
                        child: Image.network(
                          widget.walls.mainImage,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              ImagePaths.avatarImage,
                              fit: BoxFit.cover,
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
                                  )
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 11,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.walls.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontWeight: Constants.fontWeightMedium,
                                      color: ColorSchemes.black,
                                      letterSpacing: -0.24,
                                    ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text("${S.of(context).by} ${widget.walls.createdBy}",
                              style:
                                  Theme.of(context).textTheme.bodySmall!.copyWith(
                                        color: ColorSchemes.gray,
                                        letterSpacing: -0.24,
                                      )),
                        ],
                      ),
                    ),
                    const Expanded(
                      child: SizedBox(),
                    ),
                    Text(englishNumbers(convertTimestampToDateFormat(widget.walls.wallDate)),
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: ColorSchemes.gray,
                              letterSpacing: -0.24,
                            )),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(widget.walls.description,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: ColorSchemes.black,
                          letterSpacing: -0.24,
                        )),
                WallImagesWidget(
                    wallAttachments: widget.walls.wallAttachments,
                    onTapImage: ({
                      required int imageIndex,
                      required List<WallAttachment> images,
                    }) {
                      widget.onTapImage(
                        imageIndex: imageIndex,
                        images: images,
                      );
                    }),
              ],
            ),
          ),
        ),
        widget.index != 0
            ? Container(
                width: double.infinity,
                height: 1,
                color: ColorSchemes.lightGray,
              )
            : const SizedBox()
      ],
    );
  }
}
