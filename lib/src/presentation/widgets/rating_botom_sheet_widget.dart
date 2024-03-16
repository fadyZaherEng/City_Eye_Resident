import 'package:city_eye/flavors.dart';
import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/constants.dart';
import 'package:city_eye/src/presentation/widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RatingBottomSheetWidget extends StatefulWidget {
  final void Function(
    double rating,
    String reviewValue,
  ) onSendAction;
  final double rate;
  final String comment;
  final bool isRated;

  const RatingBottomSheetWidget({
    super.key,
    required this.onSendAction,
    required this.rate,
    this.comment = "",
    this.isRated = false,
  });

  @override
  State<RatingBottomSheetWidget> createState() =>
      _RatingBottomSheetWidgetState();
}

class _RatingBottomSheetWidgetState extends State<RatingBottomSheetWidget> {
  final TextEditingController _controller = TextEditingController();
  double _ratingValue = 0.0;
  bool _showRatingError = false;

  final FocusNode _focus = FocusNode();
  bool _textFieldHasFocus = false;

  @override
  void initState() {
    _ratingValue = widget.rate;
    _controller.text = widget.comment.toString();

    _focus.addListener(() {
      setState(() {
        _textFieldHasFocus = _focus.hasFocus;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            S.of(context).rating,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  letterSpacing: -0.24,
                  color: ColorSchemes.black,
                ),
          ),
          const SizedBox(height: 16),
          RatingBar.builder(
            initialRating: _ratingValue,
            minRating: 1,
            direction: Axis.horizontal,
            itemPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            itemCount: 5,
            itemSize: 28,
            ignoreGestures: widget.isRated,
            allowHalfRating: false,
            itemBuilder: (context, index) {
              if (index < _ratingValue) {
                return SvgPicture.asset(
                  ImagePaths.starSelected,
                  width: 28,
                  height: 28,
                  fit: BoxFit.scaleDown,
                );
              } else {
                return SvgPicture.asset(
                  ImagePaths.starUnSelected,
                  width: 28,
                  height: 28,
                  fit: BoxFit.scaleDown,
                );
              }
            },
            onRatingUpdate: (rating) {
              if (!widget.isRated) {
                _ratingValue = rating;
                _showRatingError = false;
                setState(() {});
              }
            },
          ),
          Visibility(
            visible: _showRatingError,
            child: const SizedBox(height: 16),
          ),
          Visibility(
              visible: _showRatingError,
              child: Text(
                S.of(context).pleaseProvideRatingBeforeSubmitting,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: ColorSchemes.redError,
                      letterSpacing: -.24,
                    ),
              )),
          const SizedBox(height: 16),
          SizedBox(
            height: 71,
            width: double.infinity,
            child: TextField(
              focusNode: _focus,
              keyboardType: TextInputType.text,
              controller: _controller,
              expands: true,
              maxLines: null,
              readOnly: widget.isRated,
              textAlign: TextAlign.start,
              textAlignVertical: TextAlignVertical.top,
              decoration: InputDecoration(
                counterText: '',
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: ColorSchemes.lightGray),
                    borderRadius: BorderRadius.circular(12)),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: ColorSchemes.lightGray),
                    borderRadius: BorderRadius.circular(12)),
                border: OutlineInputBorder(
                    borderSide: const BorderSide(color: ColorSchemes.lightGray),
                    borderRadius: BorderRadius.circular(12)),
                errorText: null,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                labelText: S.of(context).typeYourReview,
                labelStyle: _labelStyle(context, _textFieldHasFocus),
              ),
            ),
          ),
          const SizedBox(height: 32),
          Visibility(
            visible: !widget.isRated,
            child: Row(
              children: [
                Expanded(
                  child: CustomButtonWidget(
                    onTap: () {
                      if (_ratingValue == 0.0) {
                        _showRatingError = true;
                        setState(() {});
                      } else {
                        widget.onSendAction(
                          _ratingValue,
                          _controller.text.trim().toString(),
                        );
                      }
                    },
                    text: S.of(context).send,
                    backgroundColor: F.isNiceTouch
                        ? ColorSchemes.ghadeerDarkBlue
                        : ColorSchemes.primary,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextStyle _labelStyle(BuildContext context, bool hasFocus) {
    if (hasFocus || _controller.text.isNotEmpty) {
      return Theme.of(context).textTheme.titleLarge!.copyWith(
            fontWeight: Constants.fontWeightRegular,
            color: ColorSchemes.lightGray,
            letterSpacing: -0.13,
          );
    } else {
      return Theme.of(context).textTheme.titleSmall!.copyWith(
            fontWeight: Constants.fontWeightRegular,
            color: ColorSchemes.lightGray,
            letterSpacing: -0.13,
          );
    }
  }
}
