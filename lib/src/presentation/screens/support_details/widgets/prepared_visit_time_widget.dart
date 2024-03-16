import 'dart:developer';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/domain/entities/support_details/day_times.dart';
import 'package:city_eye/src/domain/entities/support_details/prepared_visit_time.dart';
import 'package:city_eye/src/presentation/screens/support_details/skelton/skeleton_prepared_visit_time.dart';
import 'package:city_eye/src/presentation/widgets/custom_button_border_widget.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart' as intl;

class PreparedVisitTimeWidget extends StatelessWidget {
  final List<DayTimes> preparedVisitTime;
  final Function(DayTimes) onSelectTimeTap;
  final Function() onDateTap;
  final DateTime selectedDate;
  final bool showSkeleton;

  const PreparedVisitTimeWidget({
    Key? key,
    required this.preparedVisitTime,
    required this.onSelectTimeTap,
    required this.onDateTap,
    required this.selectedDate,
    required this.showSkeleton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                S.of(context).preparedVisitTime,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ColorSchemes.black,
                      letterSpacing: -0.13,
                    ),
              ),
              const Expanded(child: SizedBox()),
              InkWell(
                onTap: () {
                  onDateTap();
                },
                child: Row(
                  children: [
                    SvgPicture.asset(
                      ImagePaths.calender,
                      color: ColorSchemes.secondary,
                      fit: BoxFit.scaleDown,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _getDateFormat(context),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: ColorSchemes.secondary,
                            letterSpacing: -0.13,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          showSkeleton ? const SkeletonPreparedVisitTime(): SizedBox(
            height: 40,
            child: ListView.builder(
                itemCount: preparedVisitTime.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      CustomButtonBorderWidget(
                        onTap: () {
                          onSelectTimeTap(preparedVisitTime[index]);
                        },
                        buttonTitle: Directionality.of(context).name ==
                                TextDirection.rtl.name
                            ? "\u200E${preparedVisitTime[index].time}"
                            : preparedVisitTime[index].time,
                        isSelected: preparedVisitTime[index].isSelected,
                      ),
                      const SizedBox(width: 12),
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }

  String _getDateFormat(BuildContext context) {
    return selectedDate.compareTo(DateTime(DateTime.now().year,
                DateTime.now().month, DateTime.now().day)) ==
            0
        ? S.of(context).today
        : intl.DateFormat("dd MMMM yyyy").format(selectedDate);
  }
}
