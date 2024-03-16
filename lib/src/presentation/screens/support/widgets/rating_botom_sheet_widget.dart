import 'package:city_eye/flavors.dart';
import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/presentation/widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RatingBottomSheetWidget extends StatefulWidget {
  final void Function(
    double rating,
    String reviewValue,
  ) onSendAction;
  final double ratingValue;

  const RatingBottomSheetWidget({
    super.key,
    required this.onSendAction,
    required this.ratingValue,
  });

  @override
  State<RatingBottomSheetWidget> createState() =>
      _RatingBottomSheetWidgetState();
}

class _RatingBottomSheetWidgetState extends State<RatingBottomSheetWidget> {
  final TextEditingController _controller = TextEditingController();
double _ratingValue =0.0;

@override
  void initState() {
  _ratingValue =widget.ratingValue;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          children: [
            SvgPicture.asset(
              ImagePaths.rating,
              fit: BoxFit.scaleDown,
              matchTextDirection: true,
            ),
            const SizedBox(height: 16),
            Text(
              S.of(context).rating,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    letterSpacing: -0.24,
                    color: ColorSchemes.black,
                  ),
            ),
            RatingBar.builder(
              initialRating: _ratingValue,
              minRating: 1,
              direction: Axis.horizontal,
              itemPadding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 32),
              itemCount: 5,
              itemSize: 28,
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
                _ratingValue = rating;
              },
            ),
            SizedBox(
              height: 71,
              width: double.infinity,
              child: TextField(
                keyboardType: TextInputType.text,
                controller: _controller,
                expands: true,
                maxLines: null,
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
                  labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ColorSchemes.gray,
                        letterSpacing: -0.13,
                      ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: CustomButtonWidget(
                    onTap: () => widget.onSendAction(
                         _ratingValue,
                         _controller.text),
                    text: S.of(context).send,
                    backgroundColor: F.isNiceTouch
                        ? ColorSchemes.ghadeerDarkBlue
                        : ColorSchemes.primary,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
