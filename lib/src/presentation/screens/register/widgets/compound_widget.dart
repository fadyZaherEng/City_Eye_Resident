import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/domain/entities/settings/lookup_file.dart';
import 'package:city_eye/src/presentation/widgets/custom_button_border_widget.dart';
import 'package:city_eye/src/domain/entities/register/register_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../widgets/custom_text_field_with_suffix_icon_widget.dart';

class CompoundWidget extends StatefulWidget {
  final TextEditingController compoundNameController;
  final TextEditingController unitNoController;
  final String? compoundNameErrorMessage;
  final String? unitNoErrorMessage;
  final VoidCallback onTapCompound;
  final VoidCallback onTapUnitNo;
  final void Function(int id) onSelectType;
  final List<LookupFile> userTypes;

  const CompoundWidget({
    Key? key,
    required this.compoundNameController,
    required this.unitNoController,
    required this.userTypes,
    required this.onTapCompound,
    required this.onTapUnitNo,
    required this.compoundNameErrorMessage,
    required this.unitNoErrorMessage,
    required this.onSelectType,
  }) : super(key: key);

  @override
  State<CompoundWidget> createState() => _CompoundWidgetState();
}

class _CompoundWidgetState extends State<CompoundWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).type,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        letterSpacing: -0.13,
                        color: ColorSchemes.black,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 35,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.userTypes.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsetsDirectional.only(
                        end: 10,
                      ),
                      child: CustomButtonBorderWidget(
                        onTap: () {
                          widget.onSelectType(
                            widget.userTypes[index].id,
                          );
                        },
                        buttonTitle: widget.userTypes[index].name,
                        isSelected: widget.userTypes[index].isSelected,
                      ),
                    );
                  }),
            ),
            const SizedBox(height: 32),
            CustomTextFieldWithSuffixIconWidget(
              isReadOnly: true,
              errorMessage: widget.compoundNameErrorMessage,
              controller: widget.compoundNameController,
              labelTitle: S.of(context).compoundName,
              onTap: widget.onTapCompound,
              suffixIcon: SvgPicture.asset(
                ImagePaths.arrowRight,
                fit: BoxFit.scaleDown,
                matchTextDirection: true,
              ),
            ),
            const SizedBox(height: 32),
            CustomTextFieldWithSuffixIconWidget(
              isReadOnly: true,
              errorMessage: widget.unitNoErrorMessage,
              controller: widget.unitNoController,
              labelTitle: S.of(context).unitNumber,
              onTap: widget.onTapUnitNo,
              suffixIcon: SvgPicture.asset(
                ImagePaths.arrowRight,
                fit: BoxFit.scaleDown,
                matchTextDirection: true,
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
