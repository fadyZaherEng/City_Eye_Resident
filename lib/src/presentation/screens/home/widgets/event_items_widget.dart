import 'package:city_eye/src/domain/entities/home/home_event_item.dart';
import 'package:city_eye/src/domain/entities/home/home_event_option.dart';
import 'package:city_eye/src/presentation/widgets/event/event_card_widget.dart';
import 'package:flutter/material.dart';

class EventItemsWidget extends StatelessWidget {
  final List<HomeEventItem> events;
  Function(HomeEventItem) onCardTap;
  final TextEditingController eventTextEditingController;
  final Function(HomeEventItem, HomeEventOption) onActionSelected;
  final Function() onSendAction;

  EventItemsWidget({
    Key? key,
    this.events = const [],
    required this.onCardTap,
    required this.eventTextEditingController,
    required this.onActionSelected,
    required this.onSendAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: events
            .map((element) => Padding(
                  padding: const EdgeInsets.only(
                      right: 12, left: 12, top: 20, bottom: 16),
                  child: EventCardWidget(
                    boxShadows: const [
                      BoxShadow(
                        blurStyle: BlurStyle.outer,
                        spreadRadius: 0,
                        blurRadius: 15,
                        offset: Offset(0, 1),
                        color: Color.fromRGBO(0, 0, 0, 0.12),
                      )
                    ],
                    onCardTap: (value) {
                      onCardTap(value);
                    },
                    textEditingController: eventTextEditingController,
                    onSelectAction: (value) {
                      onActionSelected(element, value);
                    },
                    onChange: (value) {},
                    event: element,
                    onSendAction: (value) {
                      onSendAction();
                    },
                    selectedEventAction: element.selectAction,
                  ),
                ))
            .toList(),
      ),
    );
  }
}
