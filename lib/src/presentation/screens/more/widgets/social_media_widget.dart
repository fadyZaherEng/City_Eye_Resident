import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/domain/entities/settings/compound_social_media.dart';
import 'package:city_eye/src/presentation/widgets/circular_icon.dart';
import 'package:flutter/material.dart';

class SocialMediaWidget extends StatelessWidget {
  final List<CompoundSocialMedia> socialMedias;
  final Function(CompoundSocialMedia) onSocialMediaTap;

  const SocialMediaWidget({
    Key? key,
    required this.socialMedias,
    required this.onSocialMediaTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        itemCount: socialMedias.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return socialMedias[index].value.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: InkWell(
                    onTap: () {
                      onSocialMediaTap(socialMedias[index]);
                    },
                    child: CircularIcon(
                      isNetworkImage: true,
                      imagePath: socialMedias[index].socialMediaType.logo,
                      backgroundColor: ColorSchemes.white,
                      boxShadows: const [
                        BoxShadow(
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                            blurRadius: 32,
                            color: Color.fromRGBO(0, 0, 0, 0.12))
                      ],
                      iconSize: 24,
                      iconColor: ColorSchemes.primary,
                    ),
                  ),
                )
              : const SizedBox.shrink();
        },
      ),
    );
  }
}
