import 'package:city_eye/flavors.dart';
import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/base/widget/base_stateful_widget.dart';
import 'package:city_eye/src/domain/entities/profile/profile_unit.dart';
import 'package:city_eye/src/domain/entities/register/register_type.dart';
import 'package:city_eye/src/presentation/widgets/custom_button_border_widget.dart';
import 'package:city_eye/src/presentation/widgets/custom_button_widget.dart';
import 'package:city_eye/src/presentation/widgets/custom_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UnitWidget extends BaseStatefulWidget {
  final ProfileUnit unit;
  final GlobalKey gasNumberKey;

  // final GlobalKey telephoneKey;
  final Function(int) onSelectUserType;
  final Function(String) onGasNumberChanged;
  final Function(String) onTelephoneChanged;
  final Function(ProfileUnit) onSavePressed;
  final String? gasNumberErrorMessage;

  // final String? telephoneErrorMessage;
  final TextEditingController gasNumberController;
  final TextEditingController telephoneController;
  final TextEditingController compoundNameController;
  final TextEditingController unitNumberController;

  const UnitWidget({
    Key? key,
    required this.unit,
    required this.gasNumberKey,
    // required this.telephoneKey,
    required this.onSelectUserType,
    required this.onGasNumberChanged,
    required this.onTelephoneChanged,
    required this.onSavePressed,
    required this.gasNumberErrorMessage,
    // required this.telephoneErrorMessage,
    required this.gasNumberController,
    required this.telephoneController,
    required this.compoundNameController,
    required this.unitNumberController,
  }) : super(key: key);

  @override
  BaseState<BaseStatefulWidget> baseCreateState() {
    return _UnitWidgetState();
  }
}

class _UnitWidgetState extends BaseState<UnitWidget> {
  final List<RegisterType> _registerTypes = [
    RegisterType(id: 1, text: S.current.owner, isSelected: true),
    RegisterType(id: 2, text: S.current.tenant),
    RegisterType(id: 3, text: S.current.familyMember),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget baseBuild(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 24,
                ),
                Text(
                  S.of(context).type,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: ColorSchemes.black,
                      ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    CustomButtonBorderWidget(
                      onTap: () {
                        // widget.onSelectUserType(_registerTypes[index].id ?? -1);
                      },
                      buttonTitle: widget.unit.userType.name,
                      isSelected: true,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFieldWidget(
                  controller: widget.compoundNameController,
                  labelTitle: S.of(context).compoundName,
                  onChange: (value) {},
                  errorMessage: null,
                  isReadOnly: true,
                  textInputType: TextInputType.text,
                ),
                const SizedBox(
                  height: 32,
                ),
                CustomTextFieldWidget(
                  controller: widget.unitNumberController,
                  labelTitle: S.of(context).unitNo,
                  onChange: (value) {},
                  errorMessage: null,
                  isReadOnly: true,
                  textInputType: TextInputType.text,
                ),
                const SizedBox(
                  height: 32,
                ),
                CustomTextFieldWidget(
                  key: widget.gasNumberKey,
                  controller: widget.gasNumberController,
                  labelTitle: S.of(context).gasNo,
                  onChange: (value) {
                    widget.onGasNumberChanged(value);
                  },
                  errorMessage: widget.gasNumberErrorMessage,
                  textInputType: TextInputType.text,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s")),
                    FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                CustomTextFieldWidget(
                  // key: widget.telephoneKey,
                  controller: widget.telephoneController,
                  labelTitle: S.of(context).telephone,
                  onChange: (value) {
                    widget.onTelephoneChanged(value);
                  },
                  // errorMessage: widget.telephoneErrorMessage,
                  textInputType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
                const Expanded(
                    child: SizedBox(
                  height: 16,
                )),
                CustomButtonWidget(
                  onTap: () {
                    ProfileUnit unit = widget.unit.copyWith();
                    unit = unit.copyWith(
                      gasNumber: widget.gasNumberController.text,
                      telephone: widget.telephoneController.text,
                    );
                    widget.onSavePressed(unit);
                  },
                  width: double.infinity,
                  text: S.of(context).save,
                  backgroundColor: F.isNiceTouch
                      ? ColorSchemes.ghadeerDarkBlue
                      : ColorSchemes.primary,
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
