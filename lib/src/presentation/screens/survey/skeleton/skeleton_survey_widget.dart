import 'package:city_eye/src/presentation/screens/survey/skeleton/skeleton_survey_card_widget.dart';
import 'package:flutter/material.dart';

class SkeletonSurveyWidget extends StatelessWidget {
  const SkeletonSurveyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flex(direction: Axis.vertical,  children: [
      Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                  itemCount: 5,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return const Column(
                      children: [
                        SkeletonSurveyCardWidget(),
                        SizedBox(
                          height: 16,
                        ),
                      ],
                    );
                  }),
            ],
          ),
        ),
      ),
    ]);
  }
}
