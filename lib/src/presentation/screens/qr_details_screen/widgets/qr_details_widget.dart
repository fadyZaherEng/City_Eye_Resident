import 'package:city_eye/flavors.dart';
import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/routes/routes_manager.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/convert_timestamp_to_date_format.dart';
import 'package:city_eye/src/domain/entities/gallery/gallery_attachment.dart';
import 'package:city_eye/src/domain/entities/gallery/images_screen.dart';
import 'package:city_eye/src/domain/entities/qr_history/qr_history_with_questions_answer.dart';
import 'package:city_eye/src/domain/entities/qr_history/unit_qr_code_day.dart';
import 'package:city_eye/src/presentation/screens/qr_details_screen/widgets/question_list_item.dart';
import 'package:city_eye/src/presentation/screens/qr_details_screen/widgets/row_of_two_text_widget.dart';
import 'package:city_eye/src/presentation/widgets/custom_button_widget.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

// ignore: must_be_immutable
class QrDetailsWidget extends StatefulWidget {
  void Function() onTapDownload;
  QrHistoryWithQuestionAnswer qrDetails;

  QrDetailsWidget(
      {required this.onTapDownload, required this.qrDetails, super.key});

  @override
  State<QrDetailsWidget> createState() => _QrDetailsWidgetState();
}

class _QrDetailsWidgetState extends State<QrDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadiusDirectional.circular(15.0),
                      border: Border.all(
                          color: ColorSchemes.cardSelected, width: 1.5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade400,
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        )
                      ]),
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      InkWell(
                        onTap: () {
                          _onTapImage(widget.qrDetails.imageUrl);
                        },
                        child: Image.network(
                          width: 151.0,
                          height: 124.0,
                          widget.qrDetails.imageUrl,
                          errorBuilder: (context, error, stackTrace) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Image.asset(
                                ImagePaths.imagePlaceHolder,
                                fit: BoxFit.cover,
                                width: 151.0,
                                height: 124.0,
                              ),
                            );
                          },
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return SizedBox(
                              width: 151.0,
                              height: 124.0,
                              child: SkeletonAvatar(
                                  style: SkeletonAvatarStyle(
                                borderRadius: BorderRadius.circular(12.0),
                              )),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        widget.qrDetails.qrType.name,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: ColorSchemes.black),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        widget.qrDetails.pinCode.toString(),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: ColorSchemes.black, letterSpacing: 1.5),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: ColorSchemes.otpShadow,
                          borderRadius: BorderRadiusDirectional.circular(8.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.qrDetails.guestType.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: ColorSchemes.primary,
                                        fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Divider(
                        thickness: 3,
                        color: ColorSchemes.dividerGrey,
                      ),
                      const SizedBox(height: 15),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              S.of(context).visitor,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: ColorSchemes.gray, fontSize: 15),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(widget.qrDetails.name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                textAlign: TextAlign.end,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: ColorSchemes.black,
                                        fontSize: 15)),
                            const SizedBox(
                              width: 15,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: DottedLine(
                          direction: Axis.horizontal,
                          lineLength: double.infinity,
                          lineThickness: 0.7,
                          dashLength: 4,
                          dashColor: ColorSchemes.gray,
                          dashGapLength: 3,
                        ),
                      ),
                      widget.qrDetails.qrType.id == 2
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        S.of(context).days,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                color: ColorSchemes.gray,
                                                fontSize: 15),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        physics: const BouncingScrollPhysics(),
                                        child: Row(
                                          children: widget
                                              .qrDetails.unitsQrCodeDays
                                              .map((unitQrCodeDay) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4),
                                              child: _daysWidget(unitQrCodeDay),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                    width: double.infinity,
                                  ),
                                ],
                              ),
                            )
                          : Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: DottedLine(
                                    direction: Axis.horizontal,
                                    lineLength: double.infinity,
                                    lineThickness: 0.7,
                                    dashLength: 4,
                                    dashColor: ColorSchemes.gray,
                                    dashGapLength: 3,
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Directionality.of(context).name ==
                                        TextDirection.rtl.name
                                    ? RowOfTwoTextWidget(
                                        leading: S.of(context).visitTime,
                                        value:
                                            "\u200E${widget.qrDetails.toTime} - ${widget.qrDetails.fromTime}",
                                      )
                                    : RowOfTwoTextWidget(
                                        leading: S.of(context).visitTime,
                                        value:
                                            "\u200E${widget.qrDetails.fromTime} - ${widget.qrDetails.toTime}",
                                      ),
                                const SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: DottedLine(
                          direction: Axis.horizontal,
                          lineLength: double.infinity,
                          lineThickness: 0.7,
                          dashLength: 4,
                          dashColor: ColorSchemes.gray,
                          dashGapLength: 3,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      RowOfTwoTextWidget(
                        leading: widget.qrDetails.qrType.id == 2
                            ? S.of(context).qrExpireDate
                            : S.of(context).visitDate,
                        value: widget.qrDetails.qrType.id == 2
                            ? convertTimestampToDateFormat(
                                widget.qrDetails.toDate)
                            : convertTimestampToDateFormat(
                                widget.qrDetails.toDate),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      /*Visibility(
                        visible: widget.qrDetails.qrType.id == 1,
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: DottedLine(
                                direction: Axis.horizontal,
                                lineLength: double.infinity,
                                lineThickness: 0.7,
                                dashLength: 4,
                                dashColor: ColorSchemes.gray,
                                dashGapLength: 3,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Directionality.of(context).name ==
                                    TextDirection.rtl.name
                                ? RowOfTwoTextWidget(
                                    leading: S.of(context).visitTime,
                                    value:
                                        "\u200E${widget.qrDetails.toTime} - ${widget.qrDetails.fromTime}",
                                  )
                                : RowOfTwoTextWidget(
                                    leading: S.of(context).visitTime,
                                    value:
                                        "\u200E${widget.qrDetails.fromTime} - ${widget.qrDetails.toTime}",
                                  ),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ),*/
                      if (widget
                          .qrDetails.unitQRQuestionAnswers.isNotEmpty) ...[
                        Column(
                          children: widget.qrDetails.unitQRQuestionAnswers
                              .map((element) => QuestionListItem(
                                    qrDetailsQuestion: element,
                                    onTapImage: (image) {
                                      _onTapImage(image);
                                    },
                                  ))
                              .toList(),
                        )
                      ] else ...[
                        const SizedBox.shrink(),
                      ],
                      Visibility(
                        visible: widget.qrDetails.qrMessage.isNotEmpty,
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: DottedLine(
                                direction: Axis.horizontal,
                                lineLength: double.infinity,
                                lineThickness: 0.7,
                                dashLength: 4,
                                dashColor: ColorSchemes.gray,
                                dashGapLength: 3,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              widget.qrDetails.qrMessage,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: ColorSchemes.black),
                            ),
                            const SizedBox(height: 12),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                CustomButtonWidget(
                  width: double.infinity,
                  onTap: widget.onTapDownload,
                  text: S.of(context).downloadQrCodeDetails,
                  backgroundColor: F.isNiceTouch
                      ? ColorSchemes.ghadeerDarkBlue
                      : ColorSchemes.primary,
                ),
                const SizedBox(height: 16),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _onTapImage(String image) {
    Navigator.pushNamed(context, Routes.galleryImages,
        arguments: GalleryImages(initialIndex: 0, images: [
          GalleryAttachment(attachment: image),
        ]));
  }

  Widget _daysWidget(UnitsQrCodeDay unitsQrCodeDays) {
    return Container(
        decoration: BoxDecoration(
          color: ColorSchemes.white,
          borderRadius: BorderRadiusDirectional.circular(8.0),
          border: Border.all(color: ColorSchemes.black, width: 0.5),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Column(
            children: [
              Text(unitsQrCodeDays.weekDays.name,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: ColorSchemes.black,
                      )),
              const SizedBox(
                height: 4,
              ),
              Text(
                  Directionality.of(context).name == "ltr"
                      ? "\u200E${unitsQrCodeDays.dayTime.fromTime} - ${unitsQrCodeDays.dayTime.toTime}"
                      : "\u200E${unitsQrCodeDays.dayTime.toTime} - ${unitsQrCodeDays.dayTime.fromTime}",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: ColorSchemes.black,
                      )),
            ],
          ),
        ));
  }
}
