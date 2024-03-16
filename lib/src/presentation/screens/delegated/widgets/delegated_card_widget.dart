import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/convert_timestamp_to_date_format.dart';
import 'package:city_eye/src/core/utils/english_numbers.dart';
import 'package:city_eye/src/domain/entities/delegated/delegated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../config/theme/color_schemes.dart';

class DelegatedCardWidget extends StatelessWidget {
  final Delegated delegated;
  final void Function(Delegated delegated) deactivateAction;
  final void Function(Delegated delegated) phoneNumberAction;
  final void Function(Delegated delegated) editAction;
  final void Function(Delegated delegated) onScanQRDelegation;

  const DelegatedCardWidget({
    Key? key,
    required this.delegated,
    required this.deactivateAction,
    required this.phoneNumberAction,
    required this.editAction,
    required this.onScanQRDelegation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Container(
        decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: ColorSchemes.border,
                  offset: Offset(0, 0),
                  blurRadius: 15),
            ],
            color: ColorSchemes.white,
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            )),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    delegated.authName,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: ColorSchemes.black,
                          letterSpacing: -0.13,
                        ),
                  ),
                  InkWell(
                    onTap: () => deactivateAction(delegated),
                    child: SvgPicture.asset(
                      ImagePaths.deactivated,
                      fit: BoxFit.scaleDown,
                      color: delegated.isEnabled
                          ? ColorSchemes.gray
                          : ColorSchemes.redError.withOpacity(0.5),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () => phoneNumberAction(delegated),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          ImagePaths.mobile,
                          fit: BoxFit.scaleDown,
                          color: ColorSchemes.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "\u200E${delegated.authMobile}",
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: ColorSchemes.black,
                                    letterSpacing: -0.24,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => editAction(delegated),
                    child: SvgPicture.asset(
                      ImagePaths.edit,
                      fit: BoxFit.scaleDown,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        ImagePaths.timeWork,
                        fit: BoxFit.scaleDown,
                        color: ColorSchemes.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "${englishNumbers(convertTimestampToDateFormat(delegated.fromDate.toString()))} - ",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: ColorSchemes.black,
                              letterSpacing: -0.24,
                            ),
                      ),
                      Text(
                        englishNumbers(convertTimestampToDateFormat(delegated.toDate.toString())),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: ColorSchemes.black,
                              letterSpacing: -0.24,
                            ),
                      ),
                    ],
                  ),
                  const Expanded(child: SizedBox()),
                  InkWell(
                    onTap: () {
                      onScanQRDelegation(
                        delegated,
                      );
                    },
                    child: SvgPicture.asset(
                      ImagePaths.scanQRDelegation,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  // Row(
                  //   children: [
                  //     Text(
                  //       "Unit No" /*delegated.unitNumber*/,
                  //       style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  //             color: ColorSchemes.gray,
                  //             letterSpacing: -0.24,
                  //           ),
                  //     ),
                  //     const SizedBox(width: 8),
                  //     Text(
                  //       "V 10" /*delegated.unitType*/,
                  //       style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  //             color: ColorSchemes.black,
                  //             letterSpacing: -0.24,
                  //           ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
