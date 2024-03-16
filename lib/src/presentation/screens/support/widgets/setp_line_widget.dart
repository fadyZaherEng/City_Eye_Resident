import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/utils/extensions/color_extension.dart';
import 'package:city_eye/src/domain/entities/support/status.dart';
import 'package:flutter/material.dart';

class StepLineWidget extends StatelessWidget {
  final Status status;
  const StepLineWidget({
    Key? key,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30.0,
      height: 2.0,
      color: _getStatusColor(status),
    );
  }

  Color _getStatusColor(Status status) {
    if (status.isCompleted && status.captionStatusCode != "cancelled") {
      return ColorSchemes.green;
    }
    else {
      return status.colorCode.toColor();
    }
  }
}
