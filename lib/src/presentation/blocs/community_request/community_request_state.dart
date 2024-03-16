part of 'community_request_bloc.dart';

@immutable
abstract class CommunityRequestState extends Equatable {
  @override
  List<Object?> get props => [
        identityHashCode(this),
      ];
}

class CommunityRequestInitialState extends CommunityRequestState {}

class ShowVideoSkeletonState extends CommunityRequestState {}

class ShowSkeletonState extends CommunityRequestState {}

class GetCompoundConfigurationState extends CommunityRequestState {
  final CompoundConfiguration configuration;

  GetCompoundConfigurationState({
    required this.configuration,
  });
}

class CommunityRequestLoadingState extends CommunityRequestState {}

class CommunityRequestSuccessState extends CommunityRequestState {
  final String message;

  CommunityRequestSuccessState({
    required this.message,
  });
}

class CommunityRequestErrorState extends CommunityRequestState {
  final String errorMessage;

  CommunityRequestErrorState({
    required this.errorMessage,
  });
}

class CommunityBackState extends CommunityRequestState {}

class CommunityDescribeRequestValidState extends CommunityRequestState {}

class CommunityDescribeRequestInvalidState extends CommunityRequestState {}

class CommunityOpenMediaBottomSheetState extends CommunityRequestState {
  final MediaType mediaType;
  final PageField question;

  CommunityOpenMediaBottomSheetState({
    required this.mediaType,
    required this.question,
  });
}

class CommunityAddImageState extends CommunityRequestState {
  final File image;

  CommunityAddImageState({
    required this.image,
  });
}

class CommunityAddMultipleImageState extends CommunityRequestState {
  final List<File> images;

  CommunityAddMultipleImageState({
    required this.images,
  });
}

class CommunityNoImageSelectedState extends CommunityRequestState {
  final String message;

  CommunityNoImageSelectedState({
    required this.message,
  });
}

class CommunityAddVideoState extends CommunityRequestState {
  final File video;
  final ImageSource imageSource;

  CommunityAddVideoState({
    required this.video,
    required this.imageSource,
  });
}

class CommunityNoVideoSelectedState extends CommunityRequestState {
  final String message;

  CommunityNoVideoSelectedState({
    required this.message,
  });
}

class NavigateToVideoTrimmerScreenState extends CommunityRequestState {
  final File video;
  final int maxDuration;

  NavigateToVideoTrimmerScreenState({
    required this.video,
    required this.maxDuration,
  });
}

class CommunityRemoveVideoState extends CommunityRequestState {}

class CommunityRemoveImageState extends CommunityRequestState {
  final List<File> images;
  final int index;

  CommunityRemoveImageState({
    required this.images,
    required this.index,
  });
}

class CommunityChangeRecordingState extends CommunityRequestState {}

class GetQuestionsSuccessState extends CommunityRequestState {
  final List<PageField> questions;

  GetQuestionsSuccessState({
    required this.questions,
  });
}

class GetQuestionsErrorState extends CommunityRequestState {
  final String errorMessage;

  GetQuestionsErrorState({
    required this.errorMessage,
  });
}

class UpdateMapQuestionToWidgetState extends CommunityRequestState {
  final List<PageField> questions;

  UpdateMapQuestionToWidgetState({
    required this.questions,
  });
}

class ShowDialogToDeleteQuestionAnswerState extends CommunityRequestState {
  final PageField question;

  ShowDialogToDeleteQuestionAnswerState({
    required this.question,
  });
}

class DynamicMediaBottomSheetState extends CommunityRequestState {
  final MediaType mediaType;
  final PageField question;

  DynamicMediaBottomSheetState({
    required this.mediaType,
    required this.question,
  });
}

class ScrollToUnAnsweredMandatoryQuestionState extends CommunityRequestState {
  final GlobalKey key;

  ScrollToUnAnsweredMandatoryQuestionState({
    required this.key,
  });
}

class ShowQrSearchableBottomSheetState extends CommunityRequestState {
  final PageField question;
  final bool isMultiChoice;

  ShowQrSearchableBottomSheetState({
    required this.question,
    required this.isMultiChoice,
  });
}

class UpdateSearchableSingleQuestionState extends CommunityRequestState {
  final PageField question;
  final Choice answer;

  UpdateSearchableSingleQuestionState(
      {required this.question, required this.answer});
}

class UpdateSearchableMultiQuestionState extends CommunityRequestState {
  final PageField question;
  final List<Choice> answer;

  UpdateSearchableMultiQuestionState(
      {required this.question, required this.answer});
}

class InitializeRecorderState extends CommunityRequestState {}

class StartRecordingState extends CommunityRequestState {}

class StopRecordingState extends CommunityRequestState {}

class SaveAudioPathState extends CommunityRequestState {
  final String audioPath;

  SaveAudioPathState({
    required this.audioPath,
  });
}

class RemoveAudioFileState extends CommunityRequestState {
  final String audioPath;
  final bool isReplace;

  RemoveAudioFileState({
    required this.audioPath,
    required this.isReplace,
  });
}

class AudioStatusChangeState extends CommunityRequestState {
  final bool isRecording;
  final int duration;

  AudioStatusChangeState({
    required this.isRecording,
    required this.duration,
  });
}
