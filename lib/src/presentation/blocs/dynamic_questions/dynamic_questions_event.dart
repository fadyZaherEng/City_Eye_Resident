part of 'dynamic_questions_bloc.dart';

abstract class DynamicQuestionsEvent extends Equatable {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class SelectSingleSelectionAnswerEvent extends DynamicQuestionsEvent {
  final List<PageField> questions;
  final PageField question;
  final int answerId;

  SelectSingleSelectionAnswerEvent({
    required this.questions,
    required this.question,
    required this.answerId,
  });
}

class SelectMultiSelectionAnswerEvent extends DynamicQuestionsEvent {
  final List<PageField> questions;
  final PageField question;
  final int answerId;

  SelectMultiSelectionAnswerEvent({
    required this.questions,
    required this.question,
    required this.answerId,
  });
}

class DeleteQuestionAnswerEvent extends DynamicQuestionsEvent {
  final List<PageField> questions;
  final PageField question;

  DeleteQuestionAnswerEvent({
    required this.questions,
    required this.question,
  });
}

class AddAnswerToQuestionEvent extends DynamicQuestionsEvent {
  final List<PageField> questions;
  final PageField question;
  final dynamic answer;

  AddAnswerToQuestionEvent({
    required this.questions,
    required this.question,
    required this.answer,
  });
}

class SelectQuestionImageEvent extends DynamicQuestionsEvent {
  final List<PageField> questions;
  final PageField question;
  final String imagePath;

  SelectQuestionImageEvent({
    required this.questions,
    required this.question,
    required this.imagePath,
  });
}

class DeleteQuestionImageEvent extends DynamicQuestionsEvent {
  final List<PageField> questions;
  final PageField question;

  DeleteQuestionImageEvent({
    required this.questions,
    required this.question,
  });
}

class OpenMediaBottomSheetEvent extends DynamicQuestionsEvent {
  final List<PageField>? questions;
  final PageField? question;

  OpenMediaBottomSheetEvent({
    this.questions,
    this.question,
  });
}

class CameraPressedEvent extends DynamicQuestionsEvent {
  final List<PageField>? questions;
  final PageField? question;

  CameraPressedEvent({
    this.questions,
    this.question,
  });
}

class GalleryPressedEvent extends DynamicQuestionsEvent {
  final List<PageField>? questions;
  final PageField? question;

  GalleryPressedEvent({
    this.questions,
    this.question,
  });
}


class AskForCameraPermissionEvent extends DynamicQuestionsEvent {
  final Function() onTab;
  final bool isGallery;

  AskForCameraPermissionEvent({
    required this.onTab,
    required this.isGallery,
  });
}

class CheckValidationForAllQuestionEvent extends DynamicQuestionsEvent {
  final List<PageField> questions;

  CheckValidationForAllQuestionEvent({
    required this.questions,
  });
}

class OkButtonPressedEvent extends DynamicQuestionsEvent {
  final List<PageField> questions;

  OkButtonPressedEvent({
    required this.questions,
  });
}

class ScrollToUnAnsweredMandatoryQuestionEvent extends DynamicQuestionsEvent {
  final List<PageField> questions;

  ScrollToUnAnsweredMandatoryQuestionEvent({
    required this.questions,
  });
}

class NavigateBackEvent extends DynamicQuestionsEvent {}
