part of 'support_details_bloc.dart';

abstract class SupportDetailsEvent extends Equatable {
  const SupportDetailsEvent();

  @override
  List<Object?> get props => [identityHashCode(this)];
}

class SelectSupportServiceEvent extends SupportDetailsEvent {
  final HomeSupport supportService;

  const SelectSupportServiceEvent({
    required this.supportService,
  });
}

class ScrollToSupportServiceEvent extends SupportDetailsEvent {
  final List<HomeSupport> supportServices;
  final HomeSupport supportService;

  const ScrollToSupportServiceEvent({
    required this.supportServices,
    required this.supportService,
  });
}

class SelectPreparedVisitTimeEvent extends SupportDetailsEvent {
  final List<DayTimes> preparedVisitTimes;
  final DayTimes selectedPreparedVisitTime;

  const SelectPreparedVisitTimeEvent({
    required this.preparedVisitTimes,
    required this.selectedPreparedVisitTime,
  });
}

class DescribeRequestValidationEvent extends SupportDetailsEvent {
  final String value;
  final int min;

  const DescribeRequestValidationEvent({
    required this.value,
    required this.min,
  });
}

class OpenMediaBottomSheetEvent extends SupportDetailsEvent {
  final MediaType mediaType;

  const OpenMediaBottomSheetEvent({
    required this.mediaType,
  });
}

class AddImageEvent extends SupportDetailsEvent {
  final XFile? image;

  const AddImageEvent({
    required this.image,
  });
}

class AddMultipleImagesEvent extends SupportDetailsEvent {
  final List<XFile?> images;

  const AddMultipleImagesEvent({
    required this.images,
  });
}

class RemoveImageEvent extends SupportDetailsEvent {
  final List<File> images;
  final int index;

  const RemoveImageEvent({
    required this.images,
    required this.index,
  });
}

class AddVideoEvent extends SupportDetailsEvent {
  final XFile? video;
  final ImageSource imageSource;

  const AddVideoEvent({
    required this.video,
    required this.imageSource,
  });
}

class RemoveVideoEvent extends SupportDetailsEvent {}

class SelectPreparedTimeVisitDateEvent extends SupportDetailsEvent {
  final DateTime selectedDate;

  const SelectPreparedTimeVisitDateEvent({
    required this.selectedDate,
  });
}

class NavigateToVideoTrimmerScreenEvent extends SupportDetailsEvent {
  final File video;
  final int maxDuration;

  const NavigateToVideoTrimmerScreenEvent({
    required this.video,
    required this.maxDuration,
  });
}

class ChangeRecordingEvent extends SupportDetailsEvent {
  ChangeRecordingEvent();
}

class ResetAllValuesEvent extends SupportDetailsEvent {}

class SendSupportRequestEvent extends SupportDetailsEvent {
  final SupportMultiMediaRequest supportMultiMediaRequest;
  final SubmitSupportRequest submitSupportRequest;

  const SendSupportRequestEvent({
    required this.supportMultiMediaRequest,
    required this.submitSupportRequest,
  });

  @override
  String toString() {
    return 'SendSupportRequestEvent{supportMultiMediaRequest: $supportMultiMediaRequest, submitSupportRequest: $submitSupportRequest}';
  }
}

class NavigateBackEvent extends SupportDetailsEvent {}

final class GetSupportDetailsDateEvent extends SupportDetailsEvent {
  final String date;
  final int categoryId;

  const GetSupportDetailsDateEvent({
    required this.date,
    required this.categoryId,
  });

  @override
  List<Object> get props => [date, categoryId];
}

final class GetSupportCompoundMultiMediaConfigurationEvent
    extends SupportDetailsEvent {}

final class GetSupportMultiMediaEvent extends SupportDetailsEvent {
  final MultiMediaConfiguration multiMediaConfiguration;

  const GetSupportMultiMediaEvent({
    required this.multiMediaConfiguration,
  });
}

class InitializeRecorderEvent extends SupportDetailsEvent {}

class StartRecordingEvent extends SupportDetailsEvent {}

class StopRecordingEvent extends SupportDetailsEvent {}

class SaveAudioPathEvent extends SupportDetailsEvent {
  final String audioPath;

  const SaveAudioPathEvent({
    required this.audioPath,
  });
}

class RemoveAudioFileEvent extends SupportDetailsEvent {
  final String audioPath;
  final bool isReplace;

  const RemoveAudioFileEvent({
    this.audioPath = "",
    this.isReplace = false,
  });
}

class AudioStatusChangeEvent extends SupportDetailsEvent {
  final bool isRecording;
  final int duration;

  const AudioStatusChangeEvent({
    required this.isRecording,
    required this.duration,
  });
}
