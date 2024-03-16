import 'dart:async';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/service_details/request/service_details_cart_request.dart';
import 'package:city_eye/src/domain/entities/home/home_service.dart';
import 'package:city_eye/src/domain/entities/service_details/service_details_cart.dart';
import 'package:city_eye/src/domain/entities/service_details/submit_service_details_cart.dart';
import 'package:city_eye/src/domain/entities/settings/compound_configuration.dart';
import 'package:city_eye/src/domain/entities/settings/page_field.dart';
import 'package:city_eye/src/domain/usecase/add_service_details_use_case.dart';
import 'package:city_eye/src/domain/usecase/change_service_state_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_local_compound_configuration_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_total_price_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_user_unit_use_case.dart';
import 'package:city_eye/src/domain/usecase/is_there_items_in_cart_use_case.dart';
import 'package:city_eye/src/domain/usecase/minus_service_details_use_case.dart';
import 'package:city_eye/src/domain/usecase/service_details_cart_use_case.dart';
import 'package:city_eye/src/domain/usecase/submit_service_details_cart_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'service_details_cart_event.dart';

part 'service_details_cart_state.dart';

class ServiceDetailsCartBloc
    extends Bloc<ServiceDetailsCartEvent, ServiceDetailsCartState> {
  final ChangeServiceStateUseCase _changeServiceStateUseCase;
  final AddServiceDetailsUseCase _addServiceDetailsUseCase;
  final MinusServiceDetailsUseCase _minusServiceDetailsUseCase;
  final GetTotalPriceUseCase _getTotalPriceUseCase;
  final IsThereItemsInCartUseCase _isThereItemsInCartUseCase;
  List<ServiceDetailsCart> _servicesDetailsCart = [];
  final ServiceDetailsCartUseCase _serviceDetailsCartUseCase;
  final SubmitServiceDetailsCartUseCase _submitServiceDetailsCartUseCase;
  final GetLocalCompoundConfigurationUseCase
      _getLocalCompoundConfigurationUseCase;

  ServiceDetailsCartBloc(
    this._changeServiceStateUseCase,
    this._addServiceDetailsUseCase,
    this._minusServiceDetailsUseCase,
    this._getTotalPriceUseCase,
    this._isThereItemsInCartUseCase,
    this._serviceDetailsCartUseCase,
    this._submitServiceDetailsCartUseCase,
    this._getLocalCompoundConfigurationUseCase,
  ) : super(ServiceDetailsCartInitial()) {
    on<GetServiceDetailsCartEvent>(_onGetServiceDetailsCartEvent);
    on<ChangeServiceStateEvent>(_onChangeServiceStateEvent);
    on<AddServiceCountEvent>(_onAddServiceCountEvent);
    on<MinusServiceCountEvent>(_onMinusServiceCountEvent);
    on<GetTotalPriceEvent>(_onGetTotalPriceEvent);
    on<CheckIsThereItemInCartEvent>(_onCheckIsThereItemInCartEvent);
    on<NavigateBackEvent>(_onNavigateBackEvent);
    on<ContinueServiceDetailsCartEvent>(_onContinueServiceDetailsCartEvent);
    on<ResetServicesDetailsCart>(_onResetServicesDetailsCart);
    on<ResetServiceDetailsCartEvent>(_onResetServiceDetailsCartEvent);
    on<OpenDynamicQuestionBottomSheetEvent>(
        _onOpenDynamicQuestionBottomSheetEvent);
  }

  FutureOr<void> _onGetServiceDetailsCartEvent(GetServiceDetailsCartEvent event,
      Emitter<ServiceDetailsCartState> emit) async {
    emit(ShowSkeletonState());
    final servicesDetailsCartState = await _serviceDetailsCartUseCase(
      ServiceDetailsCartRequest(
        serviceCategoryId: event.serviceId,
      ),
    );

    if (servicesDetailsCartState is DataSuccess<List<ServiceDetailsCart>>) {
      _servicesDetailsCart = servicesDetailsCartState.data ?? [];
      emit(
        GetServiceDetailsCartSuccessState(
          servicesDetailsCart: servicesDetailsCartState.data ?? [],
          compoundConfiguration: _getLocalCompoundConfigurationUseCase(),
        ),
      );
    } else if (servicesDetailsCartState is DataFailed) {
      emit(GetServiceDetailsCartErrorState(
          errorMessage: servicesDetailsCartState.message ?? ""));
    }
  }

  FutureOr<void> _onNavigateBackEvent(
      NavigateBackEvent event, Emitter<ServiceDetailsCartState> emit) {
    emit(NavigateBackState());
  }

  FutureOr<void> _onChangeServiceStateEvent(
      ChangeServiceStateEvent event, Emitter<ServiceDetailsCartState> emit) {
    if (event.selectedServiceDetailsCart.servicePackageQuestions.isNotEmpty) {
      for (int i = 0;
          i < event.selectedServiceDetailsCart.servicePackageQuestions.length;
          i++) {
        if (event.selectedServiceDetailsCart.isSelected == false) {
          event.selectedServiceDetailsCart.servicePackageQuestions[i] = event
              .selectedServiceDetailsCart.servicePackageQuestions[i]
              .copyWith(value: null);

          emit(
            OpenDynamicBottomSheetState(
              questions:
                  event.selectedServiceDetailsCart.servicePackageQuestions,
              serviceDetailsCart: event.selectedServiceDetailsCart,
            ),
          );
        } else {
          emit(
            ChangeServiceState(
              servicesDetailsCart: _changeServiceStateUseCase(
                _servicesDetailsCart,
                event.selectedServiceDetailsCart,
              ),
            ),
          );
        }
      }
    } else {
      emit(
        ChangeServiceState(
          servicesDetailsCart: _changeServiceStateUseCase(
            _servicesDetailsCart,
            event.selectedServiceDetailsCart,
          ),
        ),
      );
    }
  }

  FutureOr<void> _onAddServiceCountEvent(
      AddServiceCountEvent event, Emitter<ServiceDetailsCartState> emit) {
    if (event.selectedServiceDetailsCart.quantity + 1 >
        event.selectedServiceDetailsCart.maxCount) {
      emit(
        AddServiceCountErrorState(
            errorMessage: S.current.youHaveReachedTheMaximumLimitOfYourPackage),
      );
    } else {
      emit(AddServiceCountState(
          servicesDetailsCart: _addServiceDetailsUseCase(
        _servicesDetailsCart,
        event.selectedServiceDetailsCart,
      )));
    }
  }

  FutureOr<void> _onMinusServiceCountEvent(
      MinusServiceCountEvent event, Emitter<ServiceDetailsCartState> emit) {
    emit(MinusServiceCountState(
        servicesDetailsCart: _minusServiceDetailsUseCase(
      _servicesDetailsCart,
      event.selectedServiceDetailsCart,
    )));
  }

  FutureOr<void> _onGetTotalPriceEvent(
      GetTotalPriceEvent event, Emitter<ServiceDetailsCartState> emit) {
    emit(
      GetTotalPriceState(
          totalPrice: _getTotalPriceUseCase(_servicesDetailsCart)),
    );
  }

  FutureOr<void> _onCheckIsThereItemInCartEvent(
      CheckIsThereItemInCartEvent event,
      Emitter<ServiceDetailsCartState> emit) {
    bool isThereItemInCart = _isThereItemsInCartUseCase(event.totalPrice);
    if (isThereItemInCart) {
      emit(ShowAreYouSureDialogState());
    } else {
      emit(NavigateBackState());
    }
  }

  Future<void> _onContinueServiceDetailsCartEvent(
      ContinueServiceDetailsCartEvent event,
      Emitter<ServiceDetailsCartState> emit) async {
    emit(LoadingContinueServiceDetailsCart());
    final selectedServiceDetailsCart = event.servicesDetailsCart
        .where((service) => service.isSelected == true)
        .toList();
    if (selectedServiceDetailsCart.isNotEmpty) {
      emit(NavigateToCartScreenState(
        servicesDetailsCart: selectedServiceDetailsCart,
        serviceDetails: event.serviceDetails,
      ));
    } else {
      emit(
        ErrorContinueServiceDetailsCart(
          errorMessage: S.current.youMustChoosePackageBeforeProceedingFurther,
        ),
      );
    }
  }

  FutureOr<void> _onResetServicesDetailsCart(
      ResetServicesDetailsCart event, Emitter<ServiceDetailsCartState> emit) {
    emit(ResetServicesDetailsCartState());
  }

  FutureOr<void> _onResetServiceDetailsCartEvent(
      ResetServiceDetailsCartEvent event,
      Emitter<ServiceDetailsCartState> emit) {
    emit(ResetServiceDetailsCartState());
  }

  FutureOr<void> _onOpenDynamicQuestionBottomSheetEvent(
      OpenDynamicQuestionBottomSheetEvent event,
      Emitter<ServiceDetailsCartState> emit) {
    if (event.questions.isNotEmpty) {
      emit(OpenDynamicBottomSheetState(
          questions: event.questions,
          serviceDetailsCart: event.serviceDetailsCart,
          isEdit: true));
    }
  }
}
