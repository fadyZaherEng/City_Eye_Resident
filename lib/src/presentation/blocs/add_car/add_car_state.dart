part of 'add_car_bloc.dart';

abstract class AddCarState extends Equatable {
  const AddCarState();

  @override
  List<Object?> get props => [identityHashCode(this)];
}

class AddCarInitial extends AddCarState {}

class ShowLoadingState extends AddCarState {}

class HideLoadingState extends AddCarState {}

class InitializeAddCarState extends AddCarState {
  final Car? car;

  const InitializeAddCarState({
    required this.car,
  });
}

class SelectColorState extends AddCarState {
  final LookupFile? selectedCarColor;

  const SelectColorState({
    required this.selectedCarColor,
  });
}

class SelectTypeState extends AddCarState {
  final List<LookupFile> types;
  final LookupFile selectedType;

  const SelectTypeState({
    required this.types,
    required this.selectedType,
  });
}

class UnSelectTypeState extends AddCarState {
  final List<LookupFile> types;
  final LookupFile? selectedType;

  const UnSelectTypeState({
    required this.types,
    required this.selectedType,
  });
}

class SelectModelState extends AddCarState {
  final LookupFile? selectedModel;

  const SelectModelState({
    required this.selectedModel,
  });
}

class ColorValidState extends AddCarState {}

class ColorInvalidState extends AddCarState {
  final String message;

  const ColorInvalidState({
    required this.message,
  });
}

class TypeValidState extends AddCarState {}

class TypeInvalidState extends AddCarState {
  final String message;

  const TypeInvalidState({
    required this.message,
  });
}

class ModelValidState extends AddCarState {}

class ModelInvalidState extends AddCarState {
  final String message;

  const ModelInvalidState({
    required this.message,
  });
}

class PlateNumberValidState extends AddCarState {}

class PlateNumberInvalidState extends AddCarState {
  final String message;

  const PlateNumberInvalidState({
    required this.message,
  });
}

class ValidCarFormState extends AddCarState {
  final Car car;

  const ValidCarFormState({
    required this.car,
  });
}

class SaveCarSuccessState extends AddCarState {
  final String message;
  final List<Car> cars;

  const SaveCarSuccessState({
    required this.message,
    required this.cars,
  });
}

class SaveCarErrorState extends AddCarState {
  final String errorMessage;

  const SaveCarErrorState({
    required this.errorMessage,
  });
}

class UpdateCarSuccessState extends AddCarState {
  final String message;
  final List<Car> cars;

  const UpdateCarSuccessState({
    required this.message,
    required this.cars,
  });
}

class UpdateCarErrorState extends AddCarState {
  final String errorMessage;

  const UpdateCarErrorState({
    required this.errorMessage,
  });
}
