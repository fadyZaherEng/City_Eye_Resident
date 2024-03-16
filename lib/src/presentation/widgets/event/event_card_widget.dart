import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/constants.dart';
import 'package:city_eye/src/core/utils/convert_string_to_date_format.dart';
import 'package:city_eye/src/core/utils/format_date_time.dart';
import 'package:city_eye/src/domain/entities/home/home_event_item.dart';
import 'package:city_eye/src/domain/entities/home/home_event_option.dart';
import 'package:city_eye/src/presentation/widgets/event/event_action_widget.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

class EventCardWidget extends StatefulWidget {
  final HomeEventItem event;
  final TextEditingController textEditingController;
  final Function(HomeEventOption) onSelectAction;
  final Function(String)? onSendAction;
  final HomeEventOption? selectedEventAction;
  final Function(String) onChange;
  final double width;
  final List<BoxShadow>? boxShadows;
  final Function(HomeEventItem) onCardTap;
  final Color borderColor;

  const EventCardWidget({
    Key? key,
    required this.event,
    required this.textEditingController,
    required this.onSelectAction,
    required this.onChange,
    required this.onCardTap,
    this.onSendAction,
    this.selectedEventAction,
    this.width = 360,
    this.boxShadows,
    this.borderColor = ColorSchemes.white,
  }) : super(key: key);

  @override
  State<EventCardWidget> createState() => _EventCardWidgetState();
}

class _EventCardWidgetState extends State<EventCardWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onCardTap(widget.event);
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              decoration: BoxDecoration(
                color: ColorSchemes.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: widget.boxShadows,
                border: Border.all(
                  color: widget.borderColor,
                  width: 1.5,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      widget.event.title,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: ColorSchemes.black, letterSpacing: -0.24),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  _defaultSize(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        SvgPicture.asset(ImagePaths.grayCalendar),
                        const SizedBox(width: 5),
                        Text(
                          S.of(context).eventDate,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                                  color: ColorSchemes.gray,
                                  letterSpacing: -0.24),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          formatDateTime(convertStringToDateFormat(
                              widget.event.endDate)),
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                                  color: ColorSchemes.black,
                                  letterSpacing: -0.24),
                        ),
                      ],
                    ),
                  ),
                  _defaultSize(),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6),
                    child: Divider(
                      color: ColorSchemes.lightGray,
                      height: 1,
                    ),
                  ),
                  _defaultSize(),
                  EventActionWidget(
                      onSelectAction: (eventAction) {
                        widget.onSelectAction(eventAction);
                      },
                      actions: widget.event.eventsOptions),
                  _defaultSize(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        Visibility(
                          visible: widget.event.showTotalMembers,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    ImagePaths.surveyCount,
                                    fit: BoxFit.scaleDown,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: Text(
                                      S.of(context).totalMembersWhoJoinedTheEvent,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                        color: ColorSchemes.gray,
                                        letterSpacing: -0.24,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    " (${widget.event.memberCount} / ${widget.event.maxCountJoin})",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                      color: ColorSchemes.black,
                                      letterSpacing: -0.24,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            widget.event.isPaid
                ? Align(
                    alignment: AlignmentDirectional.topEnd,
                    child: Container(
                      width: 45,
                      height: 20,
                      decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadiusDirectional.only(topEnd: Radius.circular(16)),
                        color: ColorSchemes.secondary,
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(S.of(context).paid,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                    color: ColorSchemes.white,
                                    fontWeight: Constants.fontWeightMedium,
                                    letterSpacing: -0.24)),
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  SizedBox _defaultSize() {
    return const SizedBox(height: 13);
  }
}
