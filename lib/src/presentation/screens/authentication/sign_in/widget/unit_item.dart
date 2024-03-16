import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/constants.dart';
import 'package:city_eye/src/core/utils/format_date.dart';
import 'package:city_eye/src/domain/entities/sign_in/user_unit.dart';
import 'package:city_eye/src/presentation/widgets/custom_radio_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class UnitItem extends StatefulWidget {
  final UserUnit userUnit;
  final bool isLastItem;
  final Function() onTap;

  const UnitItem({
    Key? key,
    required this.userUnit,
    required this.isLastItem,
    required this.onTap,
  }) : super(key: key);

  @override
  State<UnitItem> createState() => _UnitItemState();
}

class _UnitItemState extends State<UnitItem> {
  late UserUnit _userUnit;

  @override
  void initState() {
    super.initState();
    _userUnit = widget.userUnit;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _userUnit = widget.userUnit.copyWith(
            isSelected: !_userUnit.isSelected,
          );
        });
        widget.onTap();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 17,
          ),
          Row(
            children: [
              SizedBox(
                  width: 56,
                  height: 40,
                  child: Image.network(
                    _userUnit.compoundLogo,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        ImagePaths.uploadImagePlaceholder,
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: _buildImageLoadingSkeleton(),
                      );
                    }
                  )),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _userUnit.compoundName,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            letterSpacing: -0.24,
                            color: ColorSchemes.black,
                          ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${_userUnit.userTypeName} -",
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    letterSpacing: -0.24,
                                    color: ColorSchemes.gray,
                                  ),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          _userUnit.unitName,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                letterSpacing: -0.24,
                                color: ColorSchemes.gray,
                              ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                    "- ${_userUnit.isActive ? S.of(context).active : S.of(context).inactive} ${_userUnit.isCompoundVerified ? " - ${S.of(context).verified}" : " - ${S.of(context).unverified}"}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .copyWith(
                                          letterSpacing: -0.24,
                                          fontWeight: Constants.fontWeightMedium,
                                          color: ColorSchemes.gray,
                                        ),
                                    textAlign: TextAlign.start),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20)
                      ],
                    ),
                    _buildContractEndDate(),
                  ],
                ),
              ),
              CustomRadioButtonWidget(
                isSelected: widget.userUnit.isSelected,
              ),
            ],
          ),
          const SizedBox(
            height: 11,
          ),
          widget.isLastItem == false
              ? Container(
                  height: 1,
                  color: ColorSchemes.lightGray,
                  width: double.infinity,
                )
              : const SizedBox()
        ],
      ),
    );
  }

  SingleChildRenderObjectWidget _buildContractEndDate() {
    if (_userUnit.userTypeId == 1) return const SizedBox.shrink();
    return _userUnit.userUnitContractEndDate.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(
              top: 5,
            ),
            child: Text(
              "${S.of(context).end} ${formatDate(_userUnit.userUnitContractEndDate)}",
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    letterSpacing: -0.24,
                    color: ColorSchemes.gray,
                  ),
            ),
          )
        : const SizedBox.shrink();
  }

  Widget _buildImageLoadingSkeleton() => SkeletonLine(
    style: SkeletonLineStyle(
      width: 55,
      height: 55,
      borderRadius: BorderRadius.circular(8),
    ),
  );
}
