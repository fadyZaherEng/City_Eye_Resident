import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/domain/entities/landing/partner.dart';
import 'package:city_eye/src/presentation/screens/landing/widgets/partner_item.dart';
import 'package:flutter/material.dart';

class PartnersLogos extends StatelessWidget {
  final List<Partner> partners;

  const PartnersLogos({
    Key? key,
    required this.partners,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 16),
      child: SizedBox(
        height: 40,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return PartnerItem(
              image: partners[index].logo,
            );
          },
          itemCount: partners.length,
        ),
      ),
    );
  }
}
