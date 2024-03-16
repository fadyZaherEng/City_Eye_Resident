import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/domain/entities/landing/partner.dart';
import 'package:city_eye/src/presentation/screens/landing/widgets/partners_logos.dart';
import 'package:flutter/material.dart';

class PartnersSection extends StatelessWidget {
  final List<Partner> partners;

  const PartnersSection({Key? key, required this.partners,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: ColorSchemes.searchBackground,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              S.of(context).ourPartners,
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(
                letterSpacing: -0.16,
                color: ColorSchemes.black,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          PartnersLogos(
            partners: partners,
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
