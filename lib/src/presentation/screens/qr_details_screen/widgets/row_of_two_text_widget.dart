import 'package:flutter/material.dart';

import '../../../../config/theme/color_schemes.dart';

// ignore: must_be_immutable
class RowOfTwoTextWidget extends StatelessWidget {
  final String leading;
  final String value;

  const RowOfTwoTextWidget(
      {super.key,
      required this.leading,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 15,
        ),
        Expanded(
          flex: 2,
          child: Text(
            leading,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(
                color: ColorSchemes.gray, fontSize: 15),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            value,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            textAlign: TextAlign.end,
            style: Theme
                .of(context)
                .textTheme
                .bodySmall!
                .copyWith(
                color: ColorSchemes.black, fontSize: 15)
          ),
        ),
        const SizedBox(
          width: 15,
        ),
      ],
    );
  }
}
