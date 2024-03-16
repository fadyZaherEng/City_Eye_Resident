import 'dart:async';
import 'dart:io';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/core/utils/community_request_keys.dart';
import 'package:city_eye/src/core/utils/compress_video.dart';
import 'package:city_eye/src/core/utils/validation/community_validator.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/community_request/request/submit_community_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/request/page_code_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/request/page_fields_request.dart';
import 'package:city_eye/src/domain/entities/settings/choice.dart';
import 'package:city_eye/src/domain/entities/settings/compound_configuration.dart';
import 'package:city_eye/src/domain/entities/settings/page_field.dart';
import 'package:city_eye/src/domain/usecase/community/submit_community_request_use_case.dart';
import 'package:city_eye/src/domain/usecase/dynamic_question_validation_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_local_compound_configuration_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_page_fields_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_user_unit_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:city_eye/src/domain/entities/settings/page.dart' as pg;

import '../../../domain/entities/community_request/media_type.dart';
import '../../../domain/usecase/community/community_validator_use_case.dart';

part 'community_request_event.dart';

part 'community_request_state.dart';

class CommunityRequestBloc
    extends Bloc<CommunityRequestEvent, CommunityRequestState> {
  /// ***************** Dynamic Widgets ***************************
  final CommunityValidateQuestionsUseCase _validateQuestionsUseCase;
  final GetUserUnitUseCase _getUserUnitUseCase;
  final GetLocalCompoundConfigurationUseCase
      _getLocalCompoundConfigurationUseCase;
  final GetPageFieldsUseCase _getPageFieldsUseCase;
  final SubmitCommunityRequestUseCase _submitCommunityRequestUseCase;
  final DynamicQuestionValidationUseCase _dynamicQuestionValidationUseCase;

  List<PageField> _communityQuestions = [];

  CommunityRequestBloc(
    this._validateQuestionsUseCase,
    this._getUserUnitUseCase,
    this._getLocalCompoundConfigurationUseCase,
    this._getPageFieldsUseCase,
    this._submitCommunityRequestUseCase,
    this._dynamicQuestionValidationUseCase,
  ) : super(ShowSkeletonState()) {
    on<GetCompoundConfigurationEvent>(_onGetCompoundConfigurationEvent);
    on<CommunityNavigationBackEvent>(_onCommunityNavigationBackEvent);
    on<DescribeRequestValidationEvent>(_onDescribeRequestValidationEvent);
    on<CommunityChangeRecordingEvent>(_onCommunityChangeRecordingEvent);
    on<CommunityAddImageEvent>(_onCommunityAddImageEvent);
    on<CommunityAddMultipleImagesEvent>(_onCommunityAddMultipleImagesEvent);
    on<CommunityAddVideoEvent>(_onCommunityAddVideoEvent);
    on<NavigateToVideoTrimmerScreenEvent>(_onNavigateToVideoTrimmerScreenEvent);
    on<CommunityRemoveVideoEvent>(_onCommunityRemoveVideoEvent);
    on<CommunityRemoveImageEvent>(_onCommunityRemoveImageEvent);
    on<CommunityOpenMediaBottomSheetEvent>(
        _onCommunityOpenMediaBottomSheetEvent);
    on<CommunitySendRequestEvent>(_onCommunitySendRequestEvent);
    on<GetQuestionsEvent>(_onGetQuestionsEvent);
    on<SelectSingleSelectionAnswerEvent>(_onSelectSingleSelectionAnswerEvent);
    on<SelectMultiSelectionAnswerEvent>(_onSelectMultiSelectionAnswerEvent);
    on<AddAnswerToQuestionEvent>(_onAddAnswerToQuestionEvent);
    on<DeleteQuestionAnswerEvent>(_onDeleteQuestionAnswerEvent);
    on<ShowMediaBottomSheetEvent>(_onShowMediaBottomSheetEvent);
    on<ShowDialogToDeleteQuestionAnswerEvent>(
        _onShowDialogToDeleteQuestionAnswerEvent);
    on<AddQuestionImageEvent>(_onAddQuestionImageEvent);
    on<ShowQrSearchableBottomSheetEvent>(_onShowQrSearchableBottomSheetEvent);
    on<UpdateSearchableSingleQuestionEvent>(
        _onUpdateSearchableSingleQuestionEvent);
    on<UpdateSearchableMultiQuestionEvent>(
        _onUpdateSearchableMultiQuestionEvent);
    on<InitializeRecorderEvent>(_onInitializeRecorderEvent);
    on<StartRecordingEvent>(_onStartRecordingEvent);
    on<StopRecordingEvent>(_onStopRecordingEvent);
    on<SaveAudioPathEvent>(_onSaveAudioPathEvent);
    on<RemoveAudioFileEvent>(_onRemoveAudioFileEvent);
    on<AudioStatusChangeEvent>(_onAudioStatusChangeEvent);
  }

  FutureOr<void> _onGetCompoundConfigurationEvent(
      GetCompoundConfigurationEvent event,
      Emitter<CommunityRequestState> emit) {
    emit(GetCompoundConfigurationState(
      configuration: _getLocalCompoundConfigurationUseCase(),
    ));
  }

  FutureOr<void> _onCommunityNavigationBackEvent(
      CommunityNavigationBackEvent event, Emitter<CommunityRequestState> emit) {
    emit(CommunityBackState());
  }

  FutureOr<void> _onDescribeRequestValidationEvent(
      DescribeRequestValidationEvent event,
      Emitter<CommunityRequestState> emit) {
    if (event.value.isEmpty || event.value.length >= event.min) {
      emit(CommunityDescribeRequestValidState());
    } else {
      emit(CommunityDescribeRequestInvalidState());
    }
  }

  FutureOr<void> _onCommunityChangeRecordingEvent(
      CommunityChangeRecordingEvent event,
      Emitter<CommunityRequestState> emit) async {
    emit(CommunityChangeRecordingState());
  }

  FutureOr<void> _onCommunityOpenMediaBottomSheetEvent(
      CommunityOpenMediaBottomSheetEvent event,
      Emitter<CommunityRequestState> emit) {
    emit(CommunityOpenMediaBottomSheetState(
      mediaType: event.mediaType,
      question: event.question,
    ));
  }

  FutureOr<void> _onCommunityAddImageEvent(
      CommunityAddImageEvent event, Emitter<CommunityRequestState> emit) {
    if (event.image != null) {
      emit(CommunityAddImageState(
          image: File(
        event.image!.path,
      )));
    } else {
      emit(CommunityNoImageSelectedState(
        message: S.current.noImageSelected,
      ));
    }
  }

  FutureOr<void> _onCommunityAddMultipleImagesEvent(
      CommunityAddMultipleImagesEvent event,
      Emitter<CommunityRequestState> emit) {
    List<File> images = [];
    for (var i = 0; i < event.images.length; i++) {
      images.add(File(event.images[i]!.path));
    }

    emit(CommunityAddMultipleImageState(images: images));
  }

  FutureOr<void> _onCommunityAddVideoEvent(
      CommunityAddVideoEvent event, Emitter<CommunityRequestState> emit) async {
    if (event.video != null) {
      emit(ShowVideoSkeletonState());
      File? compressedFile = await compressVideo(event.video!.path);
      if (compressedFile != null) {
        emit(CommunityAddVideoState(
          video: compressedFile,
          imageSource: event.imageSource,
        ));
      } else {
        emit(CommunityNoVideoSelectedState(
          message: S.current.noImageSelected,
        ));
      }
    } else {
      emit(CommunityNoVideoSelectedState(
        message: S.current.noImageSelected,
      ));
    }
  }

  FutureOr<void> _onNavigateToVideoTrimmerScreenEvent(
      NavigateToVideoTrimmerScreenEvent event,
      Emitter<CommunityRequestState> emit) {
    emit(NavigateToVideoTrimmerScreenState(
      video: event.video,
      maxDuration: event.maxDuration,
    ));
  }

  FutureOr<void> _onCommunityRemoveVideoEvent(
      CommunityRemoveVideoEvent event, Emitter<CommunityRequestState> emit) {
    emit(CommunityRemoveVideoState());
  }

  FutureOr<void> _onCommunityRemoveImageEvent(
      CommunityRemoveImageEvent event, Emitter<CommunityRequestState> emit) {
    event.images.removeAt(
      event.index,
    );
    emit(CommunityRemoveImageState(
      images: event.images,
      index: event.index,
    ));
  }

  FutureOr<void> _onCommunitySendRequestEvent(CommunitySendRequestEvent event,
      Emitter<CommunityRequestState> emit) async {
    var validationsState =
        _validateQuestionsUseCase.validateMandatoryQuestions(event.questions);

    for (var i = 0; i < event.questions.length; i++) {
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
          validationsState = CommunityValidationState.invalidQuestions;
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
    }
    // if (event.description.length < event.minLength) {
    //   emit(CommunityDescribeRequestInvalidState());
    // } else {
    if (validationsState == CommunityValidationState.valid) {
      emit(CommunityDescribeRequestValidState());
      emit(CommunityRequestLoadingState());

      SubmitCommunityRequest submitCommunityRequest = SubmitCommunityRequest(
        description: event.description,
        extraFieldAnswers: event.questions.mapToExtraFieldAnswersRequestList(),
      );

      List<String> imagesPath = [];
      for (var i = 0; i < event.images.length; i++) {
        imagesPath.add(event.images[i].path);
      }

      DataState dataState = await _submitCommunityRequestUseCase(
          event.audioPath, imagesPath, event.videoFile, submitCommunityRequest);
      if (dataState is DataSuccess) {
        emit(CommunityRequestSuccessState(message: dataState.message ?? ""));
      } else {
        emit(CommunityRequestErrorState(errorMessage: dataState.message ?? ""));
      }
    } else {
      for (int i = 0; i < _communityQuestions.length; i++) {
        if (_communityQuestions[i].isRequired &&
            _communityQuestions[i].notAnswered) {
          emit(ScrollToUnAnsweredMandatoryQuestionState(
              key: _communityQuestions[i].key ?? GlobalKey()));
          break;
        }
      }
    }
    // }
  }

  /// ***************** Dynamic Widgets Methods ***************************

  FutureOr<void> _onGetQuestionsEvent(
      GetQuestionsEvent event, Emitter<CommunityRequestState> emit) async {
    emit(ShowSkeletonState());

    PageFieldsRequest pageFieldsRequest = PageFieldsRequest(
      compoundId: _getUserUnitUseCase().compoundId,
      userTypeId: 0,
      generalExtrafield: [
        const PageCodeRequest(pageCode: CommunityRequestKeys.community)
      ],
    );

    final DataState<List<pg.Page>> dataState =
        await _getPageFieldsUseCase(pageFieldsRequest);
    if (dataState is DataSuccess) {
      _communityQuestions = (dataState.data ?? []).first.fields;
      for (var i = 0; i < _communityQuestions.length; i++) {
        GlobalKey key = GlobalKey();
        _communityQuestions[i] = _communityQuestions[i].copyWith(
          key: key,
        );
      }
      emit(GetQuestionsSuccessState(questions: _communityQuestions));
    } else {
      emit(GetQuestionsErrorState(errorMessage: dataState.message ?? ""));
    }
  }

  FutureOr<void> _onSelectSingleSelectionAnswerEvent(
      SelectSingleSelectionAnswerEvent event,
      Emitter<CommunityRequestState> emit) {
    for (var i = 0; i < _communityQuestions.length; i++) {
      if (_communityQuestions[i].id == event.question.id) {
        for (var j = 0; j < _communityQuestions[i].choices.length; j++) {
          if (_communityQuestions[i].choices[j].id == event.answerId) {
            _communityQuestions[i].choices[j].isSelected =
                !_communityQuestions[i].choices[j].isSelected;
            _communityQuestions[i] = _communityQuestions[i].copyWith(
              notAnswered: false,
              value: _communityQuestions[i].choices[j].id.toString(),
            );
            if (!_communityQuestions[i].choices[j].isSelected) {
              _communityQuestions[i] = _communityQuestions[i].copyWith(
                notAnswered: true,
                value: "",
              );
            }
          } else {
            _communityQuestions[i].choices[j].isSelected = false;
          }
        }
      }
    }
    emit(UpdateMapQuestionToWidgetState(questions: _communityQuestions));
  }

  FutureOr<void> _onSelectMultiSelectionAnswerEvent(
      SelectMultiSelectionAnswerEvent event,
      Emitter<CommunityRequestState> emit) {
    for (var i = 0; i < _communityQuestions.length; i++) {
      if (_communityQuestions[i].id == event.question.id) {
        for (var j = 0; j < _communityQuestions[i].choices.length; j++) {
          if (_communityQuestions[i].choices[j].id == event.answerId) {
            _communityQuestions[i].choices[j].isSelected =
                !_communityQuestions[i].choices[j].isSelected;
          }
        }
      }
    }
    for (var i = 0; i < _communityQuestions.length; i++) {
      if (_communityQuestions[i].id == event.question.id) {
        bool isAnswered = false;
        _communityQuestions[i] = _communityQuestions[i].copyWith(
          value: "",
        );
        for (var j = 0; j < _communityQuestions[i].choices.length; j++) {
          if (_communityQuestions[i].choices[j].isSelected) {
            _communityQuestions[i] = _communityQuestions[i].copyWith(
              notAnswered: false,
            );
            if (_communityQuestions[i].value == "") {
              _communityQuestions[i] = _communityQuestions[i].copyWith(
                value: _communityQuestions[i].choices[j].id.toString(),
              );
            } else {
              _communityQuestions[i] = _communityQuestions[i].copyWith(
                value:
                    "${_communityQuestions[i].value},${_communityQuestions[i].choices[j].id}",
              );
            }
            isAnswered = true;
          } else {
            _communityQuestions[i] = _communityQuestions[i].copyWith(
              value: _communityQuestions[i].value.replaceAll(
                    _communityQuestions[i].choices[j].id.toString(),
                    '',
                  ),
            );
            try {
              _communityQuestions[i] = _communityQuestions[i].copyWith(
                value: _communityQuestions[i].value.replaceAll(
                      ",,",
                      ',',
                    ),
              );
            } catch (_) {}
          }
        }
        if (isAnswered) {
          _communityQuestions[i] = _communityQuestions[i].copyWith(
            notAnswered: false,
          );
        } else if (!isAnswered && _communityQuestions[i].isRequired) {
          _communityQuestions[i] = _communityQuestions[i].copyWith(
            notAnswered: true,
          );
        }
      }
    }

    emit(UpdateMapQuestionToWidgetState(questions: _communityQuestions));
  }

  FutureOr<void> _onAddAnswerToQuestionEvent(
      AddAnswerToQuestionEvent event, Emitter<CommunityRequestState> emit) {
    for (var i = 0; i < _communityQuestions.length; i++) {
      if (_communityQuestions[i].id == event.question.id) {
        _communityQuestions[i] = _communityQuestions[i].copyWith(
          value: event.answer,
          notAnswered: false,
        );
      }

      if (_communityQuestions[i].value.isNotEmpty) {
        Map<String,dynamic> validation = _dynamicQuestionValidationUseCase(
          validation: _communityQuestions[i].validations,
          value: _communityQuestions[i].value,
          questionCode: _communityQuestions[i].code,
        );
        if (!validation["isValid"]) {
          _communityQuestions[i] = _communityQuestions[i].copyWith(
            isValid: false,
            validationMessage: validation["validationMessage"],
          );
        } else {
          _communityQuestions[i] = _communityQuestions[i].copyWith(
            isValid: true,
            validationMessage: "",
          );
        }
      } else {
        _communityQuestions[i] = _communityQuestions[i].copyWith(
          isValid: true,
        );
      }
    }
    emit(UpdateMapQuestionToWidgetState(questions: _communityQuestions));
  }

  FutureOr<void> _onDeleteQuestionAnswerEvent(
      DeleteQuestionAnswerEvent event, Emitter<CommunityRequestState> emit) {
    for (var i = 0; i < _communityQuestions.length; i++) {
      if (_communityQuestions[i].id == event.question.id) {
        _communityQuestions[i] = _communityQuestions[i].copyWith(
          value: '',
          notAnswered: true,
        );
      }
    }
    emit(UpdateMapQuestionToWidgetState(questions: _communityQuestions));
  }

  FutureOr<void> _onShowMediaBottomSheetEvent(
      ShowMediaBottomSheetEvent event, Emitter<CommunityRequestState> emit) {
    emit(DynamicMediaBottomSheetState(
      question: event.question,
      mediaType: MediaType.image,
    ));
  }

  FutureOr<void> _onShowDialogToDeleteQuestionAnswerEvent(
      ShowDialogToDeleteQuestionAnswerEvent event,
      Emitter<CommunityRequestState> emit) {
    emit(ShowDialogToDeleteQuestionAnswerState(
      question: event.question,
    ));
  }

  FutureOr<void> _onAddQuestionImageEvent(
      AddQuestionImageEvent event, Emitter<CommunityRequestState> emit) {
    for (var i = 0; i < _communityQuestions.length; i++) {
      if (_communityQuestions[i].id == event.question.id) {
        _communityQuestions[i] = _communityQuestions[i].copyWith(
          value: event.image.path,
          notAnswered: false,
        );
      }
    }
    emit(UpdateMapQuestionToWidgetState(
      questions: _communityQuestions,
    ));
  }

  FutureOr<void> _onShowQrSearchableBottomSheetEvent(
      ShowQrSearchableBottomSheetEvent event,
      Emitter<CommunityRequestState> emit) {
    emit(ShowQrSearchableBottomSheetState(
        question: event.question, isMultiChoice: event.isMultiChoice));
  }

  void _onUpdateSearchableSingleQuestionEvent(
      UpdateSearchableSingleQuestionEvent event,
      Emitter<CommunityRequestState> emit) {
    for (var i = 0; i < _communityQuestions.length; i++) {
      if (_communityQuestions[i].id == event.question.id) {
        _communityQuestions[i] = _communityQuestions[i].copyWith(
          value: event.answer.id.toString(),
          notAnswered: false,
        );
        for (var j = 0; j < _communityQuestions[i].choices.length; j++) {
          if (_communityQuestions[i].choices[j].id == event.answer.id) {
            _communityQuestions[i].choices[j] =
                _communityQuestions[i].choices[j].copyWith(
                      isSelected: true,
                    );
            _communityQuestions[i] =
                _communityQuestions[i].copyWith(notAnswered: false);
          } else {
            _communityQuestions[i].choices[j] =
                _communityQuestions[i].choices[j].copyWith(
                      isSelected: false,
                    );
          }
        }

        if (_communityQuestions[i].value.isNotEmpty) {
          _communityQuestions[i] = _communityQuestions[i].copyWith(
            notAnswered: false,
          );
        } else {
          _communityQuestions[i] =
              _communityQuestions[i].copyWith(value: "", notAnswered: false);
        }
      }
    }
    emit(UpdateMapQuestionToWidgetState(questions: _communityQuestions));
  }

  FutureOr<void> _onUpdateSearchableMultiQuestionEvent(
      UpdateSearchableMultiQuestionEvent event,
      Emitter<CommunityRequestState> emit) {
    bool isAnswered = false;
    for (var i = 0; i < _communityQuestions.length; i++) {
      if (_communityQuestions[i].id == event.question.id) {
        _communityQuestions[i] = _communityQuestions[i].copyWith(
          value: "",
        );
        for (var j = 0; j < _communityQuestions[i].choices.length; j++) {
          _communityQuestions[i].choices[j] =
              _communityQuestions[i].choices[j].copyWith(
                    isSelected: false,
                  );
        }
        for (var j = 0; j < _communityQuestions[i].choices.length; j++) {
          for (var k = 0; k < event.answer.length; k++) {
            if (_communityQuestions[i].choices[j].id == event.answer[k].id) {
              _communityQuestions[i].choices[j] =
                  _communityQuestions[i].choices[j].copyWith(
                        isSelected: true,
                      );
              _communityQuestions[i] = _communityQuestions[i].copyWith(
                value: _communityQuestions[i].value == ""
                    ? _communityQuestions[i].choices[j].id.toString()
                    : _communityQuestions[i].value.contains(
                            _communityQuestions[i].choices[j].id.toString())
                        ? _communityQuestions[i].value
                        : "${_communityQuestions[i].value},${_communityQuestions[i].choices[j].id.toString()}",
                notAnswered: false,
              );
              isAnswered = true;
            }
          }
        }
        if (isAnswered) {
          _communityQuestions[i] = _communityQuestions[i].copyWith(
            notAnswered: false,
          );
        } else {
          _communityQuestions[i] = _communityQuestions[i].copyWith(
            notAnswered: true,
          );
        }
      }
    }
    emit(UpdateMapQuestionToWidgetState(questions: _communityQuestions));
  }

  FutureOr<void> _onInitializeRecorderEvent(
      InitializeRecorderEvent event, Emitter<CommunityRequestState> emit) {
    emit(InitializeRecorderState());
  }

  FutureOr<void> _onStartRecordingEvent(
      StartRecordingEvent event, Emitter<CommunityRequestState> emit) {
    emit(StartRecordingState());
  }

  FutureOr<void> _onStopRecordingEvent(
      StopRecordingEvent event, Emitter<CommunityRequestState> emit) {
    emit(StopRecordingState());
  }

  FutureOr<void> _onSaveAudioPathEvent(
      SaveAudioPathEvent event, Emitter<CommunityRequestState> emit) {
    emit(SaveAudioPathState(audioPath: event.audioPath));
  }

  FutureOr<void> _onRemoveAudioFileEvent(
      RemoveAudioFileEvent event, Emitter<CommunityRequestState> emit) {
    emit(RemoveAudioFileState(
      audioPath: event.audioPath,
      isReplace: event.isReplace,
    ));
  }

  FutureOr<void> _onAudioStatusChangeEvent(
      AudioStatusChangeEvent event, Emitter<CommunityRequestState> emit) {
    emit(AudioStatusChangeState(
      isRecording: event.isRecording,
      duration: event.duration,
    ));
  }
}
