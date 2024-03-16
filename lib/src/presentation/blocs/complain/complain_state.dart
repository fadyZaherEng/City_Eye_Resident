part of 'complain_bloc.dart';

@immutable
abstract class ComplainState extends Equatable {
  @override
  List<Object?> get props => [
    identityHashCode(this),
  ];
}

class ComplainInitialState extends ComplainState {}

class ComplainLoadingState extends ComplainState {}

class ComplainSubmitSuccessState extends ComplainState {
  final String message;

  ComplainSubmitSuccessState({
    required this.message,
  });
}

class ComplainSubmitErrorState extends ComplainState {
  final String errorMessage;

  ComplainSubmitErrorState({
    required this.errorMessage,
  });
}

class DescribeProblemValidState extends ComplainState {}

class DescribeProblemInvalidState extends ComplainState {}

class NavigateBackState extends ComplainState {}

class ShowVideoSkeletonState extends ComplainState {}

class OpenMediaBottomSheetState extends ComplainState {
  final MediaType mediaType;

  OpenMediaBottomSheetState({
    required this.mediaType,
  });
}

class AddImageState extends ComplainState {
  final File image;

  AddImageState({
    required this.image,
  });
}

class AddMultipleImageState extends ComplainState {
  final List<File> images;

  AddMultipleImageState({
    required this.images,
  });
}

class NoImageSelectedState extends ComplainState {
  final String message;

  NoImageSelectedState({
    required this.message,
  });
}

class AddVideoState extends ComplainState {
  final File video;
  final ImageSource imageSource;

  AddVideoState({
    required this.video,
    required this.imageSource,
  });
}

class NoVideoSelectedState extends ComplainState {
  final String message;

  NoVideoSelectedState({
    required this.message,
  });
}

class NavigateToVideoTrimmerScreenState extends ComplainState {
  final File video;
  final int maxDuration;

  NavigateToVideoTrimmerScreenState({
    required this.video,
    required this.maxDuration,
  });
}

class RemoveVideoState extends ComplainState {}

class RemoveImageState extends ComplainState {
  final List<File> images;
  final int index;

  RemoveImageState({
    required this.images,
    required this.index,
  });
}

class GetCompoundConfigurationState extends ComplainState {
  final CompoundConfiguration compoundConfiguration;

  GetCompoundConfigurationState({
    required this.compoundConfiguration,
  });
}

class InitializeRecorderState extends ComplainState {}

class StartRecordingState extends ComplainState {}

class StopRecordingState extends ComplainState {}

class SaveAudioPathState extends ComplainState {
  final String audioPath;

  SaveAudioPathState({
    required this.audioPath,
  });
}

class RemoveAudioFileState extends ComplainState {
  final String audioPath;
  final bool isReplace;

  RemoveAudioFileState({
    required this.audioPath,
    required this.isReplace,
  });
}

class AudioStatusChangeState extends ComplainState {
  final bool isRecording;
  final int duration;

  AudioStatusChangeState({
    required this.isRecording,
    required this.duration,
  });
}