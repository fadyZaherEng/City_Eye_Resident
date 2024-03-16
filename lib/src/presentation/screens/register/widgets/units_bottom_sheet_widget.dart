import 'package:city_eye/flavors.dart';
import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/base/widget/base_stateful_widget.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/show_massage_dialog_widget.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/register/request/compound_units_request.dart';
import 'package:city_eye/src/domain/entities/register/compound_unit.dart';
import 'package:city_eye/src/presentation/blocs/units/units_bloc.dart';
import 'package:city_eye/src/presentation/screens/register/skeleton/units_bottom_sheet_skeleton.dart';
import 'package:city_eye/src/presentation/widgets/custom_button_widget.dart';
import 'package:city_eye/src/presentation/widgets/custom_radio_button_widget.dart';
import 'package:city_eye/src/presentation/widgets/search_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UnitsBottomSheetWidget extends BaseStatefulWidget {
  final int compoundId;
  final int userTypeId;
  final CompoundUnit selectedUnit;
  final int userId;

  const UnitsBottomSheetWidget({
    Key? key,
    required this.compoundId,
    required this.userTypeId,
    required this.selectedUnit,
    required this.userId,
  }) : super(key: key);

  @override
  BaseState<UnitsBottomSheetWidget> baseCreateState() =>
      _UnitsBottomSheetWidgetState();
}

class _UnitsBottomSheetWidgetState extends BaseState<UnitsBottomSheetWidget> {
  UnitsBloc get _bloc => BlocProvider.of<UnitsBloc>(context);

  final TextEditingController _unitNumberSearchController =
      TextEditingController();
  String unitsNumberText = '';
  List<CompoundUnit> _units = [];
  List<CompoundUnit> _filteredUnits = [];
  CompoundUnit _selectedUnit = const CompoundUnit(id: -1, name: '', units: []);

  @override
  void initState() {
    super.initState();
    _bloc.add(GetUnitsEvent(
      request: CompoundUnitsRequest(
        compoundId: widget.compoundId,
        userTypeId: widget.userTypeId,
      ),
      userId: widget.userId,
    ));
  }

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<UnitsBloc, UnitsState>(
      listener: (context, state) {
        if (state is ShowLoadingState) {
          showLoading();
        } else if (state is HideLoadingState) {
          hideLoading();
        } else if (state is GetUnitsSuccessState) {
          _units = state.units;
          _filteredUnits = state.units;
          if (_units.isNotEmpty) {
            _bloc.add(SelectUnitEvent(unit: _units.first, units: _units));
          }
        } else if (state is GetUnitsErrorStateState) {
          _showMessageDialog(
            message: state.errorMessage,
            icon: ImagePaths.error,
          );
        } else if (state is SelectUnitState) {
          _selectedUnit = state.unit;
          _units = state.units;
          _bloc.add(UnitSearchEvent(
            value: _unitNumberSearchController.text.trim(),
            units: _units,
          ));
        } else if (state is OnTapNextState) {
          _units = state.units;
          _filteredUnits = state.units;
          _bloc.add(SelectUnitEvent(unit: _units.first, units: _units));
        } else if (state is OnTapBackState) {
          _units = state.units;
          _filteredUnits = state.units;
          _bloc.add(SelectUnitEvent(
              unit: _units[_units.indexWhere((element) => element.isSelected)],
              units: _units));
        } else if (state is NavigateBackState) {
          _bloc.unitsStack.clear();
          Navigator.pop(context);
        } else if (state is ApplyButtonPressedState) {
          _bloc.unitsStack.clear();
          Navigator.pop(context, {
            'selectedUnit': state.unit,
            'unitName': state.unitName,
          });
        } else if (state is UnitSearchState) {
          _filteredUnits = state.units;
        }
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            _bloc.unitsStack.clear();
            return true;
          },
          child: state is ShowSkeletonState
              ? const UnitsBottomSheetSkeleton()
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      SearchTextFieldWidget(
                        controller: _unitNumberSearchController,
                        onChange: (String value) {
                          _bloc.add(UnitSearchEvent(
                            value: value,
                            units: _units,
                          ));
                        },
                        searchText: S.of(context).search,
                        onClear: () {
                          _bloc.add(UnitSearchEvent(
                            value: '',
                            units: _units,
                          ));
                        },
                      ),
                      Expanded(
                        child: _filteredUnits.isEmpty
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    ImagePaths.emptyUnit,
                                    fit: BoxFit.scaleDown,
                                  ),
                                  const SizedBox(height: 15),
                                  Text(
                                    S
                                        .of(context)
                                        .weRegretToInformYouThatThereAreCurrentlyNo,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: Colors.black),
                                  ),
                                  const SizedBox(height: 30),
                                ],
                              )
                            : ListView.builder(
                                padding: const EdgeInsets.only(top: 16),
                                itemCount: _filteredUnits.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      _bloc.add(SelectUnitEvent(
                                          unit: _filteredUnits[index],
                                          units: _units));
                                    },
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                _filteredUnits[index].name,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                        color: _filteredUnits[
                                                                        index]
                                                                    .id ==
                                                                _selectedUnit.id
                                                            ? ColorSchemes
                                                                .primary
                                                            : ColorSchemes
                                                                .black),
                                              ),
                                            ),
                                            CustomRadioButtonWidget(
                                              isSelected:
                                                  _filteredUnits[index].id ==
                                                      _selectedUnit.id,
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 18),
                                          child: Container(
                                            width: double.infinity,
                                            height: 1,
                                            color: _filteredUnits[index].id ==
                                                    _selectedUnit.id
                                                ? ColorSchemes.primary
                                                : ColorSchemes.lightGray,
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }),
                      ),
                      if (_filteredUnits.isNotEmpty)
                        Row(
                          children: [
                            Expanded(
                                child: CustomButtonWidget(
                              onTap: () {
                                _bloc.add(OnTapBackEvent());
                              },
                              text: S.of(context).back,
                              backgroundColor: ColorSchemes.white,
                              borderColor: ColorSchemes.primary,
                              textColor: ColorSchemes.primary,
                            )),
                            const SizedBox(width: 16),
                            Expanded(
                                child: CustomButtonWidget(
                              onTap: () {
                                if (_selectedUnit.units.isEmpty) {
                                  _bloc.add(
                                    ApplyButtonPressedEvent(
                                        selectedUnit: _selectedUnit),
                                  );
                                } else {
                                  bool flag = false;
                                  for (int i = 0;
                                      i < _filteredUnits.length;
                                      i++) {
                                    if (_filteredUnits[i].id ==
                                        _selectedUnit.id) {
                                      flag = true;
                                    }
                                  }
                                  if (flag) {
                                    _unitNumberSearchController.clear();
                                    _bloc.add(OnTapNextEvent(
                                      unit: _selectedUnit,
                                      units: _units,
                                    ));
                                  }
                                }
                              },
                              text: _selectedUnit.units.isEmpty
                                  ? S.of(context).apply
                                  : S.of(context).next,
                              backgroundColor: F.isNiceTouch
                                  ? ColorSchemes.ghadeerDarkBlue
                                  : ColorSchemes.primary,
                            )),
                          ],
                        ),
                    ],
                  ),
                ),
        );
      },
    );
  }

  void _showMessageDialog({
    required String message,
    required String icon,
  }) {
    showMassageDialogWidget(
        context: context,
        text: message,
        icon: icon,
        buttonText: S.of(context).ok,
        onTap: () {
          Navigator.pop(context);
        });
  }
}
