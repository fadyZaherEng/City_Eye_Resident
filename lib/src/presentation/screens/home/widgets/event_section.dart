import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/domain/entities/home/home_event_item.dart';
import 'package:city_eye/src/domain/entities/home/home_event_option.dart';
import 'package:city_eye/src/presentation/screens/home/widgets/event_items_widget.dart';
import 'package:flutter/material.dart';

class EventSection extends StatelessWidget {
  final List<HomeEventItem> events;
  final Function(HomeEventItem) onCardTap;
  final TextEditingController eventTextEditingController;
  final Function(HomeEventItem, HomeEventOption) onActionSelected;
  final Function() onSendAction;
  final Function() onTapSeeAll;

  EventSection(
      {Key? key,
      this.events = const [],
      required this.onCardTap,
      required this.eventTextEditingController,
      required this.onActionSelected,
      required this.onSendAction,
      required this.onTapSeeAll})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0,left: 16.0,top: 16.0),
          child: Row(
            children: [
              Text(S.of(context).events,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: ColorSchemes.black, letterSpacing: -0.24)),
              const Expanded(
                child: SizedBox(),
              ),
              InkWell(
                onTap: () {
                  onTapSeeAll();
                },
                child: Text(S.of(context).seeAll,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(letterSpacing: -0.24)),
              ),
            ],
          ),
        ),
        EventItemsWidget(
            events: events,
            onCardTap: (value) {
              onCardTap(value);
            },
            onSendAction: () {
              onSendAction();
            },
            onActionSelected: (item, value) {
              onActionSelected(item, value);
            },
            eventTextEditingController: eventTextEditingController,
          ),

      ],
    );
  }
}
