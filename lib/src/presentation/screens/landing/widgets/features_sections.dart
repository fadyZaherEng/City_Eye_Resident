import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/domain/entities/landing/feature.dart';
import 'package:city_eye/src/presentation/widgets/card_widget.dart';
import 'package:city_eye/src/presentation/widgets/circular_icon.dart';
import 'package:flutter/material.dart';

class FeaturesSection extends StatelessWidget {
  final List<Feature> cards;
  final Function(Feature) onFeatureTap;

  const FeaturesSection({
    Key? key,
    required this.cards,
    required this.onFeatureTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            S.of(context).ourFeatures,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  letterSpacing: -0.16,
                  color: ColorSchemes.black,
                ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: GridView.builder(
            itemCount: cards.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.0,
              crossAxisSpacing: 0.0,
              mainAxisSpacing: 16,
              mainAxisExtent: 155,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => onFeatureTap(cards[index]),
                child: CardWidget(
                  widget: CircularIcon(
                    iconSize: 28,
                    isNetworkImage: cards[index].logo.isNotEmpty,
                    imagePath: cards[index].logo.isNotEmpty
                        ? cards[index].logo
                        : ImagePaths.frame,
                    boxShadows: const [
                      BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 24,
                        spreadRadius: 0,
                        color: Color.fromRGBO(23, 43, 77, 0.16),
                      ),
                    ],
                    backgroundColor: ColorSchemes.iconBackGround,
                    iconColor: ColorSchemes.primary,
                  ),
                  title: cards[index].name,
                  subtitle: cards[index].description,
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
