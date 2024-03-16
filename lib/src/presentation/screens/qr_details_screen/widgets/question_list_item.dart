import 'package:city_eye/src/domain/entities/qr_details/qr_details_question.dart';
import 'package:city_eye/src/domain/entities/qr_history/unit_qr_question_answer.dart';
import 'package:city_eye/src/presentation/screens/qr/widgets/column_of_text_image_widget.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

import '../../../../config/theme/color_schemes.dart';

// ignore: must_be_immutable
class QuestionListItem extends StatelessWidget {
  UnitQrQuestionAnswer qrDetailsQuestion;
  final Function(String) onTapImage;

  QuestionListItem({super.key, required this.qrDetailsQuestion, required this.onTapImage});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
        Padding(
          padding: const EdgeInsets.all(15),
          child: qrDetailsQuestion.controlTypeCode == 'image'
              ? ColumnOfTextAndImageWidget(
                  value: qrDetailsQuestion.lable,
                  leading: qrDetailsQuestion.value,
                  onTapImage: (image) {
                    onTapImage(image);
                  },
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      qrDetailsQuestion.lable,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: ColorSchemes.gray, fontSize: 15),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                        qrDetailsQuestion.value.isNotEmpty
                            ? qrDetailsQuestion.value
                            : 'There is no Answer',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: ColorSchemes.black, fontSize: 15)),
                  ],
                ),
        ),
      ],
    );
  }
}
