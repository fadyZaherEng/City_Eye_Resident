import 'package:city_eye/flavors.dart';
import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/base/widget/base_stateful_widget.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/extensions/color_extension.dart';
import 'package:city_eye/src/core/utils/show_massage_dialog_widget.dart';
import 'package:city_eye/src/core/utils/show_snack_bar.dart';
import 'package:city_eye/src/domain/entities/profile/car.dart';
import 'package:city_eye/src/domain/entities/profile/car_configuration.dart';
import 'package:city_eye/src/domain/entities/profile/type_model.dart';
import 'package:city_eye/src/domain/entities/settings/lookup_file.dart';
import 'package:city_eye/src/presentation/blocs/add_car/add_car_bloc.dart';
import 'package:city_eye/src/presentation/widgets/custom_button_border_widget.dart';
import 'package:city_eye/src/presentation/widgets/custom_button_border_with_close_icon_widget.dart';
import 'package:city_eye/src/presentation/widgets/custom_button_widget.dart';
import 'package:city_eye/src/presentation/widgets/custom_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCarWidget extends BaseStatefulWidget {
  final CarConfiguration carConfiguration;
  final Car? car;
  final Function(List<Car>) onTapAdd;
  final Function(List<Car>) onTapUpdate;

  const AddCarWidget({
    Key? key,
    required this.carConfiguration,
    required this.onTapAdd,
    required this.onTapUpdate,
    this.car,
  }) : super(key: key);

  @override
  BaseState<BaseStatefulWidget> baseCreateState() => _AddCarWidgetState();
}

class _AddCarWidgetState extends BaseState<AddCarWidget> {
  AddCarBloc get _bloc => BlocProvider.of<AddCarBloc>(context);

  TextEditingController _plateNumberController = TextEditingController();

  LookupFile? _selectedColor;
  LookupFile? _selectedType;
  List<LookupFile> _types = [];
  LookupFile? _selectedModel;
  String _colorErrorMessage = "";
  String _typeErrorMessage = "";
  String _modelErrorMessage = "";
  String? _plateNumberErrorMessage;

  @override
  void initState() {
    super.initState();
    _initializeEvent();
  }

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<AddCarBloc, AddCarState>(
      listener: (context, state) {
        if (state is ShowLoadingState) {
          showLoading();
        } else if (state is HideLoadingState) {
          hideLoading();
        } else if (state is InitializeAddCarState) {
          _initialize(state.car);
        } else if (state is SelectColorState) {
          _selectedColor = state.selectedCarColor;
          _validateColorEvent(_selectedColor);
        } else if (state is SelectTypeState) {
          _selectedType = state.selectedType;
          _types = state.types;
          _validateTypeEvent(_selectedType);
        } else if (state is UnSelectTypeState) {
          _selectedType = state.selectedType;
          _types = state.types;
          _validateTypeEvent(_selectedType);
        } else if (state is SelectModelState) {
          _selectedModel = state.selectedModel;
          _validateModelEvent(_selectedModel);
        } else if (state is ColorValidState) {
          _colorErrorMessage = "";
        } else if (state is ColorInvalidState) {
          _colorErrorMessage = S.of(context).thisFieldIsRequired;
        } else if (state is TypeValidState) {
          _typeErrorMessage = "";
        } else if (state is TypeInvalidState) {
          _typeErrorMessage = S.of(context).thisFieldIsRequired;
        } else if (state is ModelValidState) {
          _modelErrorMessage = "";
        } else if (state is ModelInvalidState) {
          _modelErrorMessage = S.of(context).thisFieldIsRequired;
        } else if (state is PlateNumberValidState) {
          _plateNumberErrorMessage = null;
        } else if (state is PlateNumberInvalidState) {
          _plateNumberErrorMessage = S.of(context).thisFieldIsRequired;
        } else if (state is ValidCarFormState) {
          _saveCarEvent(state.car);
        } else if (state is SaveCarSuccessState) {
          showSnackBar(
            context: context,
            message: state.message,
            color: ColorSchemes.snackBarSuccess,
            icon: ImagePaths.success,
          );
          widget.onTapAdd(state.cars);
        } else if (state is SaveCarErrorState) {
          showSnackBar(
            context: context,
            message: state.errorMessage,
            color: ColorSchemes.snackBarError,
            icon: ImagePaths.error,
          );
        } else if (state is UpdateCarSuccessState) {
          showSnackBar(
            context: context,
            message: state.message,
            color: ColorSchemes.snackBarSuccess,
            icon: ImagePaths.success,
          );
          widget.onTapUpdate(state.cars);
        } else if (state is UpdateCarErrorState) {
          showSnackBar(
            context: context,
            message: state.errorMessage,
            color: ColorSchemes.snackBarError,
            icon: ImagePaths.error,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).color,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: ColorSchemes.gray,
                        letterSpacing: -0.13,
                      ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 32,
                  child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 8),
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.carConfiguration.colors.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          _selectColorEvent(
                              widget.carConfiguration.colors[index]);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: _selectedColor?.id ==
                                        widget.carConfiguration.colors[index].id
                                    ? ColorSchemes.primary
                                    : Colors.transparent,
                                width: 1,
                              )),
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(0, 4),
                                  blurRadius: 36,
                                  spreadRadius: 0,
                                  color: ColorSchemes.gray,
                                ),
                              ],
                              color: widget.carConfiguration.colors[index].code
                                  .toColor(),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                _buildErrorWidget(_colorErrorMessage),
                const SizedBox(height: 24),
                Text(
                  S.of(context).type,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: ColorSchemes.gray,
                        letterSpacing: -0.13,
                      ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 35,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _types.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsetsDirectional.only(
                            end: 10,
                          ),
                          child: CustomButtonBorderWithCloseIconWidget(
                            isCarType: true,
                            isSelected: _selectedType?.id == _types[index].id,
                            onTap: () {
                              _bloc.add(SelectTypeEvent(
                                  types: widget.carConfiguration.types,
                                  type: _types[index]));
                            },
                            buttonTitle: _types[index].name,
                            onTapClose: () {
                              _bloc.add(UnSelectTypeEvent(
                                  types: widget.carConfiguration.types,
                                  type: _types[index]));
                            },
                            isAllItems: false,
                          ),
                        );
                      }),
                ),
                _buildErrorWidget(_typeErrorMessage),
                const SizedBox(height: 24),
                Text(
                  S.of(context).model,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: ColorSchemes.gray,
                        letterSpacing: -0.13,
                      ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 35,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.carConfiguration.models.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsetsDirectional.only(
                            end: 10,
                          ),
                          child: CustomButtonBorderWidget(
                            onTap: () {
                              _selectModelEvent(
                                widget.carConfiguration.models[index],
                              );
                            },
                            buttonTitle:
                                widget.carConfiguration.models[index].name ??
                                    '',
                            isSelected: _selectedModel?.id ==
                                widget.carConfiguration.models[index].id,
                          ),
                        );
                      }),
                ),
                _buildErrorWidget(_modelErrorMessage),
                const SizedBox(height: 24),
                CustomTextFieldWidget(
                  controller: _plateNumberController,
                  labelTitle: S.of(context).plateNumber,
                  textInputType: TextInputType.text,
                  onChange: (value) {
                    //todo
                    _validatePlateNumberEvent(value);
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r' \s'),
                        replacementString: " "),
                  ],
                  errorMessage: _plateNumberErrorMessage,
                ),
                const SizedBox(height: 32),
                CustomButtonWidget(
                  onTap: () {
                    _validateCarFormEvent(
                      widget.car?.id,
                      _selectedColor,
                      _selectedType,
                      _selectedModel,
                      _plateNumberController.text,
                    );
                  },
                  width: double.infinity,
                  text: widget.car == null
                      ? S.of(context).save
                      : S.of(context).update,
                  backgroundColor: F.isNiceTouch
                      ? ColorSchemes.ghadeerDarkBlue
                      : ColorSchemes.primary,
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }

  void _initializeEvent() {
    _bloc.add(InitializeAddCarEvent(car: widget.car));
  }

  void _validateColorEvent(LookupFile? color) {
    return _bloc.add(
      ValidateColorEvent(color: color),
    );
  }

  void _validateTypeEvent(LookupFile? type) {
    return _bloc.add(
      ValidateTypeEvent(type: type),
    );
  }

  void _validateModelEvent(LookupFile? model) {
    return _bloc.add(
      ValidateModelEvent(model: model),
    );
  }

  void _validatePlateNumberEvent(String value) {
    return _bloc.add(
      ValidatePlateNumberEvent(plateNumber: value),
    );
  }

  void _selectColorEvent(LookupFile color) {
    _bloc.add(
      SelectColorEvent(
        selectedColor: (_selectedColor?.id ?? -1) == color.id ? null : color,
      ),
    );
  }

  void _selectModelEvent(LookupFile model) {
    _bloc.add(
      SelectModelEvent(
        selectedModel: (_selectedModel?.id ?? -1) == model.id ? null : model,
      ),
    );
  }

  void _validateCarFormEvent(
    int? id,
    LookupFile? selectedColor,
    LookupFile? selectedType,
    LookupFile? selectedModel,
    String plateNumber,
  ) {
    return _bloc.add(ValidateCarFormEvent(
      id: id,
      color: selectedColor,
      type: selectedType,
      model: selectedModel,
      plateNumber: plateNumber,
    ));
  }

  void _saveCarEvent(Car car) {
    if (widget.car != null) {
      _bloc.add(
        UpdateCarEvent(car: car),
      );
    } else {
      _bloc.add(
        SaveCarEvent(car: car),
      );
    }
  }

  void _initialize(Car? car) {
    _selectedColor = car?.colorType.toLookupFile();
    _selectedType = car?.carType.toLookupFile();
    _selectedModel = car?.modelType.toLookupFile();
    _plateNumberController.text = car?.plateNumber ?? "";
    if (_selectedType == null) {
      for (int i = 0; i < widget.carConfiguration.types.length; i++) {
        if (widget.carConfiguration.types[i].parentId == 0) {
          _types.add(widget.carConfiguration.types[i]);
        }
      }
    } else {
      _types.add(_selectedType!);
      for (int i = 0; i < widget.carConfiguration.types.length; i++) {
        if (_selectedType?.id == widget.carConfiguration.types[i].parentId) {
          _types.add(widget.carConfiguration.types[i]);
        }
      }
    }
  }

  void _showMessageDialog(
    String message,
    String icon,
    Function() onTab,
  ) {
    showMassageDialogWidget(
      context: context,
      text: message,
      icon: icon,
      buttonText: S.of(context).ok,
      onTap: () {
        onTab();
      },
    );
  }

  Widget _buildErrorWidget(String errorMessage) {
    return Visibility(
      visible: errorMessage.isNotEmpty,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 8,
          ),
          Text(
            errorMessage,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: ColorSchemes.redError,
                ),
          ),
        ],
      ),
    );
  }
}
