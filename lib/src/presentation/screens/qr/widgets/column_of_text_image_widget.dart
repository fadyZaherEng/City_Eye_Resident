import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class ColumnOfTextAndImageWidget extends StatelessWidget {
  final String value;
  final String leading;
  final Function(String) onTapImage;

  const ColumnOfTextAndImageWidget(
      {super.key, required this.value, required this.leading,required this.onTapImage});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: ColorSchemes.gray, fontSize: 15),
        ),
        const SizedBox(height: 16.0),
        InkWell(
          onTap: (){
            onTapImage(leading);
          },
          child: ClipRRect(
            borderRadius:
                const BorderRadiusDirectional.all(Radius.circular(12.0)),
            child: Image.network(
              leading,
              width: double.infinity,
              height: 140.0,
              fit: BoxFit.cover,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return ClipRRect(
                  borderRadius:
                      const BorderRadiusDirectional.all(Radius.circular(12.0)),
                  child: Image.asset(
                    width: double.infinity,
                    height: 140.0,
                    fit: BoxFit.cover,
                    ImagePaths.imagePlaceHolder,
                  ),
                );
              },
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return  SizedBox(
                  width: double.infinity,
                  height: 140.0,
                  child: SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                        borderRadius: BorderRadius.circular(12.0),
                      )
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
