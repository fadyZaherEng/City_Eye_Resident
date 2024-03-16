part of 'comments_bloc.dart';

abstract class CommentsEvent extends Equatable {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class GetCommentsEvent extends CommentsEvent {
  final int orderId;
  final bool showLoading;

  GetCommentsEvent({
    required this.orderId,
    required this.showLoading,
  });
}

class MediaIconPressedEvent extends CommentsEvent {}

class AskForCameraPermissionEvent extends CommentsEvent {
  final Function() onTab;
  final bool isGallery;

  AskForCameraPermissionEvent({
    required this.onTab,
    required this.isGallery,
  });
}

class CameraPressedEvent extends CommentsEvent {}

class GalleryPressedEvent extends CommentsEvent {}

class SendPressedEvent extends CommentsEvent {
  final int orderId;
  final String message;
  final bool isImage;
  final String imagePath;

  SendPressedEvent({
    required this.orderId,
    required this.message,
    this.isImage = false,
    this.imagePath = "",
  });
}

class NavigateBackEvent extends CommentsEvent {}

class ScrollToLastIndexEvent extends CommentsEvent {}
