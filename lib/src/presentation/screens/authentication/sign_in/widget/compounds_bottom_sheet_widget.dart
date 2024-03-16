import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/domain/entities/sign_in/user_unit.dart';
import 'package:city_eye/src/presentation/screens/authentication/sign_in/widget/unit_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CompoundsBottomSheetWidget extends StatefulWidget {
  final List<UserUnit> userUnits;
  final Function(UserUnit) onTapItem;
  final Function() onTapAddAnotherUnit;

  const CompoundsBottomSheetWidget({
    Key? key,
    required this.userUnits,
    required this.onTapItem,
    required this.onTapAddAnotherUnit,
  }) : super(key: key);

  @override
  State<CompoundsBottomSheetWidget> createState() =>
      _CompoundsBottomSheetWidgetState();
}

class _CompoundsBottomSheetWidgetState
    extends State<CompoundsBottomSheetWidget> {
  late List<UserUnit> _userUnits;

  @override
  void initState() {
    super.initState();
    _userUnits = widget.userUnits;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: _userUnits.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index < _userUnits.length) {
                return UnitItem(
                  userUnit: _userUnits[index],
                  isLastItem: index == _userUnits.length - 1,
                  onTap: () {
                    if(_userUnits[index].isCompoundVerified ==false || _userUnits[index].isActive == false){
                      widget.onTapItem(_userUnits[index]);
                      return;
                    }
                    setState(() {
                      for (var i = 0; i < _userUnits.length; i++) {
                        if (i == index) {
                          _userUnits[i] = _userUnits[i].copyWith(
                            isSelected: true,
                          );
                        } else {
                          _userUnits[i] = _userUnits[i].copyWith(
                            isSelected: false,
                          );
                        }
                      }
                    });
                    widget.onTapItem(_userUnits[index]);
                  },
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: InkWell(
                    onTap: widget.onTapAddAnotherUnit,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          ImagePaths.addCircle,
                          fit: BoxFit.scaleDown,
                          color: ColorSchemes.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          S.of(context).addAnotherUnit,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                            color: ColorSchemes.primary,
                            letterSpacing: -0.24,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
