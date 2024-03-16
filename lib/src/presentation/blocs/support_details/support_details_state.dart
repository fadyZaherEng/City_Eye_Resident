part of 'support_details_bloc.dart';

abstract class SupportDetailsState extends Equatable {
  const SupportDetailsState();

  @override
  List<Object?> get props => [identityHashCode(this)];
}

class SupportDetailsInitial extends SupportDetailsState {}

class SelectSupportServiceState extends SupportDetailsState {
  final HomeSupport supportService;

  const SelectSupportServiceState({
    required this.supportService,
  });
}

class ScrollToSupportServiceState extends SupportDetailsState {
  final int selectedSupportServiceIndex;

  const ScrollToSupportServiceState({
    required this.selectedSupportServiceIndex,
  });
}

class SelectPreparedTimeVisitState extends SupportDetailsState {
  final List<DayTimes> preparedVisitTimes;
  final DayTimes selectedPreparedVisitTime;

  const SelectPreparedTimeVisitState({
    required this.preparedVisitTimes,
    required this.selectedPreparedVisitTime,
  });
}

class DescribeRequestValidState extends SupportDetailsState {
  const DescribeRequestValidState();
}

class DescribeRequestInvalidState extends SupportDetailsState {
  const DescribeRequestInvalidState();
}

class OpenMediaBottomSheetState extends SupportDetailsState {
  final MediaType mediaType;

  const OpenMediaBottomSheetState({
    required this.mediaType,
  });
}

class AddImageState extends SupportDetailsState {
  final File image;

  const AddImageState({
    required this.image,
  });
}

class AddMultipleImageState extends SupportDetailsState {
  final List<File> images;

  const AddMultipleImageState({
    required this.images,
  });
}

class NoImageSelectedState extends SupportDetailsState {
  final String message;

  const NoImageSelectedState({
    required this.message,
  });
}

class RemoveImageState extends SupportDetailsState {
  final List<File> images;
  final int index;

  const RemoveImageState({
    required this.images,
    required this.index,
  });
}

class ShowVideoSkeletonState extends SupportDetailsState {}

class AddVideoState extends SupportDetailsState {
  final File video;
  final ImageSource imageSource;

  const AddVideoState({
    required this.video,
    required this.imageSource,
  });
}

class NoVideoSelectedState extends SupportDetailsState {
  final String message;

  const NoVideoSelectedState({
    required this.message,
  });
}

class RemoveVideoState extends SupportDetailsState {}

class SelectPreparedTimeVisitDateState extends SupportDetailsState {
  final DateTime selectedDate;

  const SelectPreparedTimeVisitDateState({
    required this.selectedDate,
  });
}

class NavigateToVideoTrimmerScreenState extends SupportDetailsState {
  final File video;
  final int maxDuration;

  const NavigateToVideoTrimmerScreenState({
    required this.video,
    required this.maxDuration,
  });
}

class ChangeRecordingState extends SupportDetailsState {
  ChangeRecordingState();
}

class ResetAllValuesState extends SupportDetailsState {}

class NavigateBackState extends SupportDetailsState {}

class SendSupportRequestState extends SupportDetailsState {}

final class ShowLoadingState extends SupportDetailsState {}

final class HideLoadingState extends SupportDetailsState {}

final class SuccessGetSupportDetailsDateState extends SupportDetailsState {
  final SupportDetailsDate supportDetailsDate;

  const SuccessGetSupportDetailsDateState({
    required this.supportDetailsDate,
  });

  @override
  List<Object> get props => [supportDetailsDate];
}

final class ErrorGetSupportDetailsDateState extends SupportDetailsState {
  final String message;

  const ErrorGetSupportDetailsDateState({
    required this.message,
  });
}

final class SuccessGetSupportMultiMediaConfigurationState
    extends SupportDetailsState {
  final MultiMediaConfiguration supportMultiMediaConfiguration;

  const SuccessGetSupportMultiMediaConfigurationState({
    required this.supportMultiMediaConfiguration,
  });
}

final class ErrorGetSupportMultiMediaConfigurationStateState
    extends SupportDetailsState {}

final class GetSupportMultiMediaState extends SupportDetailsState {
  final CompoundMultiMediaConfiguration imageMultiMediaConfiguration;
  final CompoundMultiMediaConfiguration audioMultiMediaConfiguration;
  final CompoundMultiMediaConfiguration videoMultiMediaConfiguration;
  final CompoundMultiMediaConfiguration textMultiMediaConfiguration;

  const GetSupportMultiMediaState({
    required this.imageMultiMediaConfiguration,
    required this.audioMultiMediaConfiguration,
    required this.videoMultiMediaConfiguration,
    required this.textMultiMediaConfiguration,
  });

  @override
  List<Object> get props => [
        imageMultiMediaConfiguration,
        audioMultiMediaConfiguration,
        videoMultiMediaConfiguration,
        textMultiMediaConfiguration,
      ];
}

final class SuccessSubmitSupportRequestState extends SupportDetailsState {
  final SubmitSupport submitSupport;
  final String message;

  const SuccessSubmitSupportRequestState({
    required this.submitSupport,
    required this.message,
  });

  @override
  List<Object> get props => [submitSupport];
}

final class FailedSubmitSupportRequestState extends SupportDetailsState {
  final String message;

  const FailedSubmitSupportRequestState({
    required this.message,
  });
}

class ShowPreparedTimeVisitSkeletonState extends SupportDetailsState {}

class HidePreparedTimeVisitSkeletonState extends SupportDetailsState {}

class InitializeRecorderState extends SupportDetailsState {}

class StartRecordingState extends SupportDetailsState {}

class StopRecordingState extends SupportDetailsState {}

class SaveAudioPathState extends SupportDetailsState {
  final String audioPath;

  const SaveAudioPathState({
    required this.audioPath,
  });
}

class RemoveAudioFileState extends SupportDetailsState {
  final String audioPath;
  final bool isReplace;

  const RemoveAudioFileState({
    required this.audioPath,
    required this.isReplace,
  });
}

class AudioStatusChangeState extends SupportDetailsState {
  final bool isRecording;
  final int duration;

  const AudioStatusChangeState({
    required this.isRecording,
    required this.duration,
  });
}
