part of 'comments_bloc.dart';

abstract class CommentsState extends Equatable {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class CommentsInitial extends CommentsState {}

class ShowLoadingState extends CommentsState {}

class HideLoadingState extends CommentsState {}

class ShowSkeletonState extends CommentsState {}

class GetCommentsSuccessState extends CommentsState {
  final List<Comments> comments;

  GetCommentsSuccessState({
    required this.comments,
  });
}

class GetCommentsErrorState extends CommentsState {
  final String errorMessage;

  GetCommentsErrorState({
    required this.errorMessage,
  });
}

class SendCommentSuccessState extends CommentsState {
  final List<Comments> comments;

  SendCommentSuccessState({
    required this.comments,
  });
}

class SendCommentErrorState extends CommentsState {
  final String errorMessage;

  SendCommentErrorState({
    required this.errorMessage,
  });
}

class OpenMediaBottomSheetState extends CommentsState {}

class AskForCameraPermissionState extends CommentsState {
  final Function() onTab;
  final bool isGallery;

  AskForCameraPermissionState({
    required this.onTab,
    required this.isGallery,
  });
}

class OpenCameraState extends CommentsState {}

class OpenGalleryState extends CommentsState {}

class NavigateBackState extends CommentsState {}

class ScrollToLastIndexState extends CommentsState {}
