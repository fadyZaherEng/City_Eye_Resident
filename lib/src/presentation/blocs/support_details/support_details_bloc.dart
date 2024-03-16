import 'dart:async';
import 'dart:io';

import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/core/utils/complain_keys.dart';
import 'package:city_eye/src/core/utils/compress_video.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/request/request_support_multi_media.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/request/submit_support_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/request/support_details_date_request.dart';
import 'package:city_eye/src/domain/entities/home/home_support.dart';
import 'package:city_eye/src/domain/entities/settings/compound_multi_media_configuration.dart';
import 'package:city_eye/src/domain/entities/settings/multi_media_configuration.dart';
import 'package:city_eye/src/domain/entities/settings/multi_media_type.dart';
import 'package:city_eye/src/domain/entities/support_details/day_times.dart';
import 'package:city_eye/src/domain/entities/support_details/days.dart';
import 'package:city_eye/src/domain/entities/support_details/prepared_visit_time.dart';
import 'package:city_eye/src/domain/entities/support_details/submit_support.dart';
import 'package:city_eye/src/domain/entities/support_details/support_details_date.dart';
import 'package:city_eye/src/domain/usecase/get_local_compound_configuration_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_support_service_index_use_case.dart';
import 'package:city_eye/src/domain/usecase/select_prepared_visit_time_use_case.dart';
import 'package:city_eye/src/domain/usecase/support_details/get_support_compound_configration_use_case.dart';
import 'package:city_eye/src/domain/usecase/support_details/get_support_details_date_use_case.dart';
import 'package:city_eye/src/domain/usecase/support_details/submit_support_use_case.dart';
import 'package:city_eye/src/presentation/screens/support_details/support_details_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'support_details_event.dart';

part 'support_details_state.dart';

class SupportDetailsBloc
    extends Bloc<SupportDetailsEvent, SupportDetailsState> {
  final GetSupportServiceIndexUseCase _getSupportServiceIndexUseCase;
  final SelectPreparedVisitTimeUseCase _selectPreparedVisitTimeUseCase;
  final GetSupportDetailsDateUseCase _getSupportDetailsDateUseCase;
  final GetLocalCompoundConfigurationUseCase
      _getLocalCompoundConfigurationUseCase;
  final SupportDetailsConfigurationUseCase _supportDetailsConfigurationUseCase;
  final SubmitSupportUseCase _submitSupportUseCase;

  SupportDetailsBloc(
    this._getSupportServiceIndexUseCase,
    this._selectPreparedVisitTimeUseCase,
    this._getSupportDetailsDateUseCase,
    this._getLocalCompoundConfigurationUseCase,
    this._supportDetailsConfigurationUseCase,
    this._submitSupportUseCase,
  ) : super(SupportDetailsInitial()) {
    on<SelectSupportServiceEvent>(_onSelectSupportServiceEvent);
    on<ScrollToSupportServiceEvent>(_onScrollToSupportServiceEvent);
    on<SelectPreparedVisitTimeEvent>(_onSelectPreparedVisitTimeEvent);
    on<DescribeRequestValidationEvent>(_onDescribeRequestValidationEvent);
    on<OpenMediaBottomSheetEvent>(_onOpenMediaBottomSheetEvent);
    on<AddImageEvent>(_onAddImageEvent);
    on<AddMultipleImagesEvent>(_onAddMultipleImagesEvent);
    on<RemoveImageEvent>(_onRemoveImageEvent);
    on<AddVideoEvent>(_onAddVideoEvent);
    on<RemoveVideoEvent>(_onRemoveVideoEvent);
    on<SelectPreparedTimeVisitDateEvent>(_onSelectPreparedTimeVisitDateEvent);
    on<NavigateToVideoTrimmerScreenEvent>(_onNavigateToVideoTrimmerScreenEvent);
    on<ChangeRecordingEvent>(_onStartRecordAudioEvent);
    on<ResetAllValuesEvent>(_onResetAllValuesEvent);
    on<NavigateBackEvent>(_onNavigateBackEvent);
    on<GetSupportDetailsDateEvent>(_onGetSupportDetailsDateEvent);
    on<GetSupportCompoundMultiMediaConfigurationEvent>(
        _onGetSupportCompoundConfiguration);
    on<GetSupportMultiMediaEvent>(_onGetSupportMultiMediaEvent);
    on<SendSupportRequestEvent>(_onSendSupportRequestEvent);
    on<InitializeRecorderEvent>(_onInitializeRecorderEvent);
    on<StartRecordingEvent>(_onStartRecordingEvent);
    on<StopRecordingEvent>(_onStopRecordingEvent);
    on<SaveAudioPathEvent>(_onSaveAudioPathEvent);
    on<RemoveAudioFileEvent>(_onRemoveAudioFileEvent);
    on<AudioStatusChangeEvent>(_onAudioStatusChangeEvent);
  }

  FutureOr<void> _onSelectSupportServiceEvent(
      SelectSupportServiceEvent event, Emitter<SupportDetailsState> emit) {
    emit(SelectSupportServiceState(supportService: event.supportService));
  }

  FutureOr<void> _onScrollToSupportServiceEvent(
      ScrollToSupportServiceEvent event, Emitter<SupportDetailsState> emit) {
    emit(
      ScrollToSupportServiceState(
        selectedSupportServiceIndex: _getSupportServiceIndexUseCase(
          event.supportServices,
          event.supportService,
        ),
      ),
    );
  }

  FutureOr<void> _onNavigateBackEvent(
      NavigateBackEvent event, Emitter<SupportDetailsState> emit) {
    emit(NavigateBackState());
  }

  FutureOr<void> _onSelectPreparedVisitTimeEvent(
      SelectPreparedVisitTimeEvent event, Emitter<SupportDetailsState> emit) {
    emit(
      SelectPreparedTimeVisitState(
        preparedVisitTimes: _selectPreparedVisitTimeUseCase(
          event.preparedVisitTimes,
          event.selectedPreparedVisitTime.copyWith(
              isSelected: !event.selectedPreparedVisitTime.isSelected),
        ),
        selectedPreparedVisitTime: event.selectedPreparedVisitTime
            .copyWith(isSelected: !event.selectedPreparedVisitTime.isSelected),
      ),
    );
  }

  FutureOr<void> _onDescribeRequestValidationEvent(
      DescribeRequestValidationEvent event, Emitter<SupportDetailsState> emit) {
    if (event.value.isEmpty || event.value.length >= event.min) {
      emit(const DescribeRequestValidState());
    } else {
      emit(const DescribeRequestInvalidState());
    }
  }

  FutureOr<void> _onOpenMediaBottomSheetEvent(
      OpenMediaBottomSheetEvent event, Emitter<SupportDetailsState> emit) {
    emit(OpenMediaBottomSheetState(mediaType: event.mediaType));
  }

  FutureOr<void> _onAddImageEvent(
      AddImageEvent event, Emitter<SupportDetailsState> emit) {
    if (event.image != null) {
      emit(AddImageState(image: File(event.image!.path)));
    } else {
      emit(const NoImageSelectedState(message: "No image selected"));
    }
  }

  FutureOr<void> _onAddMultipleImagesEvent(
      AddMultipleImagesEvent event, Emitter<SupportDetailsState> emit) {
    List<File> images = [];
    for (var i = 0; i < event.images.length; i++) {
      images.add(File(event.images[i]!.path));
    }

    emit(AddMultipleImageState(images: images));
  }

  FutureOr<void> _onRemoveImageEvent(
      RemoveImageEvent event, Emitter<SupportDetailsState> emit) {
    event.images.removeAt(event.index);
    emit(RemoveImageState(images: event.images, index: event.index));
  }

  FutureOr<void> _onAddVideoEvent(
      AddVideoEvent event, Emitter<SupportDetailsState> emit) async {
    if (event.video != null) {
      emit(ShowVideoSkeletonState());
      File? compressedFile = await compressVideo(event.video!.path);
      if (compressedFile != null) {
        emit(AddVideoState(
            video: compressedFile, imageSource: event.imageSource));
      } else {
        emit(const NoVideoSelectedState(message: "No Video selected"));
      }
    } else {
      emit(const NoVideoSelectedState(message: "No Video selected"));
    }
  }

  FutureOr<void> _onRemoveVideoEvent(
      RemoveVideoEvent event, Emitter<SupportDetailsState> emit) {
    emit(RemoveVideoState());
  }

  FutureOr<void> _onSelectPreparedTimeVisitDateEvent(
      SelectPreparedTimeVisitDateEvent event,
      Emitter<SupportDetailsState> emit) {
    emit(SelectPreparedTimeVisitDateState(selectedDate: event.selectedDate));
  }

  FutureOr<void> _onNavigateToVideoTrimmerScreenEvent(
      NavigateToVideoTrimmerScreenEvent event,
      Emitter<SupportDetailsState> emit) {
    emit(NavigateToVideoTrimmerScreenState(
      video: event.video,
      maxDuration: event.maxDuration,
    ));
  }

  FutureOr<void> _onStartRecordAudioEvent(
      ChangeRecordingEvent event, Emitter<SupportDetailsState> emit) async {
    emit(ChangeRecordingState());
  }

  FutureOr<void> _onResetAllValuesEvent(
      ResetAllValuesEvent event, Emitter<SupportDetailsState> emit) {
    emit(ResetAllValuesState());
  }

  Future<void> _onGetSupportDetailsDateEvent(GetSupportDetailsDateEvent event,
      Emitter<SupportDetailsState> emit) async {
    emit(ShowPreparedTimeVisitSkeletonState());
    final supportDetailsDateState = await _getSupportDetailsDateUseCase(
      SupportDetailsDateRequest(
        categoryId: event.categoryId,
        date: event.date,
      ),
    );
    if (supportDetailsDateState is DataSuccess<SupportDetailsDate>) {
      emit(SuccessGetSupportDetailsDateState(
          supportDetailsDate: supportDetailsDateState.data ?? const SupportDetailsDate()));
    } else if (supportDetailsDateState is DataFailed) {
      emit(ErrorGetSupportDetailsDateState(
          message: supportDetailsDateState.message ?? ""));
    }
    emit(HidePreparedTimeVisitSkeletonState());
  }

  FutureOr<void> _onGetSupportCompoundConfiguration(
      GetSupportCompoundMultiMediaConfigurationEvent event,
      Emitter<SupportDetailsState> emit) {
    final compoundConfiguration = _getLocalCompoundConfigurationUseCase();
    final MultiMediaConfiguration supportCompoundMultiMediaConfiguration =
        _supportDetailsConfigurationUseCase(compoundConfiguration);
    if (supportCompoundMultiMediaConfiguration
        .compoundMultiMediaConfiguration.isNotEmpty) {
      emit(
        SuccessGetSupportMultiMediaConfigurationState(
            supportMultiMediaConfiguration:
                supportCompoundMultiMediaConfiguration),
      );
    } else {
      emit(ErrorGetSupportMultiMediaConfigurationStateState());
    }
  }

  FutureOr<void> _onGetSupportMultiMediaEvent(
      GetSupportMultiMediaEvent event, Emitter<SupportDetailsState> emit) {
    CompoundMultiMediaConfiguration imageMultiMediaConfiguration =
        const CompoundMultiMediaConfiguration(
      isVisible: false,
    );
    CompoundMultiMediaConfiguration audioMultiMediaConfiguration =
        const CompoundMultiMediaConfiguration(
      isVisible: false,
    );
    CompoundMultiMediaConfiguration videoMultiMediaConfiguration =
        const CompoundMultiMediaConfiguration(
      isVisible: false,
    );
    CompoundMultiMediaConfiguration textMultiMediaConfiguration =
        const CompoundMultiMediaConfiguration(
      minCount: 20,
      maxCount: 150,
      multiMediaType: MultiMediaType(
        code: 'text',
      ),
      isVisible: true,
    );

    event.multiMediaConfiguration.compoundMultiMediaConfiguration
        .forEach((element) {
      if (element.multiMediaType.code == ComplainKeys.audio) {
        audioMultiMediaConfiguration = element;
      } else if (element.multiMediaType.code == ComplainKeys.video) {
        videoMultiMediaConfiguration = element;
      } else if (element.multiMediaType.code == ComplainKeys.image) {
        imageMultiMediaConfiguration = element;
      } else if (element.multiMediaType.code == ComplainKeys.text) {
        textMultiMediaConfiguration = element;
      }
    });
    emit(GetSupportMultiMediaState(
      imageMultiMediaConfiguration: imageMultiMediaConfiguration,
      audioMultiMediaConfiguration: audioMultiMediaConfiguration,
      videoMultiMediaConfiguration: videoMultiMediaConfiguration,
      textMultiMediaConfiguration: textMultiMediaConfiguration,
    ));
  }

  FutureOr<void> _onSendSupportRequestEvent(
      SendSupportRequestEvent event, Emitter<SupportDetailsState> emit) async {
    emit(ShowLoadingState());
    final submitSupportRequest = await _submitSupportUseCase(
      event.submitSupportRequest,
      event.supportMultiMediaRequest,
    );
    if (submitSupportRequest is DataSuccess<SubmitSupport>) {
      emit(
        SuccessSubmitSupportRequestState(
          submitSupport: submitSupportRequest.data ?? const SubmitSupport(),
          message: submitSupportRequest.message ?? "",
        ),
      );
    } else if (submitSupportRequest is DataFailed) {
      emit(
        FailedSubmitSupportRequestState(
          message: submitSupportRequest.message ?? "",
        ),
      );
    }
    emit(HideLoadingState());
  }

  FutureOr<void> _onInitializeRecorderEvent(
      InitializeRecorderEvent event, Emitter<SupportDetailsState> emit) {
    emit(InitializeRecorderState());
  }

  FutureOr<void> _onStartRecordingEvent(
      StartRecordingEvent event, Emitter<SupportDetailsState> emit) {
    emit(StartRecordingState());
  }

  FutureOr<void> _onStopRecordingEvent(
      StopRecordingEvent event, Emitter<SupportDetailsState> emit) {
    emit(StopRecordingState());
  }

  FutureOr<void> _onSaveAudioPathEvent(
      SaveAudioPathEvent event, Emitter<SupportDetailsState> emit) {
    emit(SaveAudioPathState(audioPath: event.audioPath));
  }

  FutureOr<void> _onRemoveAudioFileEvent(
      RemoveAudioFileEvent event, Emitter<SupportDetailsState> emit) {
    emit(RemoveAudioFileState(
      audioPath: event.audioPath,
      isReplace: event.isReplace,
    ));
  }

  FutureOr<void> _onAudioStatusChangeEvent(
      AudioStatusChangeEvent event, Emitter<SupportDetailsState> emit) {
    emit(AudioStatusChangeState(
      isRecording: event.isRecording,
      duration: event.duration,
    ));
  }
}
