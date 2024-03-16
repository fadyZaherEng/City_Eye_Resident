import 'package:city_eye/flavors.dart';
import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/constants.dart';
import 'package:city_eye/src/domain/entities/settings/choice.dart';
import 'package:city_eye/src/domain/entities/settings/page_field.dart';
import 'package:city_eye/src/presentation/screens/authentication/sign_in/widget/remember_me_widget.dart';
import 'package:city_eye/src/presentation/widgets/custom_button_widget.dart';
import 'package:city_eye/src/presentation/widgets/custom_radio_button_widget.dart';
import 'package:city_eye/src/presentation/widgets/search_text_field_widget.dart';
import 'package:flutter/material.dart';

class SearchableBottomSheetWidget extends StatefulWidget {
  final PageField pageField;
  final Function(PageField, Choice)? onChoicesSelected;
  final Function(PageField, List<Choice>)? onSaveMultiChoice;
  final ScrollPhysics? scrollPhysics;
  final bool isMultiChoice;
  final bool updateAnswer;

  const SearchableBottomSheetWidget({
    Key? key,
    required this.pageField,
    required this.onChoicesSelected,
    required this.onSaveMultiChoice,
    required this.isMultiChoice,
    this.scrollPhysics,
    this.updateAnswer = true,
  }) : super(key: key);

  @override
  State<SearchableBottomSheetWidget> createState() =>
      _SearchableBottomSheetWidgetState();
}

class _SearchableBottomSheetWidgetState
    extends State<SearchableBottomSheetWidget> {
  TextEditingController controller = TextEditingController();
  List<Choice> _filteredChoices = [];

  List<Choice> multiSelectedChoice = [];

  @override
  void initState() {
    _filteredChoices = widget.pageField.choices.map((e) => e.deepClone()).toList();
    if (widget.isMultiChoice) {
      for (int i = 0; i < _filteredChoices.length; i++) {
        if (_filteredChoices[i].isSelected) {
          multiSelectedChoice.add(_filteredChoices[i]);
        }
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        SearchTextFieldWidget(
          controller: controller,
          onChange: (value) {
            _filteredChoices = widget.pageField.choices
                .where((element) =>
                    element.value.toLowerCase().contains(value.toLowerCase()))
                .toList();
            setState(() {});
          },
          searchText: S.of(context).searchWhatYouNeed,
          onClear: () {
            controller.clear();
            _filteredChoices = widget.pageField.choices;
            setState(() {});
          },
        ),
        const SizedBox(
          height: 16,
        ),
        widget.isMultiChoice ? _buildMultiChoice() : _buildSingleChoice(),
      ],
    );
  }

  Widget _buildSingleChoice() {
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          physics: widget.scrollPhysics,
          itemCount: _filteredChoices.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                InkWell(
                  onTap: () {
                    widget.onChoicesSelected!(
                        widget.pageField, _filteredChoices[index]);
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: Image.network(
                            _filteredChoices[index].value,
                            width: 24,
                            height: 24,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                ImagePaths.flagPlaceHolder,
                                fit: BoxFit.fill,
                                width: 24,
                                height: 24,
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          _filteredChoices[index].value,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontWeight: Constants.fontWeightRegular,
                                    letterSpacing: -0.24,
                                    color: _filteredChoices[index].isSelected
                                        ? ColorSchemes.primary
                                        : ColorSchemes.gray,
                                  ),
                        ),
                        const Expanded(child: SizedBox()),
                        CustomRadioButtonWidget(
                          isSelected: _filteredChoices[index].isSelected,
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: index != _filteredChoices.length - 1,
                  child: Container(
                    height: 0.6,
                    width: double.infinity,
                    color: ColorSchemes.border,
                  ),
                )
              ],
            );
          }),
    );
  }

  Widget _buildMultiChoice() {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                physics: widget.scrollPhysics,
                itemCount: _filteredChoices.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          _handleMultiSelection(index);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipOval(
                                child: Image.network(
                                  _filteredChoices[index].value,
                                  width: 24,
                                  height: 24,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      ImagePaths.flagPlaceHolder,
                                      fit: BoxFit.fill,
                                      width: 24,
                                      height: 24,
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Text(
                                _filteredChoices[index].value,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      fontWeight: Constants.fontWeightRegular,
                                      letterSpacing: -0.24,
                                      color: _filteredChoices[index].isSelected
                                          ? ColorSchemes.primary
                                          : ColorSchemes.gray,
                                    ),
                              ),
                              const Expanded(child: SizedBox()),
                              RememberMeWidget(
                                isHideText: true,
                                isCheckRememberMe: _filteredChoices[index].isSelected,
                                onTap: () {},
                                onChange: (bool value) {
                                  _handleMultiSelection(index);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: index != _filteredChoices.length - 1,
                        child: Container(
                          height: 0.6,
                          width: double.infinity,
                          color: ColorSchemes.border,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: CustomButtonWidget(
              width: double.infinity,
              text: S.of(context).save,
              onTap: () {
                Navigator.pop(context);
                widget.onSaveMultiChoice!(
                    widget.pageField, multiSelectedChoice);
              },
              backgroundColor: F.isNiceTouch
                  ? ColorSchemes.ghadeerDarkBlue
                  : ColorSchemes.primary,
            ),
          ),
        ],
      ),
    );
  }

  void _handleMultiSelection(int index) {
    if (_filteredChoices[index].isSelected) {
      multiSelectedChoice.remove(_filteredChoices[index]);
      _filteredChoices[index]  = _filteredChoices[index].copyWith(isSelected: false);
    } else {
      multiSelectedChoice.add(_filteredChoices[index]);
      _filteredChoices[index] = _filteredChoices[index].copyWith(isSelected: true);
    }
    setState(() {});
  }
}
