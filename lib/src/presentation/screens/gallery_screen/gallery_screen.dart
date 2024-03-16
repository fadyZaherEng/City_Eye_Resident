import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/routes/routes_manager.dart';
import 'package:city_eye/src/core/base/widget/base_stateful_widget.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/show_massage_dialog_widget.dart';
import 'package:city_eye/src/domain/entities/gallery/gallery.dart';
import 'package:city_eye/src/domain/entities/gallery/gallery_attachment.dart';
import 'package:city_eye/src/domain/entities/gallery/images_screen.dart';
import 'package:city_eye/src/presentation/blocs/gallery/gallery_bloc.dart';
import 'package:city_eye/src/presentation/screens/gallery_screen/skeleton/gallery_skeleton_screen.dart';
import 'package:city_eye/src/presentation/screens/gallery_screen/widgets/gallery_content_widget.dart';
import 'package:city_eye/src/presentation/widgets/empty_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GalleryScreen extends BaseStatefulWidget {
  const GalleryScreen({
    super.key,
  });

  @override
  BaseState<BaseStatefulWidget> baseCreateState() => _GalleryScreenState();
}

class _GalleryScreenState extends BaseState<GalleryScreen> {
  GalleryBloc get _bloc => BlocProvider.of<GalleryBloc>(context);

  List<Gallery> _gallery = [];

  @override
  void initState() {
    _bloc.add(GetGalleryEvent(isRefresh: false));
    super.initState();
  }

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<GalleryBloc, GalleryState>(listener: (context, state) {
      if (state is GetGallerySuccessState) {
        _gallery = state.gallery;
      } else if (state is GetGalleryErrorState) {
        _onGetGalleryErrorState(
          errorMessage: state.errorMessage,
          icon: ImagePaths.error,
        );
      } else if (state is NavigateToGalleryPictureScreenState) {
        _onNavigateToGalleryPictureScreenState(
          images: state.images,
          initialIndex: state.initialIndex,
        );
      } else if (state is NavigationPopState) {
        _onNavigationPopState();
      }
    }, builder: (context, state) {
      if (state is GetGallerySkeletonState) {
        return const GallerySkeletonScreen();
      }
      return _gallery.isNotEmpty ? _buildScreen() : _buildEmptyScreen();
    });
  }

  Future<void> _handleRefresh() async {
    _bloc.add(GetGalleryEvent(isRefresh: true));
  }

  Widget _buildScreen() {
    return GalleryContentWidget(
      onBackButtonPressed: () {
        _bloc.add(NavigationPopEvent());
      },
      gallery: _gallery,
      onTapImage: ({
        required int imageIndex,
        required List<GalleryAttachment> images,
      }) {
        _bloc.add(NavigateToGalleryPictureScreenEvent(
          pictureId: imageIndex,
          galleryImages: images,
        ));
      },
      onPullToRefresh: () {
        _handleRefresh();
      },
    );
  }

  Widget _buildEmptyScreen() {
    return EmptyScreen(
      title: S.of(context).gallery,
      isHaveBackButton: true,
      emptyMessage: S.of(context).sorryImagesFound,
      assetName: ImagePaths.emptyGallery,
      onBackButtonPressed: () {
        _bloc.add(NavigationPopEvent());
      },
      onRefresh: () {
        _handleRefresh();
      },
    );
  }

  void _onGetGalleryErrorState({
    required String errorMessage,
    required String icon,
  }) {
    showMassageDialogWidget(
        context: context,
        text: errorMessage,
        icon: icon,
        buttonText: S.of(context).ok,
        onTap: () {
          _bloc.add(NavigationPopEvent());
        });
  }

  void _onNavigateToGalleryPictureScreenState({
    required List<GalleryAttachment> images,
    required int initialIndex,
  }) {
    Navigator.pushNamed(context, Routes.galleryImages,
        arguments: GalleryImages(
          initialIndex: initialIndex,
          images: images,
        ));
  }

  void _onNavigationPopState() => Navigator.pop(context);
}
