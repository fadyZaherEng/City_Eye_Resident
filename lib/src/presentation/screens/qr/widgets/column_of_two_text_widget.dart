import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:flutter/material.dart';

class ColumnOfTwoTextWidget extends StatelessWidget {
  final String value;
  final String leading;

  const ColumnOfTwoTextWidget({
    super.key,
    required this.value,
    required this.leading
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: ColorSchemes.gray, fontSize: 15),
        ),
        const SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Text(
                leading,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.end,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: ColorSchemes.black,
                      fontSize: 15,
                    ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
