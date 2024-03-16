import 'dart:async';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/qr/request/create_qr_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/qr/request/deactivate_qr_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/qr/request/qr_history_request.dart';
import 'package:city_eye/src/domain/entities/qr/create_qr_response.dart';
import 'package:city_eye/src/domain/entities/qr/day.dart';
import 'package:city_eye/src/domain/entities/qr/day_time.dart';
import 'package:city_eye/src/domain/entities/qr/guests_type.dart';
import 'package:city_eye/src/domain/entities/qr/qr_configuration.dart';
import 'package:city_eye/src/domain/entities/qr/qrs_type.dart';
import 'package:city_eye/src/domain/entities/qr_history/qr_history.dart';
import 'package:city_eye/src/domain/entities/settings/choice.dart';
import 'package:city_eye/src/domain/entities/settings/page_field.dart';
import 'package:city_eye/src/domain/usecase/create_qr_code_use_case.dart';
import 'package:city_eye/src/domain/usecase/dynamic_question_validation_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_user_unit_use_case.dart';
import 'package:city_eye/src/domain/usecase/qr/change_qr_activation_state_usecase.dart';
import 'package:city_eye/src/domain/usecase/qr/get_qr_configuration_usecase.dart';
import 'package:city_eye/src/domain/usecase/qr/search_qr_history_usecase.dart';
import 'package:city_eye/src/domain/usecase/qr/get_qr_history_usecase.dart';
import 'package:city_eye/src/presentation/screens/qr/qr_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'qr_configuration_event.dart';

part 'qr_configuration_state.dart';

class QrConfigurationBloc
    extends Bloc<QrConfigurationEvent, QrConfigurationState> {
  //Qr UseCases

  //Create QrUseCases
  QrConfiguration _qrConfiguration = const QrConfiguration();
  final CreateQrCodeUseCase _createQrCodeUseCase;
  final GetQrConfigurationUseCase _getQrConfigurationUseCase;
  final GetUserUnitUseCase _getUserUnitsUseCase;

  //History Qr UseCases
  List<QrHistory> _qrHistories = [];
  final GetQrHistoryUseCase _getQrHistoryUseCase;
  final SearchQrHistoryUseCase _searchQrHistoryUseCase;
  final ChangeQrActivationStatusUseCase _changeQrActivationStatusUseCase;

  //Qr Validation
  final DynamicQuestionValidationUseCase _dynamicQuestionValidationUseCase;

  QrConfigurationBloc(
    this._getQrConfigurationUseCase,
    this._getQrHistoryUseCase,
    this._searchQrHistoryUseCase,
    this._changeQrActivationStatusUseCase,
    this._createQrCodeUseCase,
    this._getUserUnitsUseCase,
    this._dynamicQuestionValidationUseCase,
  ) : super(QrConfigurationInitial()) {
    on<SwitchQrTabsEvent>(_onSwitchQrTabsEvent);
    on<NavigateBackEvent>(_onNavigateBackEvent);
    //Create Qr Events
    on<GetQrConfigurationEvent>(_onGetQrConfigurationEvent);
    on<SelectGuestTypeEvent>(_onSelectGuestTypeEvent);
    on<SelectQrTypeEvent>(_onSelectQrTypeEvent);
    on<SelectSingleSelectionAnswerEvent>(_onSelectSingleSelectionAnswerEvent);
    on<SelectMultiSelectionAnswerEvent>(_onSelectMultiSelectionAnswerEvent);
    on<AddAnswerToQuestionEvent>(_onAddAnswerToQuestionEvent);
    on<DeleteAnswerQuestionEvent>(_onDeleteAnswerQuestionEvent);
    on<SelectImageQuestionEvent>(_onSelectImageQuestionEvent);
    on<DeleteImageQuestionEvent>(_onDeleteImageQuestionEvent);
    on<ShowSearchableBottomSheetEvent>(_onShowQrSearchableBottomSheetEvent);
    on<UpdateSearchableSingleQuestionEvent>(
        _onUpdateSearchableSingleQuestionEvent);
    on<UpdateSearchableMultiQuestionEvent>(
        _onUpdateSearchableMultiQuestionEvent);
    on<OpenRulesBottomSheetEvent>(_onOpenRulesBottomSheetEvent);
    on<CreateQrEvent>(_onCreateQrEvent);
    on<OpenDatePickerEvent>(_onOpenDatePickerEvent);
    on<SelectDateEvent>(_onSelectDateEvent);
    on<DeleteDateEvent>(_onDeleteDateEvent);
    on<SelectSingleQRTimeEvent>(_onSelectSingleQRTimeEvent);
    on<SelectDayEvent>(_onSelectDayEvent);
    on<ValidateVisitorNameEvent>(_onValidateVisitorNameEvent);
    on<SelectMultipleQRTimeEvent>(_onSelectMultipleQRTimeEvent);

    //History Qr History Events
    on<SwitchHistoryTabsEvent>(_onSwitchHistoryTabsEvent);
    on<GetQrHistoryEvent>(_onGetQrHistoryEvent);
    on<QrHistorySearchEvent>(_onQrHistorySearchEvent);
    on<ChangeQrActivationStatusEvent>(_onChangeQrActivationStatusEvent);
  }

  /* ======================== Qr Methods ======================== */
  FutureOr<void> _onSwitchQrTabsEvent(
      SwitchQrTabsEvent event, Emitter<QrConfigurationState> emit) {
    emit(SwitchQrTabsState(index: event.index));
  }

  FutureOr<void> _onNavigateBackEvent(
      NavigateBackEvent event, Emitter<QrConfigurationState> emit) {
    emit(NavigateBackState());
  }

  /* ======================== Qr Methods ======================== */

  /* ======================== Create Qr Methods ======================== */

  FutureOr<void> _onGetQrConfigurationEvent(
      GetQrConfigurationEvent event, Emitter<QrConfigurationState> emit) async {
    emit(ShowCreateQrSkeleton());
    final DataState dataState = await _getQrConfigurationUseCase();
    _qrConfiguration = dataState.data ?? const QrConfiguration();
    for (int i = 0; i < _qrConfiguration.guestsTypes.length; i++) {
      for (int j = 0;
          j < _qrConfiguration.guestsTypes[i].questions.length;
          j++) {
        _qrConfiguration.guestsTypes[i].questions[j] =
            _qrConfiguration.guestsTypes[i].questions[j].copyWith(
          key: GlobalKey(),
        );
      }
    }
    if (dataState is DataSuccess) {
      emit(GetQrConfigurationSuccessState(qrConfiguration: _qrConfiguration));
    } else {
      emit(GetQrConfigurationErrorState(message: dataState.message ?? ""));
    }
    emit(HideCreateQrSkeleton());
  }

  FutureOr<void> _onSelectGuestTypeEvent(
      SelectGuestTypeEvent event, Emitter<QrConfigurationState> emit) {
    emit(SelectGuestTypeState(
      guestsType: event.guestsType.deepClone(),
    ));
  }

  FutureOr<void> _onSelectQrTypeEvent(
      SelectQrTypeEvent event, Emitter<QrConfigurationState> emit) {
    emit(SelectQrTypeState(
      qrsType: event.qrsType.deepClone(),
    ));
  }

  FutureOr<void> _onSelectSingleSelectionAnswerEvent(
      SelectSingleSelectionAnswerEvent event,
      Emitter<QrConfigurationState> emit) {
    for (int i = 0; i < event.questions.length; i++) {
      if (event.questions[i].id == event.question.id) {
        event.questions[i] = event.questions[i].copyWith(
          value: "",
          notAnswered: true,
        );
        for (int j = 0; j < event.questions[i].choices.length; j++) {
          if (event.questions[i].choices[j].id == event.answerId) {
            event.questions[i].choices[j] =
                event.questions[i].choices[j].copyWith(isSelected: true);
            event.questions[i] = event.questions[i].copyWith(
              value: "${event.questions[i].choices[j].id}",
              notAnswered: false,
            );
          } else {
            event.questions[i].choices[j] =
                event.questions[i].choices[j].copyWith(isSelected: false);
          }
        }
        break;
      }
    }
    emit(AnswerQuestionState(questions: event.questions));
  }

  FutureOr<void> _onSelectMultiSelectionAnswerEvent(
      SelectMultiSelectionAnswerEvent event,
      Emitter<QrConfigurationState> emit) {
    for (var i = 0; i < event.questions.length; i++) {
      if (event.questions[i].id == event.question.id) {
        for (var j = 0; j < event.questions[i].choices.length; j++) {
          if (event.questions[i].choices[j].id == event.answerId) {
            event.questions[i].choices[j].isSelected =
                !event.questions[i].choices[j].isSelected;
            event.questions[i] =
                event.questions[i].copyWith(notAnswered: false);
          }
        }
      }
    }
    for (var i = 0; i < event.questions.length; i++) {
      if (event.questions[i].id == event.question.id) {
        bool isAnswered = false;
        event.questions[i] = event.questions[i].copyWith(
          value: "",
        );
        for (var j = 0; j < event.questions[i].choices.length; j++) {
          if (event.questions[i].choices[j].isSelected) {
            event.questions[i] = event.questions[i].copyWith(
              notAnswered: false,
            );
            if (event.questions[i].value.isEmpty) {
              event.questions[i] = event.questions[i]
                  .copyWith(value: "${event.questions[i].choices[j].id}");
            } else {
              event.questions[i] = event.questions[i].copyWith(
                value:
                    "${event.questions[i].value},${event.questions[i].choices[j].id}",
              );
            }
            isAnswered = true;
          }
        }
        if (isAnswered) {
          event.questions[i] = event.questions[i].copyWith(
            notAnswered: false,
          );
        } else {
          event.questions[i] = event.questions[i].copyWith(
            notAnswered: true,
          );
        }
      }
    }
    emit(AnswerQuestionState(questions: event.questions));
  }

  FutureOr<void> _onAddAnswerToQuestionEvent(
      AddAnswerToQuestionEvent event, Emitter<QrConfigurationState> emit) {
    for (var i = 0; i < event.questions.length; i++) {
      if (event.questions[i].id == event.question.id) {
        event.questions[i] = event.questions[i].copyWith(
          value: event.answer,
          notAnswered: false,
        );

        if (event.questions[i].value.isNotEmpty) {
          Map<String,dynamic> validation = _dynamicQuestionValidationUseCase(
            validation: event.questions[i].validations,
            value: event.questions[i].value,
            questionCode: event.questions[i].code,
          );
          if (!validation["isValid"]) {
            event.questions[i] = event.questions[i].copyWith(
              isValid: false,
              validationMessage: validation["validationMessage"],
            );
          } else {
            event.questions[i] = event.questions[i].copyWith(
              isValid: true,
              validationMessage: "",
            );
          }
        } else {
          event.questions[i] = event.questions[i].copyWith(
            isValid: true,
          );
        }

        break;
      }
    }
    emit(AnswerQuestionState(questions: event.questions));
  }

  FutureOr<void> _onDeleteAnswerQuestionEvent(
      DeleteAnswerQuestionEvent event, Emitter<QrConfigurationState> emit) {
    for (var i = 0; i < event.questions.length; i++) {
      if (event.questions[i].id == event.question.id) {
        event.questions[i] = event.questions[i].copyWith(
          value: "",
          notAnswered: true,
        );
      }
    }

    emit(AnswerQuestionState(questions: event.questions));
  }

  FutureOr<void> _onSelectImageQuestionEvent(
      SelectImageQuestionEvent event, Emitter<QrConfigurationState> emit) {
    emit(SelectImageQuestionState(
      questions: event.questions,
      question: event.question,
    ));
  }

  FutureOr<void> _onDeleteImageQuestionEvent(
      DeleteImageQuestionEvent event, Emitter<QrConfigurationState> emit) {
    emit(DeleteImageQuestionState(
      questions: event.questions,
      question: event.question,
    ));
  }

/* ======================== Create Qr Methods ======================== */

/* ======================== Qr History Methods ======================== */

  FutureOr<void> _onGetQrHistoryEvent(
      GetQrHistoryEvent event, Emitter<QrConfigurationState> emit) async {
    emit(ShowHistorySkeletonState());
    final dataState = await _getQrHistoryUseCase(QrHistoryRequest(
      isStatus: event.qrType == 1 ? true : false,
    ));
    if (dataState is DataSuccess) {
      _qrHistories = dataState.data ?? [];
      emit(GetQrHistorySuccessState(history: _qrHistories));
    } else {
      emit(GetQrHistoryErrorState(message: dataState.message ?? ""));
    }
    emit(HideHistorySkeletonState());
  }

  FutureOr<void> _onSwitchHistoryTabsEvent(
      SwitchHistoryTabsEvent event, Emitter<QrConfigurationState> emit) {
    emit(SwitchHistoryTabsState(historyQrType: event.historyQrType));
  }

  FutureOr<void> _onQrHistorySearchEvent(
      QrHistorySearchEvent event, Emitter<QrConfigurationState> emit) {
    emit(QrHistorySearchState(
      history: _searchQrHistoryUseCase(_qrHistories, event.value),
    ));
  }

  FutureOr<void> _onChangeQrActivationStatusEvent(
      ChangeQrActivationStatusEvent event,
      Emitter<QrConfigurationState> emit) async {
    emit(ShowLoadingState());
    final DataState dataState =
        await _changeQrActivationStatusUseCase(DeactivateQrRequest(
      id: event.qrHistory.id,
      isEnabled: !event.qrHistory.isEnabled,
    ));
    if (dataState is DataSuccess) {
      //Todo Extract This Method to useCase
      for (int i = 0; i < event.qrHistories.length; i++) {
        if (event.qrHistories[i].id == event.qrHistory.id) {
          event.qrHistories[i] = dataState.data;
          break;
        }
      }
      for (int i = 0; i < _qrHistories.length; i++) {
        if (_qrHistories[i].id == event.qrHistory.id) {
          _qrHistories[i] = dataState.data;
        }
      }
      emit(GetQrHistorySuccessState(history: event.qrHistories));
    } else {
      emit(GetQrHistorySuccessState(history: event.qrHistories));
    }
    emit(HideLoadingState());
  }

/* ======================== Qr History Methods ======================== */

  FutureOr<void> _onShowQrSearchableBottomSheetEvent(
      ShowSearchableBottomSheetEvent event,
      Emitter<QrConfigurationState> emit) {
    emit(ShowSearchableBottomSheetState(
      questions: event.questions,
      question: event.question,
      isMultiChoice: event.isMultiChoice,
    ));
  }

  FutureOr<void> _onUpdateSearchableSingleQuestionEvent(
      UpdateSearchableSingleQuestionEvent event,
      Emitter<QrConfigurationState> emit) {
    for (var i = 0; i < event.questions.length; i++) {
      if (event.questions[i].id == event.question.id) {
        event.questions[i] = event.questions[i].copyWith(
          value: event.answer.id.toString(),
          notAnswered: false,
        );
        for (var j = 0; j < event.questions[i].choices.length; j++) {
          if (event.questions[i].choices[j].id == event.answer.id) {
            event.questions[i].choices[j] =
                event.questions[i].choices[j].copyWith(
              isSelected: true,
            );
            event.questions[i] =
                event.questions[i].copyWith(notAnswered: false);
          } else {
            event.questions[i].choices[j] =
                event.questions[i].choices[j].copyWith(
              isSelected: false,
            );
          }
        }

        if (event.questions[i].value.isNotEmpty) {
          event.questions[i] = event.questions[i].copyWith(
            notAnswered: false,
          );
        } else {
          event.questions[i] =
              event.questions[i].copyWith(value: "", notAnswered: false);
        }
      }
    }
    emit(AnswerQuestionState(questions: event.questions));
  }

  FutureOr<void> _onUpdateSearchableMultiQuestionEvent(
      UpdateSearchableMultiQuestionEvent event,
      Emitter<QrConfigurationState> emit) {
    bool isAnswered = false;
    for (var i = 0; i < event.questions.length; i++) {
      if (event.questions[i].id == event.question.id) {
        event.questions[i] = event.questions[i].copyWith(
          value: "",
        );
        for (var j = 0; j < event.questions[i].choices.length; j++) {
          event.questions[i].choices[j] =
              event.questions[i].choices[j].copyWith(
            isSelected: false,
          );
        }
        for (var j = 0; j < event.questions[i].choices.length; j++) {
          for (var k = 0; k < event.answer.length; k++) {
            if (event.questions[i].choices[j].id == event.answer[k].id) {
              event.questions[i].choices[j] =
                  event.questions[i].choices[j].copyWith(
                isSelected: true,
              );
              event.questions[i] = event.questions[i].copyWith(
                value: event.questions[i].value == ""
                    ? event.questions[i].choices[j].id.toString()
                    : event.questions[i].value.contains(
                            event.questions[i].choices[j].id.toString())
                        ? event.questions[i].value
                        : "${event.questions[i].value},${event.questions[i].choices[j].id.toString()}",
                notAnswered: false,
              );
              isAnswered = true;
            }
          }
        }
        if (isAnswered) {
          event.questions[i] = event.questions[i].copyWith(
            notAnswered: false,
          );
        } else {
          event.questions[i] = event.questions[i].copyWith(
            notAnswered: true,
          );
        }
      }
    }

    emit(AnswerQuestionState(questions: event.questions));
  }

  FutureOr<void> _onOpenRulesBottomSheetEvent(
      OpenRulesBottomSheetEvent event, Emitter<QrConfigurationState> emit) {
    emit(OpenRulesBottomSheetState());
  }

  FutureOr<void> _onCreateQrEvent(
      CreateQrEvent event, Emitter<QrConfigurationState> emit) async {
    bool isValid = true;
    QrErrorMessages qrErrorMessages = event.qrErrorMessages;
    if (event.selectedDate == null) {
      qrErrorMessages.dateErrorMessage = S.current.thisFieldIsRequired;
      isValid = false;
    }
    List<String> words = event.visitorName.trim().toString().split(' ');
    if (event.visitorName.trim().toString().isEmpty) {
      qrErrorMessages.visitorNameErrorMessage = S.current.thisFieldIsRequired;
      isValid = false;
    } else if (words.length < 2 || words.any((word) => word.length < 2)) {
      qrErrorMessages.visitorNameErrorMessage =
          S.current.enterTwoWordsEachWordContains2Characters;
      isValid = false;
    } else {
      qrErrorMessages.visitorNameErrorMessage = null;
    }
    bool isDaySelected = false;
    for (var day in event.days) {
      if (day.isSelected) {
        isDaySelected = true;
        break;
      }
    }

    bool isTimeSelected = false;
    for (int i = 0 ; i < event.days.length ; i++) {
      if(event.days[i].isSelected) {
        for (int j = 0 ; j < event.days[i].times.length ; j++) {
          if(event.days[i].times[j].isSelected) {
            isTimeSelected = true;
            break;
          } else {
            isTimeSelected = false;
          }
        }
      }
    }

    if (event.days.isEmpty &&
        event.qrsType.code != "single" &&
        event.selectedDate != null &&
        !isDaySelected) {
      qrErrorMessages.daysErrorMessage = S.current.thisFieldIsRequired;
      isValid = false;
    }

    if( event.qrsType.code != "single" &&
        event.selectedDate != null &&
        !isTimeSelected && event.days.isNotEmpty) {
      qrErrorMessages.timeErrorMessage = S.current.thisFieldIsRequired;
      isValid = false;
    }



    if (event.availableTimes.where((element) => element.isSelected).toList().isEmpty  &&
        event.selectedDate != null &&
        event.availableTimes.isNotEmpty && event.qrsType.code == "single") {
      qrErrorMessages.timeErrorMessage = S.current.thisFieldIsRequired;
      isValid = false;
    }

    for (var i = 0; i < event.questions.length; i++) {
      if (event.questions[i].isRequired && event.questions[i].value.isEmpty) {
        event.questions[i] = event.questions[i].copyWith(notAnswered: true);
        isValid = false;
      } else {
        event.questions[i] = event.questions[i].copyWith(notAnswered: false);
      }
      if (!event.questions[i].isValid) {
        isValid = false;
      }
    }
    if (isValid) {
      emit(ShowLoadingState());
      CreateQrRequest request = CreateQrRequest(
        guestTypeId: event.guestsType.id,
        qrTypeId: event.qrsType.id,
        fromDate: event.qrsType.code == "single"
            ? event.selectedDate.toString()
            : event.firstDate.toString(),
        toDate: event.selectedDate.toString(),
        name: event.visitorName,
        address: _getUserUnitsUseCase().unitName,
        unitsQrCodeDays: event.qrsType.code == "single"
            ? []
            : event.days.toUnitsQrCodeDays(),
        unitQrQuestionAnswers: event.questions.mapToUnitQrQuestionAnswerList(),
        timeId: event.qrsType.code == "single" ? event.availableTimes.where((element) => element.isSelected).toList().first.id : -1,
      );

      final dataState = await _createQrCodeUseCase(request);
      if (dataState is DataSuccess) {
        emit(CreateQrSuccessState(
          createQrResponse: dataState.data ?? const CreateQrResponse(),
        ));
      } else {
        emit(CreateQrErrorState(message: dataState.message ?? ""));
      }
      emit(HideLoadingState());
    } else {
      emit(QrValidationErrorState(
        qrErrorMessages: qrErrorMessages,
        questions: event.questions,
      ));
    }
  }

  FutureOr<void> _onOpenDatePickerEvent(
      OpenDatePickerEvent event, Emitter<QrConfigurationState> emit) {
    emit(OpenDatePickerState(
      onDateSelected: event.onDateSelected,
    ));
  }

  FutureOr<void> _onSelectDateEvent(
      SelectDateEvent event, Emitter<QrConfigurationState> emit) {
    // selectedDays = [];
    emit(SelectDateState(dateTime: event.selectedDate));
  }

  FutureOr<void> _onSelectSingleQRTimeEvent(
      SelectSingleQRTimeEvent event, Emitter<QrConfigurationState> emit) {

    for (int i = 0; i < event.dayTimes.length; i++) {
      if (event.dayTimes[i].id == event.selectedTime.id) {
        event.dayTimes[i] = event.dayTimes[i].copyWith(
          isSelected: true,
        );
      } else {
        event.dayTimes[i] = event.dayTimes[i].copyWith(
          isSelected: false,
        );
      }
    }
    emit(SelectSingleQRTimeState(availableTimes: event.dayTimes));
  }

  FutureOr<void> _onSelectDayEvent(
      SelectDayEvent event, Emitter<QrConfigurationState> emit) {
    Day selectedDay = event.selectedDay;
    if(event.selectedDay.isSelected) {
      for (int i = 0; i < event.days.length; i++) {
        if (event.days[i].id == event.selectedDay.id) {
          event.days[i] = event.days[i].copyWith(
            isSelected: false,
          );

          selectedDay = event.selectedDay.copyWith(
            isSelected: false,
          );

          for (int j = 0; j < event.days[i].times.length; j++) {
            event.days[i].times[j] = event.days[i].times[j].copyWith(
              isSelected: false,
            );
          }

          break;
        }
      }
      event.qrErrorMessages.timeErrorMessage = null;
    } else {
      bool selectNewDate = true;
      for(int i = 0; i < event.days.length; i++) {
        if(event.days[i].isSelected) {
          bool isTimeSelected = false;
          for (int j = 0; j < event.days[i].times.length; j++) {
            if(event.days[i].times[j].isSelected) {
              isTimeSelected = true;
              break;
            }
          }

          if(!isTimeSelected) {
            event.qrErrorMessages.timeErrorMessage = S.current.thisFieldIsRequired;
            selectNewDate = false;
            break;
          }
        }
      }

      if(selectNewDate) {
        for (int i = 0; i < event.days.length; i++) {
          if (event.days[i].id == event.selectedDay.id) {
            event.days[i] = event.days[i].copyWith(
              isSelected: true,
            );
            break;
          }
        }
        selectedDay = event.selectedDay.copyWith(
          isSelected: true,
        );
      }
    }

    emit(SelectDayState(
      days: event.days,
      selectedDay: selectedDay,
      qrErrorMessages: event.qrErrorMessages,
    ));
  }

  FutureOr<void> _onValidateVisitorNameEvent(
      ValidateVisitorNameEvent event, Emitter<QrConfigurationState> emit) {
    emit(ValidateVisitorNameState());
  }

  FutureOr<void> _onDeleteDateEvent(
      DeleteDateEvent event, Emitter<QrConfigurationState> emit) {
    emit(DeleteDateState());
  }

  FutureOr<void> _onSelectMultipleQRTimeEvent(SelectMultipleQRTimeEvent event, Emitter<QrConfigurationState> emit) {
    for(int i = 0 ; i < event.days.length ; i++ ){
      if(event.days[i].id == event.selectedDay.id){

        for(int j = 0 ; j < event.days[i].times.length ; j++){
          if(event.days[i].times[j].id == event.selectedTime.id){
            event.days[i].times[j] = event.days[i].times[j].copyWith(
              isSelected: true,
            );
          } else {
            event.days[i].times[j] = event.days[i].times[j].copyWith(
              isSelected: false,
            );
          }
        }
        break;
      }
    }
    emit(SelectMultipleQRTimeState(multipleQrOrderedDays: event.days));
  }
}
