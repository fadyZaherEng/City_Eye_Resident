part of 'wall_bloc.dart';

@immutable
abstract class WallEvent extends Equatable {
  @override
  List<Object?> get props => [
        identityHashCode(this),
      ];
}

class GetWallEvent extends WallEvent {
  final bool isRefresh;

  GetWallEvent({this.isRefresh = false});
}

class NavigateToWallPictureScreenEvent extends WallEvent {
  final int pictureId;
  final List<WallAttachment> wallImages;

  NavigateToWallPictureScreenEvent({
    required this.pictureId,
    required this.wallImages,
  });
}

class ScrollToItemEvent extends WallEvent {
  final GlobalKey key;

  ScrollToItemEvent({required this.key});
}

