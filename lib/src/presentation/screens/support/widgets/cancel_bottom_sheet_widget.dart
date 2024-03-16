import 'package:city_eye/flavors.dart';
import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/base/widget/base_stateful_widget.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/constants.dart';
import 'package:city_eye/src/domain/entities/support/orders.dart';
import 'package:city_eye/src/presentation/widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CancelBottomSheetWidget extends BaseStatefulWidget {
  final Function(String) onSend;

  const CancelBottomSheetWidget({
    Key? key,
    required this.onSend,
  }) : super(key: key);

  @override
  BaseState<CancelBottomSheetWidget> baseCreateState() =>
      _CancelBottomSheetWidgetState();
}

class _CancelBottomSheetWidgetState extends BaseState<CancelBottomSheetWidget> {
  final TextEditingController _reasonController = TextEditingController();
  String? _reasonErrorMessage;

  final FocusNode _focus = FocusNode();
  bool _textFieldHasFocus = false;

  @override
  void initState() {
    _focus.addListener(() {
      setState(() {
        _textFieldHasFocus = _focus.hasFocus;
      });
    });
    super.initState();
  }

  @override
  Widget baseBuild(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: _reasonErrorMessage == null ? 80 : 103,
          child: TextField(
            focusNode: _focus,
            keyboardType: TextInputType.text,
            controller: _reasonController,
            onChanged: (value) {
              _validateReasonField(value);
            },
            expands: true,
            maxLines: null,
            textAlign: TextAlign.start,
            textAlignVertical: TextAlignVertical.top,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: _getBorderColor()),
                  borderRadius: BorderRadius.circular(12)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: _getBorderColor()),
                  borderRadius: BorderRadius.circular(12)),
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: _getBorderColor()),
                  borderRadius: BorderRadius.circular(12)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: _getBorderColor()),
                  borderRadius: BorderRadius.circular(12)),
              errorText: _reasonErrorMessage,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              labelText: S.of(context).typeYourReason,
              labelStyle: _labelStyle(context, _textFieldHasFocus),
              errorMaxLines: 2,
            ),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        CustomButtonWidget(
          onTap: () {
            if (_reasonController.text.trim().toString().isNotEmpty) {
              widget.onSend(_reasonController.text.trim().toString());
            } else {
              _reasonErrorMessage = S.of(context).thisFieldIsRequired;
              setState(() {});
            }
          },
          text: S.of(context).send,
          width: double.infinity,
          backgroundColor: F.isNiceTouch
              ? ColorSchemes.ghadeerDarkBlue
              : ColorSchemes.primary,
        ),
      ],
    );
  }

  void _validateReasonField(String value) {
    if (value.isEmpty) {
      _reasonErrorMessage = S.of(context).thisFieldIsRequired;
    } else {
      _reasonErrorMessage = null;
    }
    setState(() {});
  }

  Color _getBorderColor() {
    if (_reasonErrorMessage == null) {
      return ColorSchemes.border;
    } else {
      return ColorSchemes.redError;
    }
  }

  TextStyle _labelStyle(BuildContext context, bool hasFocus) {
    if (hasFocus || _reasonController.text.isNotEmpty) {
      return Theme.of(context).textTheme.titleLarge!.copyWith(
        fontWeight: Constants.fontWeightRegular,
        color: _getBorderColor(),
        letterSpacing: -0.13,
      );
    } else {
      return Theme.of(context).textTheme.titleSmall!.copyWith(
        fontWeight: Constants.fontWeightRegular,
        color: _getBorderColor(),
        letterSpacing: -0.13,
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _reasonController.dispose();
  }
}
