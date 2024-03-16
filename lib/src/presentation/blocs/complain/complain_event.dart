part of 'complain_bloc.dart';

@immutable
abstract class ComplainEvent extends Equatable {
  @override
  List<Object?> get props => [
    identityHashCode(this),
  ];
}


class DescribeProblemValidationEvent extends ComplainEvent {
  final String value;
  final int max;
  final int min;

  DescribeProblemValidationEvent({
    required this.value,
    required this.max,
    required this.min,
  });
}

class NavigateBackEvent extends ComplainEvent {}

class OpenMediaBottomSheetEvent extends ComplainEvent {
  final MediaType mediaType;

  OpenMediaBottomSheetEvent({
    required this.mediaType,
  });
}

class AddImageEvent extends ComplainEvent {
  final XFile? image;

  AddImageEvent({
    required this.image,
  });
}

class AddMultipleImagesEvent extends ComplainEvent {
  final List<XFile?> images;

  AddMultipleImagesEvent({
    required this.images,
  });
}

class AddVideoEvent extends ComplainEvent {
  final XFile? video;
  final ImageSource imageSource;

  AddVideoEvent({
    required this.video,
    required this.imageSource,
  });
}

class NavigateToVideoTrimmerScreenEvent extends ComplainEvent {
  final File video;
  final int maxDuration;

  NavigateToVideoTrimmerScreenEvent({
    required this.video,
    required this.maxDuration,
  });
}

class RemoveVideoEvent extends ComplainEvent {}

class RemoveImageEvent extends ComplainEvent {
  final List<File> images;
  final int index;

  RemoveImageEvent({
    required this.images,
    required this.index,
  });
}


class SubmitRequestEvent extends ComplainEvent {
  final String description;
  final List<File> images;
  final String audioPath;
  final String videoFile;
  final int min;

  SubmitRequestEvent({
    required this.description,
    required this.images,
    required this.audioPath,
    required this.videoFile,
    required this.min,
  });
}

class GetCompoundConfigurationEvent extends ComplainEvent {}

class InitializeRecorderEvent extends ComplainEvent {}

class StartRecordingEvent extends ComplainEvent {}

class StopRecordingEvent extends ComplainEvent {}

class SaveAudioPathEvent extends ComplainEvent {
  final String audioPath;

  SaveAudioPathEvent({
    required this.audioPath,
  });
}

class RemoveAudioFileEvent extends ComplainEvent {
  final String audioPath;
  final bool isReplace;

  RemoveAudioFileEvent({
    this.audioPath = "",
    this.isReplace = false,
  });
}

class AudioStatusChangeEvent extends ComplainEvent {
  final bool isRecording;
  final int duration;

  AudioStatusChangeEvent({
    required this.isRecording,
    required this.duration,
  });
}