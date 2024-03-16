import 'dart:async';
import 'dart:io';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/core/utils/compress_file.dart';
import 'package:city_eye/src/core/utils/compress_video.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/complain/request/submit_complain_request.dart';
import 'package:city_eye/src/domain/entities/settings/compound_configuration.dart';
import 'package:city_eye/src/domain/usecase/complain/submit_complain_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_local_compound_configuration_use_case.dart';
import 'package:city_eye/src/presentation/blocs/support_details/support_details_bloc.dart';
import 'package:city_eye/src/presentation/screens/complain/complain_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'complain_event.dart';

part 'complain_state.dart';

class ComplainBloc extends Bloc<ComplainEvent, ComplainState> {
  final GetLocalCompoundConfigurationUseCase
  _getLocalCompoundConfigurationUseCase;
  final SubmitComplainUseCase _submitComplainUseCase;

  ComplainBloc(
      this._getLocalCompoundConfigurationUseCase,
      this._submitComplainUseCase,
      ) : super(ComplainInitialState()) {
    on<DescribeProblemValidationEvent>(_onDescribeProblemValidationEvent);
    on<NavigateBackEvent>(_onNavigateBackEvent);
    on<OpenMediaBottomSheetEvent>(_onOpenMediaBottomSheetEvent);
    on<AddImageEvent>(_onAddImageEvent);
    on<AddMultipleImagesEvent>(_onAddMultipleImagesEvent);
    on<AddVideoEvent>(_onAddVideoEvent);
    on<NavigateToVideoTrimmerScreenEvent>(_onNavigateToVideoTrimmerScreenEvent);
    on<RemoveVideoEvent>(_onRemoveVideoEvent);
    on<RemoveImageEvent>(_onRemoveImageEvent);
    on<SubmitRequestEvent>(_onSubmitRequestEvent);
    on<GetCompoundConfigurationEvent>(_onGetCompoundConfigurationEvent);
    on<InitializeRecorderEvent>(_onInitializeRecorderEvent);
    on<StartRecordingEvent>(_onStartRecordingEvent);
    on<StopRecordingEvent>(_onStopRecordingEvent);
    on<SaveAudioPathEvent>(_onSaveAudioPathEvent);
    on<RemoveAudioFileEvent>(_onRemoveAudioFileEvent);
    on<AudioStatusChangeEvent>(_onAudioStatusChangeEvent);
  }

  FutureOr<void> _onGetCompoundConfigurationEvent(
      GetCompoundConfigurationEvent event, Emitter<ComplainState> emit) {
    emit(GetCompoundConfigurationState(
      compoundConfiguration: _getLocalCompoundConfigurationUseCase(),
    ));
  }

  FutureOr<void> _onDescribeProblemValidationEvent(
      DescribeProblemValidationEvent event, Emitter<ComplainState> emit) {
    if (event.value.isEmpty || event.value.length >= event.min) {
      emit(DescribeProblemValidState());
    } else {
      emit(DescribeProblemInvalidState());
    }
  }

  FutureOr<void> _onNavigateBackEvent(
      NavigateBackEvent event, Emitter<ComplainState> emit) {
    emit(NavigateBackState());
  }

  FutureOr<void> _onOpenMediaBottomSheetEvent(
      OpenMediaBottomSheetEvent event, Emitter<ComplainState> emit) {
    emit(OpenMediaBottomSheetState(
      mediaType: event.mediaType,
    ));
  }

  FutureOr<void> _onAddImageEvent(
      AddImageEvent event, Emitter<ComplainState> emit) async {
    if (event.image != null) {
      XFile? compressedImage = await compressFile(File(event.image!.path));
      if (compressedImage != null) {
        emit(AddImageState(
          image: File(
            compressedImage.path,
          ),
        ));
      } else {
        emit(NoImageSelectedState(
          message: S.current.noImageSelected,
        ));
      }
    } else {
      emit(NoImageSelectedState(
        message: S.current.noImageSelected,
      ));
    }
  }

  FutureOr<void> _onAddMultipleImagesEvent(
      AddMultipleImagesEvent event, Emitter<ComplainState> emit) {
    List<File> images = [];
    for (var i = 0; i < event.images.length; i++) {
      images.add(File(event.images[i]!.path));
    }

    emit(AddMultipleImageState(images: images));
  }

  FutureOr<void> _onAddVideoEvent(
      AddVideoEvent event, Emitter<ComplainState> emit) async {
    if (event.video != null) {
      emit(ShowVideoSkeletonState());
      File? compressedFile = await compressVideo(event.video!.path);
      if (compressedFile != null) {
        emit(AddVideoState(
          video: File(compressedFile.path),
          imageSource: event.imageSource,
        ));
      } else {
        emit(NoVideoSelectedState(
          message: S.current.noImageSelected,
        ));
      }
    } else {
      emit(NoVideoSelectedState(
        message: S.current.noImageSelected,
      ));
    }
  }

  FutureOr<void> _onNavigateToVideoTrimmerScreenEvent(
      NavigateToVideoTrimmerScreenEvent event, Emitter<ComplainState> emit) {
    emit(NavigateToVideoTrimmerScreenState(
      video: event.video,
      maxDuration: event.maxDuration,
    ));
  }

  FutureOr<void> _onRemoveVideoEvent(
      RemoveVideoEvent event, Emitter<ComplainState> emit) {
    emit(RemoveVideoState());
  }

  FutureOr<void> _onRemoveImageEvent(
      RemoveImageEvent event, Emitter<ComplainState> emit) {
    event.images.removeAt(
      event.index,
    );
    emit(RemoveImageState(
      images: event.images,
      index: event.index,
    ));
  }

  FutureOr<void> _onSubmitRequestEvent(
      SubmitRequestEvent event, Emitter<ComplainState> emit) async {
    // if (event.description.length < event.min) {
    //   emit(DescribeProblemInvalidState());
    // } else {
    emit(DescribeProblemValidState());
    emit(ComplainLoadingState());
    SubmitComplainRequest submitComplainRequest = SubmitComplainRequest(
      description: event.description,
    );

    List<String> imagesPath = [];
    for (var i = 0; i < event.images.length; i++) {
      imagesPath.add(event.images[i].path);
    }

    DataState dataState = await _submitComplainUseCase(
        event.audioPath, event.videoFile, imagesPath, submitComplainRequest);
    if (dataState is DataSuccess) {
      emit(ComplainSubmitSuccessState(message: dataState.message ?? ""));
    } else {
      emit(ComplainSubmitErrorState(errorMessage: dataState.message ?? ""));
    }
    // }
  }

  FutureOr<void> _onInitializeRecorderEvent(
      InitializeRecorderEvent event, Emitter<ComplainState> emit) {
    emit(InitializeRecorderState());
  }

  FutureOr<void> _onStartRecordingEvent(
      StartRecordingEvent event, Emitter<ComplainState> emit) {
    emit(StartRecordingState());
  }

  FutureOr<void> _onStopRecordingEvent(
      StopRecordingEvent event, Emitter<ComplainState> emit) {
    emit(StopRecordingState());
  }

  FutureOr<void> _onSaveAudioPathEvent(
      SaveAudioPathEvent event, Emitter<ComplainState> emit) {
    emit(SaveAudioPathState(audioPath: event.audioPath));
  }

  FutureOr<void> _onRemoveAudioFileEvent(RemoveAudioFileEvent event, Emitter<ComplainState> emit) {
    emit(RemoveAudioFileState(
      audioPath: event.audioPath,
      isReplace: event.isReplace,
    ));
  }

  FutureOr<void> _onAudioStatusChangeEvent(AudioStatusChangeEvent event, Emitter<ComplainState> emit) {
    emit(AudioStatusChangeState(
      isRecording: event.isRecording,
      duration: event.duration,
    ));
  }
}