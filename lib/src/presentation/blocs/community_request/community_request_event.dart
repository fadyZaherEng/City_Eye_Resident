part of 'community_request_bloc.dart';

@immutable
abstract class CommunityRequestEvent extends Equatable {
  @override
  List<Object?> get props => [
        identityHashCode(this),
      ];
}

class CommunityNavigationBackEvent extends CommunityRequestEvent {}

class GetCompoundConfigurationEvent extends CommunityRequestEvent {}

class CommunitySendRequestEvent extends CommunityRequestEvent {
  final String description;
  final List<File> images;
  final String audioPath;
  final String videoFile;
  final List<PageField> questions;
  final int minLength;

  CommunitySendRequestEvent({
    required this.description,
    required this.images,
    required this.audioPath,
    required this.videoFile,
    required this.questions,
    required this.minLength,
  });
}

class DescribeRequestValidationEvent extends CommunityRequestEvent {
  final String value;
  final int min;

  DescribeRequestValidationEvent({
    required this.value,
    required this.min,
  });
}

class CommunityAddImageEvent extends CommunityRequestEvent {
  final XFile? image;

  CommunityAddImageEvent({
    required this.image,
  });
}

class CommunityAddMultipleImagesEvent extends CommunityRequestEvent {
  final List<XFile?> images;

  CommunityAddMultipleImagesEvent({
    required this.images,
  });
}

class CommunityAddVideoEvent extends CommunityRequestEvent {
  final XFile? video;
  final ImageSource imageSource;

  CommunityAddVideoEvent({
    required this.video,
    required this.imageSource,
  });
}

class NavigateToVideoTrimmerScreenEvent extends CommunityRequestEvent {
  final File video;
  final int maxDuration;

  NavigateToVideoTrimmerScreenEvent({
    required this.video,
    required this.maxDuration,
  });
}

class CommunityChangeRecordingEvent extends CommunityRequestEvent {}

class CommunityRemoveVideoEvent extends CommunityRequestEvent {}

class CommunityRemoveImageEvent extends CommunityRequestEvent {
  final List<File> images;
  final int index;

  CommunityRemoveImageEvent({
    required this.images,
    required this.index,
  });
}

class CommunityOpenMediaBottomSheetEvent extends CommunityRequestEvent {
  final MediaType mediaType;
  final PageField question;

  CommunityOpenMediaBottomSheetEvent({
    required this.mediaType,
    required this.question,
  });
}

/// ***************** Dynamic Widgets Events ***************************

class GetQuestionsEvent extends CommunityRequestEvent {}

class SelectSingleSelectionAnswerEvent extends CommunityRequestEvent {
  final PageField question;
  final int answerId;

  SelectSingleSelectionAnswerEvent(
      {required this.question, required this.answerId});
}

class SelectMultiSelectionAnswerEvent extends CommunityRequestEvent {
  final PageField question;
  final int answerId;

  SelectMultiSelectionAnswerEvent(
      {required this.question, required this.answerId});
}

class AddAnswerToQuestionEvent extends CommunityRequestEvent {
  final PageField question;
  final dynamic answer;

  AddAnswerToQuestionEvent({required this.question, required this.answer});
}

class DeleteQuestionAnswerEvent extends CommunityRequestEvent {
  final PageField question;

  DeleteQuestionAnswerEvent({required this.question});
}

class ShowMediaBottomSheetEvent extends CommunityRequestEvent {
  final PageField question;

  ShowMediaBottomSheetEvent({required this.question});
}

class ShowDialogToDeleteQuestionAnswerEvent extends CommunityRequestEvent {
  final PageField question;

  ShowDialogToDeleteQuestionAnswerEvent({required this.question});
}

class AddQuestionImageEvent extends CommunityRequestEvent {
  final PageField question;
  final XFile image;

  AddQuestionImageEvent({
    required this.question,
    required this.image,
  });
}

class ShowQrSearchableBottomSheetEvent extends CommunityRequestEvent {
  final PageField question;
  final bool isMultiChoice;

  ShowQrSearchableBottomSheetEvent({
    required this.question,
    required this.isMultiChoice,
  });
}

class UpdateSearchableSingleQuestionEvent extends CommunityRequestEvent {
  final PageField question;
  final Choice answer;

  UpdateSearchableSingleQuestionEvent(
      {required this.question, required this.answer});
}

class UpdateSearchableMultiQuestionEvent extends CommunityRequestEvent {
  final PageField question;
  final List<Choice> answer;

  UpdateSearchableMultiQuestionEvent(
      {required this.question, required this.answer});
}

class InitializeRecorderEvent extends CommunityRequestEvent {}

class StartRecordingEvent extends CommunityRequestEvent {}

class StopRecordingEvent extends CommunityRequestEvent {}

class SaveAudioPathEvent extends CommunityRequestEvent {
  final String audioPath;

  SaveAudioPathEvent({
    required this.audioPath,
  });
}

class RemoveAudioFileEvent extends CommunityRequestEvent {
  final String audioPath;
  final bool isReplace;

  RemoveAudioFileEvent({
    this.audioPath = "",
    this.isReplace = false,
  });
}

class AudioStatusChangeEvent extends CommunityRequestEvent {
  final bool isRecording;
  final int duration;

  AudioStatusChangeEvent({
    required this.isRecording,
    required this.duration,
  });
}
