import 'dart:async';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/profile/request/user_unit_car_request.dart';
import 'package:city_eye/src/domain/entities/profile/car.dart';
import 'package:city_eye/src/domain/entities/profile/type_model.dart';
import 'package:city_eye/src/domain/entities/settings/lookup_file.dart';
import 'package:city_eye/src/domain/usecase/add_user_unit_car_use_case.dart';
import 'package:city_eye/src/domain/usecase/update_user_unit_car_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_car_event.dart';

part 'add_car_state.dart';

class AddCarBloc extends Bloc<AddCarEvent, AddCarState> {
  final AddUserUnitCarUseCase _addUserUnitCarUseCase;
  final UpdateUserUnitCarUseCase _updateUserUnitCarUseCase;

  AddCarBloc(this._addUserUnitCarUseCase, this._updateUserUnitCarUseCase)
      : super(AddCarInitial()) {
    on<InitializeAddCarEvent>(_onInitializeAddCarEvent);
    on<SelectColorEvent>(_onSelectCarColorEvent);
    on<SelectTypeEvent>(_onSelectTypeEvent);
    on<UnSelectTypeEvent>(_onUnSelectTypeEvent);
    on<SelectModelEvent>(_onSelectModelEvent);
    on<ValidateColorEvent>(_onValidateColorEvent);
    on<ValidateTypeEvent>(_onValidateTypeEvent);
    on<ValidateModelEvent>(_onValidateModelEvent);
    on<ValidatePlateNumberEvent>(_ValidatePlateNumberEvent);
    on<ValidateCarFormEvent>(_onValidateCarFormEvent);
    on<SaveCarEvent>(_onSaveCarEvent);
    on<UpdateCarEvent>(_onUpdateCarEvent);
  }

  FutureOr<void> _onInitializeAddCarEvent(
      InitializeAddCarEvent event, Emitter<AddCarState> emit) {
    emit(InitializeAddCarState(
      car: event.car,
    ));
  }

  FutureOr<void> _onSelectCarColorEvent(
      SelectColorEvent event, Emitter<AddCarState> emit) {
    emit(SelectColorState(
      selectedCarColor: event.selectedColor,
    ));
  }

  FutureOr<void> _onSelectModelEvent(
      SelectModelEvent event, Emitter<AddCarState> emit) {
    emit(SelectModelState(
      selectedModel: event.selectedModel,
    ));
  }

  FutureOr<void> _ValidatePlateNumberEvent(
      ValidatePlateNumberEvent event, Emitter<AddCarState> emit) async {
    if (event.plateNumber.isEmpty) {
      emit(PlateNumberInvalidState(
        message: S.current.thisFieldIsRequired,
      ));
    } else {
      emit(PlateNumberValidState());
    }
  }

  FutureOr<void> _onValidateColorEvent(
      ValidateColorEvent event, Emitter<AddCarState> emit) {
    if (event.color == null) {
      emit(ColorInvalidState(
        message: S.current.thisFieldIsRequired,
      ));
    } else {
      emit(ColorValidState());
    }
  }

  FutureOr<void> _onValidateTypeEvent(
      ValidateTypeEvent event, Emitter<AddCarState> emit) {
    if (event.type == null) {
      emit(TypeInvalidState(
        message: S.current.thisFieldIsRequired,
      ));
    } else {
      emit(TypeValidState());
    }
  }

  FutureOr<void> _onValidateModelEvent(
      ValidateModelEvent event, Emitter<AddCarState> emit) {
    if (event.model == null) {
      emit(ModelInvalidState(
        message: S.current.thisFieldIsRequired,
      ));
    } else {
      emit(ModelValidState());
    }
  }

  FutureOr<void> _onValidateCarFormEvent(
      ValidateCarFormEvent event, Emitter<AddCarState> emit) async {
    bool isValid = true;
    if (event.color == null) {
      emit(ColorInvalidState(message: S.current.thisFieldIsRequired));
      isValid = false;
    } else {
      emit(ColorValidState());
    }
    if (event.type == null) {
      emit(TypeInvalidState(message: S.current.thisFieldIsRequired));
      isValid = false;
    } else {
      emit(TypeValidState());
    }
    if (event.model == null) {
      emit(ModelInvalidState(message: S.current.thisFieldIsRequired));
      isValid = false;
    } else {
      emit(ModelValidState());
    }
    if (event.plateNumber.isEmpty) {
      emit(PlateNumberInvalidState(message: S.current.thisFieldIsRequired));
      isValid = false;
    } else {
      emit(PlateNumberValidState());
    }

    if (isValid) {
      final Car car = Car(
        colorType: event.color!.toTypeModel(),
        carType: event.type!.toTypeModel(),
        plateNumber: event.plateNumber,
        modelType: event.model!.toTypeModel(),
        id: event.id ?? 0,
        userUnitId: 6,
      );
      emit(
        ValidCarFormState(
          car: car,
        ),
      );
    }
  }

  FutureOr<void> _onSaveCarEvent(
      SaveCarEvent event, Emitter<AddCarState> emit) async {
    emit(ShowLoadingState());
    final car = event.car;
    final remoteRequest = UserUnitCarRequest(
      id: 0,
      carTypeId: car.carType.id,
      colorId: car.colorType.id,
      modelId: car.modelType.id,
      plateNumber: car.plateNumber,
    );
    final addNewCarState = await _addUserUnitCarUseCase(remoteRequest);
    if (kDebugMode) {
      print(remoteRequest.toString());
    }
    if (addNewCarState is DataSuccess<List<Car>>) {
      emit(SaveCarSuccessState(
          cars: addNewCarState.data ?? [],
          message:
              addNewCarState.message ?? "")); //S.current.carAddedSuccessfully
    } else if (addNewCarState is DataFailed) {
      emit(SaveCarErrorState(errorMessage: addNewCarState.message ?? ""));
    }

    emit(HideLoadingState());
  }

  FutureOr<void> _onUpdateCarEvent(
      UpdateCarEvent event, Emitter<AddCarState> emit) async {
    emit(ShowLoadingState());

    final car = event.car;
    final remoteRequest = UserUnitCarRequest(
      id: car.id,
      carTypeId: car.carType.id,
      colorId: car.colorType.id,
      modelId: car.modelType.id,
      plateNumber: car.plateNumber,
    );
    final updateCarState = await _updateUserUnitCarUseCase(remoteRequest);
    if (kDebugMode) {
      print("CAR ID =>>>> ${remoteRequest.id}");
      print(remoteRequest.toString());
    }
    if (updateCarState is DataSuccess<List<Car>>) {
      emit(UpdateCarSuccessState(
          cars: updateCarState.data ?? [],
          message:
              updateCarState.message ?? "")); //S.current.carAddedSuccessfully
    } else if (updateCarState is DataFailed) {
      emit(UpdateCarErrorState(errorMessage: updateCarState.message ?? ""));
    }
    emit(HideLoadingState());
  }

  FutureOr<void> _onSelectTypeEvent(
      SelectTypeEvent event, Emitter<AddCarState> emit) {
    List<LookupFile> types = [];
    types.add(event.type);
    for (int i = 0; i < event.types.length; i++) {
      if (event.type.id == event.types[i].parentId) {
        types.add(event.types[i]);
      }
    }

    emit(SelectTypeState(
      types: types,
      selectedType: event.type,
    ));
  }

  FutureOr<void> _onUnSelectTypeEvent(
      UnSelectTypeEvent event, Emitter<AddCarState> emit) {
    List<LookupFile> types = [];
    LookupFile? carType;
    for (int i = 0; i < event.types.length; i++) {
      if (event.type.parentId == event.types[i].id) {
        carType = event.types[i];
        types.add(event.types[i]);
      } else if (event.type.parentId == event.types[i].parentId) {
        types.add(event.types[i]);
      }
    }

    emit(UnSelectTypeState(
      types: types,
      selectedType: carType,
    ));
  }
}
