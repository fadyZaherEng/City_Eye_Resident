part of 'dynamic_questions_bloc.dart';

abstract class DynamicQuestionsState extends Equatable {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class DynamicQuestionsInitial extends DynamicQuestionsState {}

class OpenMediaBottomSheetState extends DynamicQuestionsState {
  final List<PageField>? questions;
  final PageField? question;

  OpenMediaBottomSheetState({
    this.questions,
    this.question,
  });
}

class AskForCameraPermissionState extends DynamicQuestionsState {
  final Function() onTab;
  final bool isGallery;

  AskForCameraPermissionState({
    required this.onTab,
    required this.isGallery,
  });
}

class OpenCameraState extends DynamicQuestionsState {
  final List<PageField>? questions;
  final PageField? question;

  OpenCameraState({
    this.questions,
    this.question,
  });
}

class OpenGalleryState extends DynamicQuestionsState {
  final List<PageField>? questions;
  final PageField? question;

  OpenGalleryState({
    this.questions,
    this.question,
  });
}


class UpdateDynamicQuestionState extends DynamicQuestionsState {
  final List<PageField> questions;

  UpdateDynamicQuestionState({
    required this.questions,
  });
}

class AllQuestionAnsweredState extends DynamicQuestionsState {
  final List<PageField> questions;

  AllQuestionAnsweredState({
    required this.questions,
  });
}

class ScrollToUnAnsweredMandatoryQuestionState extends DynamicQuestionsState {
  final GlobalKey key;

  ScrollToUnAnsweredMandatoryQuestionState({
    required this.key,
  });
}

class NavigateBackState extends DynamicQuestionsState {}
