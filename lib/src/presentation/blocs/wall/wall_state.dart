part of 'wall_bloc.dart';

@immutable
abstract class WallState extends Equatable {
  @override
  List<Object?> get props => [
        identityHashCode(this),
      ];
}

class WallInitialState extends WallState {}

class GetWallSkeletonState extends WallState {}

class EmptyWallState extends WallState {}

class GetWallSuccessState extends WallState {
  final List<Wall> walls;

  GetWallSuccessState({
    required this.walls,
  });
}

class GetWallErrorState extends WallState {
  final String errorMessage;

  GetWallErrorState({
    required this.errorMessage,
  });
}

class NavigateToWallPictureScreenState extends WallState {
  final int initialIndex;
  final List<WallAttachment> images;

  NavigateToWallPictureScreenState({
    required this.initialIndex,
    required this.images,
  });
}


class ScrollToItemState extends WallState {
  final GlobalKey key;

  ScrollToItemState({required this.key});
}
