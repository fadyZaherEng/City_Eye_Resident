import 'dart:io';

import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationsSwitchButtonWidget extends StatefulWidget {
  final bool value;
  final void Function(bool value) onTap;

  const NotificationsSwitchButtonWidget(
      {Key? key, required this.value, required this.onTap})
      : super(key: key);

  @override
  State<NotificationsSwitchButtonWidget> createState() =>
      _NotificationsSwitchButtonWidgetState();
}

class _NotificationsSwitchButtonWidgetState
    extends State<NotificationsSwitchButtonWidget> {

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? SizedBox(
            height: 16,
            child: Transform.scale(
              scale: 0.7,
              child: CupertinoSwitch(
                activeColor: ColorSchemes.primary,
                value: widget.value,
                onChanged: (value) {
                  widget.onTap(value);
                },
              ),
            ),
          )
        : SizedBox(
            height: 16,
            child: Switch(
              activeTrackColor: ColorSchemes.primary,
              activeColor: ColorSchemes.white,
              value: widget.value,
              onChanged: (value) {
                widget.onTap(value);
              },
            ),
          );
  }
}
