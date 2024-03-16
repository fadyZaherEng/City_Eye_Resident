import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/routes/routes_manager.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/domain/entities/gallery/images_screen.dart';
import 'package:city_eye/src/domain/entities/sign_in/user.dart';
import 'package:city_eye/src/domain/entities/sign_in/user_unit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeletons/skeletons.dart';

class UserInformationWidget extends StatelessWidget {
  final User user;
  final UserUnit userUnit;
  final Function(String) onTapImageProfile;

  const UserInformationWidget({
    Key? key,
    required this.user,
    required this.userUnit,
    required this.onTapImageProfile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            onTapImageProfile(user.userInformation.image);
          },
          child: Container(
            clipBehavior: Clip.antiAlias,
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              border: Border.all(
                color: ColorSchemes.primary,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(50),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(
                user.userInformation.image,
                fit: BoxFit.fill,
                errorBuilder: (
                  context,
                  error,
                  stackTrace,
                ) {
                  return ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: SvgPicture.asset(
                        ImagePaths.avatar,
                        fit: BoxFit.fill,
                      ));
                },
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: SkeletonLine(
                        style: SkeletonLineStyle(
                          width: double.infinity,
                          height: double.infinity,
                          borderRadius: BorderRadius.circular(
                            4,
                          ),
                        )
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(user.userInformation.name,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: ColorSchemes.black, letterSpacing: -0.24)),
            const SizedBox(height: 4),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Text(
                  "${userUnit.compoundName} ${userUnit.userTypeName} - ${userUnit.unitName}",
                  maxLines: 2,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: ColorSchemes.gray, letterSpacing: -0.24)),
            ),
          ],
        ),
      ],
    );
  }
}
