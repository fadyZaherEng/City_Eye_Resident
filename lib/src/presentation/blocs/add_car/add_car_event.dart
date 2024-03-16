part of 'add_car_bloc.dart';

abstract class AddCarEvent extends Equatable {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class InitializeAddCarEvent extends AddCarEvent {
  final Car? car;

  InitializeAddCarEvent({
    this.car,
  });
}

class SelectColorEvent extends AddCarEvent {
  final LookupFile? selectedColor;

  SelectColorEvent({
    required this.selectedColor,
  });
}

class SelectTypeEvent extends AddCarEvent {
  final List<LookupFile> types;
  final LookupFile type;

  SelectTypeEvent({
    required this.types,
    required this.type,
  });
}

class UnSelectTypeEvent extends AddCarEvent {
  final List<LookupFile> types;
  final LookupFile type;

  UnSelectTypeEvent({
    required this.types,
    required this.type,
  });
}

class SelectModelEvent extends AddCarEvent {
  final LookupFile? selectedModel;

  SelectModelEvent({
    required this.selectedModel,
  });
}

class ValidateColorEvent extends AddCarEvent {
  final LookupFile? color;

  ValidateColorEvent({
    required this.color,
  });
}

class ValidateTypeEvent extends AddCarEvent {
  final LookupFile? type;

  ValidateTypeEvent({
    required this.type,
  });
}

class ValidateModelEvent extends AddCarEvent {
  final LookupFile? model;

  ValidateModelEvent({
    required this.model,
  });
}

class ValidatePlateNumberEvent extends AddCarEvent {
  final String plateNumber;

  ValidatePlateNumberEvent({
    required this.plateNumber,
  });
}

class ValidateCarFormEvent extends AddCarEvent {
  final int? id;
  final LookupFile? color;
  final LookupFile? type;
  final LookupFile? model;
  final String plateNumber;

  ValidateCarFormEvent({
    required this.id,
    required this.color,
    required this.type,
    required this.model,
    required this.plateNumber,
  });
}

class SaveCarEvent extends AddCarEvent {
  final Car car;

  SaveCarEvent({
    required this.car,
  });
}

class UpdateCarEvent extends AddCarEvent {
  final Car car;

  UpdateCarEvent({
    required this.car,
  });
}
