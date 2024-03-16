import 'dart:async';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/routes/routes_manager.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/base/widget/base_stateful_widget.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/show_massage_dialog_widget.dart';
import 'package:city_eye/src/di/data_layer_injector.dart';
import 'package:city_eye/src/domain/entities/wall/images_screen.dart';
import 'package:city_eye/src/domain/entities/wall/wall.dart';
import 'package:city_eye/src/domain/entities/wall/wall_attachment.dart';
import 'package:city_eye/src/domain/usecase/set_wall_item_id_use_case.dart';
import 'package:city_eye/src/presentation/blocs/wall/wall_bloc.dart';
import 'package:city_eye/src/presentation/screens/wall/skeleton/wall_skeleton_screen.dart';
import 'package:city_eye/src/presentation/screens/wall/widget/wall_content_widget.dart';
import 'package:city_eye/src/presentation/widgets/custom_empty_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WallScreen extends BaseStatefulWidget {
  const WallScreen({Key? key}) : super(key: key);

  @override
  BaseState<BaseStatefulWidget> baseCreateState() => _WallScreenState();
}

class _WallScreenState extends BaseState<WallScreen> {
  WallBloc get _bloc => BlocProvider.of<WallBloc>(
        context,
      );

  List<Wall> _walls = [];

  Color borderColor = ColorSchemes.primary;
  Timer? _timer;

  @override
  void initState() {
    _bloc.add(GetWallEvent(isRefresh: false));
    super.initState();
  }

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<WallBloc, WallState>(
      listener: (context, state) {
        if (state is GetWallSuccessState) {
          _onGetWallSuccessState(
            walls: state.walls,
          );
        } else if (state is GetWallErrorState) {
          _onGetWallErrorState(
            errorMessage: state.errorMessage,
          );
        } else if (state is NavigateToWallPictureScreenState) {
          _onNavigateToWallPictureScreenState(
            images: state.images,
            initialIndex: state.initialIndex,
          );
        } else if (state is ScrollToItemState) {
          _scrollToIndex(state.key);
          getColor();
        }
      },
      builder: (context, state) {
        if (state is GetWallSkeletonState) {
          return const WallSkeletonScreen();
        } else if (state is EmptyWallState) {
          return CustomEmptyListWidget(
            text: S.of(context).noPostsFound,
            imagePath: ImagePaths.wallEmpty,
            onRefresh: () {
              _handleRefresh();
            },
          );
        }
        return _buildScreen();
      },
    );
  }

  Widget _buildScreen() {
    return WallContentWidget(
      walls: _walls,
      borderColor: borderColor,
      onTapImage: ({
        required int imageIndex,
        required List<WallAttachment> images,
      }) {
        _bloc.add(NavigateToWallPictureScreenEvent(
          pictureId: imageIndex,
          wallImages: images,
        ));
      },
      onPullToRefresh: () {
        _handleRefresh();
      },
      onScrollToItem: (key) {
        _bloc.add(ScrollToItemEvent(key: key));
      },
    );
  }

  Future<void> _handleRefresh() async {
    _bloc.add(GetWallEvent(isRefresh: true));
  }

  void _onGetWallSuccessState({
    required List<Wall> walls,
  }) {
    _walls = walls;
  }

  void _onGetWallErrorState({
    required String errorMessage,
  }) {
    showMassageDialogWidget(
      context: context,
      text: errorMessage,
      icon: ImagePaths.error,
      buttonText: S.of(context).ok,
      onTap: () {
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );
  }

  void _onNavigateToWallPictureScreenState({
    required List<WallAttachment> images,
    required int initialIndex,
  }) {
    Navigator.pushNamed(context, Routes.wallImages,
        arguments: ImagesScreen(
          initialIndex: initialIndex,
          images: images,
        ));
  }

  Future<void> _scrollToIndex(GlobalKey key) async {
    Future.delayed(const Duration(milliseconds: 300));
    Scrollable.ensureVisible(
      key.currentContext ?? context,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );

    await SetWallItemIdUseCase(injector())(0);
  }

  getColor() {
    _timer = Timer(const Duration(seconds: 2), () {
      borderColor = ColorSchemes.cardSelected;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

}
