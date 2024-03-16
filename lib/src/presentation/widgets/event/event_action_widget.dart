import 'package:city_eye/src/domain/entities/home/home_event_option.dart';
import 'package:city_eye/src/presentation/widgets/custom_button_border_widget.dart';
import 'package:flutter/material.dart';

class EventActionWidget extends StatelessWidget {
  final List<HomeEventOption> actions;
  final Function(HomeEventOption) onSelectAction;

  EventActionWidget(
      {Key? key, this.actions = const [], required this.onSelectAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: actions
                .map((element) => Row(
                      children: [
                        CustomButtonBorderWidget(
                          onTap: () {
                            onSelectAction(element);
                          },
                          buttonTitle: element.name,
                          isSelected: element.isSelectedByUser,
                        ),
                        const SizedBox(
                          width: 32,
                        )
                      ],
                    ))
                .toList(),
          ),
        ));
  }
}
