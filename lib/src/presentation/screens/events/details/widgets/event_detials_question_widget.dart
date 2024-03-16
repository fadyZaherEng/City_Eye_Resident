import 'package:city_eye/src/domain/entities/home/home_event_option.dart';
import 'package:city_eye/src/presentation/widgets/custom_button_border_widget.dart';
import 'package:flutter/material.dart';

class EventDetailsQuestionWidget extends StatelessWidget {
  final List<HomeEventOption> eventActions;
  final Function(HomeEventOption) onEventActionSelected;
  final TextEditingController questionTextEditingController;
  final Function() onButtonTab;
  final Function(String) onChange;

  const EventDetailsQuestionWidget({
    Key? key,
    required this.eventActions,
    required this.onEventActionSelected,
    required this.questionTextEditingController,
    required this.onButtonTab,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: eventActions.map((eventAction) {
                  return Row(
                    children: [
                      CustomButtonBorderWidget(
                        onTap: () {
                          onEventActionSelected(eventAction);
                        },
                        buttonTitle: eventAction.name,
                        isSelected:eventAction.isSelectedByUser
                            /*eventAction.id == (selectedEventAction?.id ?? -1)*/,
                      ),
                      const SizedBox(
                        width: 32,
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
