import 'dart:async';

import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/domain/entities/staff/staff.dart';
import 'package:city_eye/src/domain/usecase/get_staff_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'staff_event.dart';

part 'staff_state.dart';

class StaffBloc extends Bloc<StaffEvent, StaffState> {
  final GetStaffUseCase _staffUseCase;
  final List<Staff> _stuff = [
    // Stuff(
    //     id: 1,
    //     isManager: true,
    //     name: "Hr Manager",
    //     date: "08:00 Am - 04:00 Pm",
    //     phoneNumber: "0096599659",
    //     image: "",
    //     position: "Manager"),
    // Stuff(
    //     id: 2,
    //     isManager: false,
    //     name: "Hr Manager",
    //     date: "08:00 Am - 04:00 Pm",
    //     phoneNumber: "0096599659",
    //     image:
    //         "https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg",
    //     position: "Security"),
    // Stuff(
    //     id: 3,
    //     isManager: false,
    //     name: "Hr Manager",
    //     date: "08:00 Am - 04:00 Pm",
    //     phoneNumber: "0096599659",
    //     image:
    //         "https://img.freepik.com/free-photo/portrait-handsome-man-with-dark-hairstyle-bristle-toothy-smile-dressed-white-sweatshirt-feels-very-glad-poses-indoor-pleased-european-guy-being-good-mood-smiles-positively-emotions-concept_273609-61405.jpg",
    //     position: "Security"),
    // Stuff(
    //     id: 4,
    //     isManager: false,
    //     name: "Hr Manager",
    //     date: "08:00 Am - 04:00 Pm",
    //     phoneNumber: "0096599659",
    //     image:
    //         "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fHww&w=1000&q=80",
    //     position: "Security"),
  ];

  StaffBloc(this._staffUseCase) : super(StaffInitialState()) {
    on<GetStaffEvent>(_onGetStuffEvent);
    on<OpenStuffPhoneNumberEvent>(_onOpenStuffPhoneNumberEvent);
    on<NavigationPopEvent>(_onNavigationPopEvent);
  }

  FutureOr<void> _onGetStuffEvent(
      GetStaffEvent event, Emitter<StaffState> emit) async {
    emit(GetStaffLoadingState());
    final DataState<List<Staff>> staffsState = await _staffUseCase();
    if (staffsState is DataSuccess<List<Staff>>) {
      emit(GetStaffSuccessState(
        staff: staffsState.data ?? [],
      ));
    } else if (staffsState is DataFailed) {
      emit(GetStaffErrorState(errorMessage: staffsState.message ?? ""));
    }
  }

  FutureOr<void> _onOpenStuffPhoneNumberEvent(
      OpenStuffPhoneNumberEvent event, Emitter<StaffState> emit) async {
    emit(OpenStaffPhoneNumberState(
      phoneNumber: event.phoneNumber,
    ));
  }

  FutureOr<void> _onNavigationPopEvent(
      NavigationPopEvent event, Emitter<StaffState> emit) {
    emit(NavigationPopState());
  }
}
