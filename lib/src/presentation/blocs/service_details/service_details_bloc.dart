import 'dart:async';

import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/domain/entities/home/home_service.dart';
import 'package:city_eye/src/domain/entities/service_details/service_details.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

part 'service_details_event.dart';

part 'service_details_state.dart';

class ServiceDetailsBloc
    extends Bloc<ServiceDetailsEvent, ServiceDetailsState> {
  final List<ServiceDetails> _serviceDetails = [
    ServiceDetails(
      id: 1,
      title: 'Hourly cleaning',
      image: ImagePaths.hourlyClean,
    ),
    ServiceDetails(
        id: 2,
        title: 'Monthly cleaning packages',
        image: ImagePaths.monthlyCleaning),
    ServiceDetails(
      id: 3,
      title: 'Deep cleaning',
      image: ImagePaths.deapClean,
    ),
    ServiceDetails(
      id: 4,
      title: 'Carpet cleaning',
      image: ImagePaths.carPetClean,
    ),
  ];

  ServiceDetailsBloc() : super(ServiceDetailsInitialState()) {
    on<GetServiceDetailsEvent>(_onGetServiceDetailsEvent);
    on<NavigateToServiceScreenEvent>(_onGNavigateToServiceEvent);
  }

  FutureOr<void> _onGetServiceDetailsEvent(
      GetServiceDetailsEvent event, Emitter<ServiceDetailsState> emit) async {
    emit(GetServiceDetailsLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    emit(GetServiceDetailsSuccessState(
      serviceDetails: _serviceDetails,
    ));
  }

  FutureOr<void> _onGNavigateToServiceEvent(
      NavigateToServiceScreenEvent event, Emitter<ServiceDetailsState> emit) {
    emit(NavigateToServiceScreenState(
      parentServiceName: event.parentServiceName,
      homeService: event.homeService,
    ));
  }
}
