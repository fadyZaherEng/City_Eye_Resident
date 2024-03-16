import 'package:city_eye/src/presentation/screens/events/skeleton/skeleton_events_card_widget.dart';
import 'package:flutter/material.dart';

class SkeletonEventsWidget extends StatelessWidget {
  const SkeletonEventsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: ListView.builder(
            itemCount: 5,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return const Column(
                children: [
                  SkeletonEventsCardWidget(),
                  SizedBox(
                    height: 16,
                  ),
                ],
              );
            }),
      ),
    );
  }
}
