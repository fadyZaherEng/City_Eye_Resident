import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/constants.dart';
import 'package:city_eye/src/core/utils/convert_timestamp_to_date_format.dart';
import 'package:city_eye/src/core/utils/extensions/color_extension.dart';
import 'package:city_eye/src/core/utils/extensions/days_extension.dart';
import 'package:city_eye/src/domain/entities/history/history.dart';
import 'package:city_eye/src/domain/entities/qr_history/qr_history.dart';
import 'package:city_eye/src/presentation/screens/qr/widgets/activate_action_widget.dart';
import 'package:city_eye/src/presentation/screens/qr/widgets/deactivate_action_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class HistoryCardWidget extends StatelessWidget {
  final QrHistory history;
  final Function(QrHistory) onTapDeActiveAction;
  final Function(QrHistory) onTapActiveAction;
  final Function(int) onTapCardWidget;
  final int qrTypeStatus;

  const HistoryCardWidget({
    super.key,
    required this.history,
    required this.onTapDeActiveAction,
    required this.onTapActiveAction,
    required this.onTapCardWidget,
    required this.qrTypeStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: GestureDetector(
        onTap: () {
          onTapCardWidget(history.id);
        },
        child: Container(
            decoration: BoxDecoration(
              color: ColorSchemes.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                    color: ColorSchemes.lightGray,
                    offset: Offset(0, 1),
                    blurRadius: 30,
                    spreadRadius: 0)
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: ColorSchemes.cardSelected,
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${history.qrType.name} - ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              color: ColorSchemes.black,
                                              letterSpacing: -0.16),
                                    ),
                                    Text(
                                      history.guestType.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            color: ColorSchemes.black,
                                            letterSpacing: -0.16,
                                            fontWeight:
                                                Constants.fontWeightRegular,
                                          ),
                                    ),
                                  ],
                                ),
                                qrTypeStatus == 2
                                    ? const SizedBox.shrink()
                                    : history.isEnabled
                                        ? DeactivateActionWidget(
                                            onTapDeActiveAction:
                                                onTapDeActiveAction,
                                            qrHistory: history,
                                          )
                                        : ActivateActionWidget(
                                            onTapActiveAction:
                                                onTapActiveAction,
                                            qrHistory: history,
                                          )
                              ],
                            ),
                            const SizedBox(height: 6.0),
                            if (history.qrType.id == 2 &&
                                history.unitsQrCodeDays.isNotEmpty) ...[
                              Text(
                                history.unitsQrCodeDays
                                    .map((e) => e.weekDays.name)
                                    .toList()
                                    .toStringDays(),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(
                                      color: ColorSchemes.black,
                                      letterSpacing: -0.24,
                                    ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ] else if (history.qrType.id == 1) ...[
                              Directionality.of(context).name == "ltr" ?
                              Text(
                                history.toDate.isNotEmpty
                                    ? "\u200E${history.fromTime} - ${history.toTime}"
                                    : "",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(
                                      color: ColorSchemes.black,
                                      letterSpacing: -0.24,
                                    ),
                              ):Text(
                                history.toDate.isNotEmpty
                                    ? "\u200E${history.toTime} - ${history.fromTime}"
                                    : "",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(
                                  color: ColorSchemes.black,
                                  letterSpacing: -0.24,
                                ),
                              ),
                            ],
                          ],
                        ),
                      )),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: history.status.color.toColor(),
                                      ),
                                      //history.statusColor
                                      borderRadius: BorderRadius.circular(4)),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Text(history.status.name,
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge!
                                              .copyWith(
                                                  color: history.status.color
                                                      .toColor(),
                                                  //history.statusColor,
                                                  fontWeight: Constants
                                                      .fontWeightMedium,
                                                  letterSpacing: -0.24)),
                                    ),
                                  ),
                                ),
                                SvgPicture.asset(ImagePaths.arrowStatus,
                                    fit: BoxFit.scaleDown,
                                    matchTextDirection: true,
                                    color: history.status.color.toColor()),
                                //history.statusColor
                              ],
                            ),
                            history.qrType.id == 2
                                ? const SizedBox(height: 12)
                                : const SizedBox(height: 5),
                            Visibility(
                              visible: history.qrType.id == 2,
                              child: Row(
                                children: [
                                  SvgPicture.asset(ImagePaths.timeWork1,
                                      fit: BoxFit.scaleDown,
                                      matchTextDirection: true),
                                  const SizedBox(width: 11),
                                  Text(S.of(context).validDate,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .copyWith(
                                              color: ColorSchemes.black,
                                              fontWeight:
                                                  Constants.fontWeightMedium,
                                              letterSpacing: -0.24)),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                SvgPicture.asset(ImagePaths.personalCard,
                                    fit: BoxFit.scaleDown,
                                    matchTextDirection: true),
                                const SizedBox(width: 11),
                                Text(S.of(context).whatFor,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .copyWith(
                                            color: ColorSchemes.black,
                                            fontWeight:
                                                Constants.fontWeightMedium,
                                            letterSpacing: -0.24)),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                SvgPicture.asset(ImagePaths.lock,
                                    height: 20,
                                    width: 20,
                                    fit: BoxFit.scaleDown,
                                    color: ColorSchemes.gray,
                                    matchTextDirection: true),
                                const SizedBox(width: 11),
                                Text(S.of(context).pinCode,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .copyWith(
                                        color: ColorSchemes.black,
                                        fontWeight:
                                        Constants.fontWeightMedium,
                                        letterSpacing: -0.24)),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(width: 22),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(height: 5),
                              Text(
                                  "${convertTimestampToDateIntoFormat(history.createdDateStatus)} at ${history.createdDateStatus.isEmpty ? "" : DateFormat.jm().format(DateTime.parse(history.createdDateStatus))}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                          color: ColorSchemes.gray,
                                          fontWeight: Constants.fontWeightMedium,
                                          letterSpacing: -0.24)),
                              history.qrType.id == 2
                                  ? const SizedBox(height: 22)
                                  : const SizedBox(height: 10),
                              Visibility(
                                  visible: history.qrType.id == 2,
                                  child: Text(
                                      "${convertTimestampToDateIntoFormat(history.toDate)} - ${history.toDate.isEmpty ? "" : DateFormat.jm().format(DateTime.parse(history.toDate))}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .copyWith(
                                              color: ColorSchemes.gray,
                                              fontWeight:
                                                  Constants.fontWeightMedium,
                                              letterSpacing: -0.24))),
                              const SizedBox(height: 17),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.55,
                                child: Text(history.name,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .copyWith(
                                            color: ColorSchemes.gray,
                                            fontWeight:
                                                Constants.fontWeightMedium,
                                            letterSpacing: -0.24)),
                              ),
                              const SizedBox(height: 17),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.55,
                                child: Text(history.pinCode.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .copyWith(
                                        color: ColorSchemes.gray,
                                        fontWeight:
                                        Constants.fontWeightMedium,
                                        letterSpacing: -0.24)),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
