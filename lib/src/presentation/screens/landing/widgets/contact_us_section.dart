import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/presentation/widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';

class ContactUsSection extends StatelessWidget {
  final Function() onRequestNow;

  const ContactUsSection({
    Key? key,
    required this.onRequestNow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage(ImagePaths.contactUsBackground),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          Text(
            S.of(context).contactUs,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  letterSpacing: -0.16,
                  color: ColorSchemes.white,
                ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            S.of(context).youCanRequestYourService,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  letterSpacing: -0.24,
                  color: ColorSchemes.white,
                ),
          ),
          const SizedBox(
            height: 12,
          ),
          CustomButtonWidget(
            onTap: onRequestNow,
            text: S.of(context).requestNow,
            textColor: ColorSchemes.primary,
            backgroundColor: ColorSchemes.white,
            height: 40,
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
