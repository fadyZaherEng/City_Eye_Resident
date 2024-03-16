import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/domain/entities/settings/page_field.dart';
import 'package:city_eye/src/presentation/screens/qr/widgets/multi_selection_item.dart';
import 'package:flutter/material.dart';

class MultiSelectionFieldWidget extends StatefulWidget {
  final PageField pageField;
  final Function(int) selectAnswer;
  final double verticalPadding;
  final double horizontalPadding;
  final bool showSeparator;
  final bool isClearSelection;

  const MultiSelectionFieldWidget({
    Key? key,
    required this.pageField,
    required this.selectAnswer,
    this.verticalPadding = 16,
    this.horizontalPadding = 16,
    this.showSeparator = true,
    this.isClearSelection = false,
  }) : super(key: key);

  @override
  State<MultiSelectionFieldWidget> createState() =>
      _MultiSelectionFieldWidgetState();
}

class _MultiSelectionFieldWidgetState extends State<MultiSelectionFieldWidget> {
  late PageField _pageField;

  @override
  void initState() {
    _pageField = widget.pageField;
    if (widget.isClearSelection) {
      for (var i = 0; i < _pageField.choices.length; i++) {
        _pageField.choices[i] = _pageField.choices[i].copyWith(
          isSelected: false,
        );
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      key: _pageField.key,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: widget.verticalPadding,
            horizontal: widget.horizontalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _pageField.label,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: ColorSchemes.black),
              ),
              const SizedBox(height: 16.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: _pageField.choices
                        .map((answer) => Row(
                              children: [
                                MultiSelectionItem(
                                  onTap: () {
                                    widget.selectAnswer(answer.id);
                                  },
                                  text: answer.value,
                                  isSelected: answer.isSelected,
                                ),
                                const SizedBox(
                                  width: 8.0,
                                ),
                              ],
                            ))
                        .toList()),
              ),
              const SizedBox(height: 8.0),
              Visibility(
                visible: _pageField.notAnswered && _pageField.isRequired,
                child: Text(
                  S.of(context).thisFieldIsRequired,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: ColorSchemes.redError,
                        letterSpacing: -.24,
                      ),
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: widget.showSeparator,
          child: const Divider(
            height: 1,
            color: ColorSchemes.gray,
          ),
        ),
      ],
    );
  }
}
