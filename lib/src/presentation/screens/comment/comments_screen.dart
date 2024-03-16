import 'dart:async';
import 'dart:io';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/routes/routes_manager.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/base/widget/base_stateful_widget.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/compress_file.dart';
import 'package:city_eye/src/core/utils/permission_service_handler.dart';
import 'package:city_eye/src/core/utils/show_action_dialog_widget.dart';
import 'package:city_eye/src/core/utils/show_bottom_sheet_upload_media.dart';
import 'package:city_eye/src/core/utils/show_massage_dialog_widget.dart';
import 'package:city_eye/src/domain/entities/gallery/gallery_attachment.dart';
import 'package:city_eye/src/domain/entities/gallery/images_screen.dart';
import 'package:city_eye/src/domain/entities/support/comments.dart';
import 'package:city_eye/src/domain/entities/support/orders.dart';
import 'package:city_eye/src/presentation/blocs/comment/comments_bloc.dart';
import 'package:city_eye/src/presentation/screens/comment/widgets/new_message_widget.dart';
import 'package:city_eye/src/presentation/screens/comment/widgets/skelton_comments_screen.dart';
import 'package:city_eye/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:city_eye/src/presentation/widgets/custom_empty_list_widget.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:skeletons/skeletons.dart';

class CommentsScreen extends BaseStatefulWidget {
  final Orders order;
  final int id;

  const CommentsScreen({
    Key? key,
    required this.order,
    this.id = -1,
  }) : super(key: key);

  @override
  BaseState<CommentsScreen> baseCreateState() => _CommentScreenState();
}

class _CommentScreenState extends BaseState<CommentsScreen> {
  CommentsBloc get _bloc => BlocProvider.of<CommentsBloc>(context);
  ScrollController _scrollController = ScrollController();

  List<Comments> _comments = [];

  int _orderId = 0;

  @override
  void initState() {
    super.initState();
    if (widget.id != -1) {
      _orderId = widget.id;
    } else {
      _orderId = widget.order.id;
    }
    _bloc.add(GetCommentsEvent(
      orderId: _orderId,
      showLoading: true,
    ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(seconds: 1), () {
      _bloc.add(GetCommentsEvent(
        orderId: _orderId,
        showLoading: false,
      ));
    });
  }

  @override
  Widget baseBuild(BuildContext context) {
    const height = 150.0;
    return BlocConsumer<CommentsBloc, CommentsState>(
      listener: (context, state) {
        if (state is ShowLoadingState) {
          showLoading();
        } else if (state is HideLoadingState) {
          hideLoading();
        } else if (state is GetCommentsSuccessState) {
          _comments = state.comments;
          _bloc.add(ScrollToLastIndexEvent());
        } else if (state is ScrollToLastIndexState) {
          if (_comments.isNotEmpty) _scrollToLastIndex();
        } else if (state is GetCommentsErrorState) {
          _showMessageDialog(
            context,
            state.errorMessage,
            ImagePaths.error,
            () {
              _navigateBackEvent();
            },
          );
        } else if (state is OpenMediaBottomSheetState) {
          showBottomSheetUploadMedia(
              context: context,
              onTapGallery: () {
                _navigateBackEvent();
                _askForCameraPermissionEvent(
                  () {
                    _galleryPressedEvent();
                  },
                  true,
                );
              },
              onTapCamera: () {
                _navigateBackEvent();
                _askForCameraPermissionEvent(
                  () {
                    _cameraPressedEvent();
                  },
                  false,
                );
              });
        } else if (state is NavigateBackState) {
          Navigator.pop(context);
        } else if (state is AskForCameraPermissionState) {
          _askForCameraPermission(
            state.onTab,
            state.isGallery,
          );
        } else if (state is OpenCameraState) {
          _getImage(ImageSource.camera);
        } else if (state is OpenGalleryState) {
          _getImage(ImageSource.gallery);
        } else if (state is SendCommentSuccessState) {
          _comments = state.comments;
          _bloc.add(ScrollToLastIndexEvent());
        } else if (state is SendCommentErrorState) {
          _showMessageDialog(
            context,
            state.errorMessage,
            ImagePaths.error,
            () {
              _navigateBackEvent();
            },
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: buildAppBarWidget(
            context,
            title: S.of(context).supportRequest,
            isHaveBackButton: true,
            onBackButtonPressed: () {
              _navigateBackEvent();
            },
          ),
          body: state is ShowSkeletonState
              ? const SkeletonCommentsScreen()
              : Column(
                children: [
                  Expanded(
                    child: CustomRefreshIndicator(
                        trigger: IndicatorTrigger.trailingEdge,
                        trailingScrollIndicatorVisible: false,
                        leadingScrollIndicatorVisible: true,
                        builder: (
                          BuildContext context,
                          Widget child,
                          IndicatorController controller,
                        ) {
                          return AnimatedBuilder(
                              animation: controller,
                              builder: (context, _) {
                                final dy = controller.value.clamp(0.0, 1.25) *
                                    -(height - (height * 0.25));
                                return Stack(
                                  children: [
                                    Transform.translate(
                                      offset: Offset(0.0, dy),
                                      child: child,
                                    ),
                                    Positioned(
                                      bottom: -height,
                                      left: 0,
                                      right: 0,
                                      height: height,
                                      child: Container(
                                        transform:
                                            Matrix4.translationValues(0.0, dy, 0.0),
                                        padding: const EdgeInsets.only(top: 30.0),
                                        constraints: const BoxConstraints.expand(),
                                        child: Column(
                                          children: [
                                            if (!controller.isIdle)
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    bottom: 8.0),
                                                width: 16,
                                                height: 16,
                                                child:
                                                     CircularProgressIndicator(
                                                  color: ColorSchemes.primary,
                                                  strokeWidth: 2,
                                                ),
                                              )
                                            else
                                               Icon(
                                                Icons.keyboard_arrow_up,
                                                color: ColorSchemes.primary,
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              });
                        },
                        onRefresh: () => _handleRefresh(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                          child: Column(
                            children: [
                              _comments.isEmpty
                                  ? Expanded(
                                      child: CustomEmptyListWidget(
                                        text: S.of(context).noMessagesYet,
                                        imagePath: ImagePaths.commentsEmpty,
                                        onRefresh: () {
                                          _bloc.add(GetCommentsEvent(
                                            orderId: _orderId,
                                            showLoading: true,
                                          ));
                                        },
                                      ),
                                    )
                                  : Expanded(
                                      child: ListView.separated(
                                        controller: _scrollController,
                                        physics:
                                            const AlwaysScrollableScrollPhysics(),
                                        separatorBuilder: (context, index) {
                                          return const SizedBox(height: 16);
                                        },
                                        itemCount: _comments.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return SizedBox(
                                            child: Row(
                                              textDirection:
                                                  _isUser(_comments[index].user.id)
                                                      ? TextDirection.ltr
                                                      : TextDirection.rtl,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  crossAxisAlignment: _isUser(
                                                          _comments[index].user.id)
                                                      ? CrossAxisAlignment.start
                                                      : CrossAxisAlignment.end,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        _onTapPreviewImage(_comments[index].user.image);
                                                      },
                                                      child: ClipOval(
                                                        child: Image.network(
                                                          _comments[index].user.image,
                                                          width: 24,
                                                          height: 24,
                                                          fit: BoxFit.cover,
                                                          loadingBuilder: (context,
                                                              child, loadingProgress) {
                                                            if (loadingProgress ==
                                                                null) {
                                                              return child;
                                                            }
                                                            return SkeletonLine(
                                                              style: SkeletonLineStyle(
                                                                width: 24,
                                                                height: 24,
                                                                borderRadius: BorderRadius
                                                                    .circular(
                                                                        12),
                                                              ),
                                                            );
                                                          },
                                                          errorBuilder: (context, error,
                                                              stackTrace) {
                                                            return Center(
                                                              child: Image.asset(
                                                                ImagePaths.avatarImage,
                                                                width: 24,
                                                                height: 24,
                                                                fit: BoxFit.cover,
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Text(
                                                      _comments[index].user.name,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium
                                                          ?.copyWith(
                                                            color: ColorSchemes.black,
                                                            letterSpacing: -0.13,
                                                          ),
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(width: 32),
                                                !_comments[index].isImage
                                                    ? Expanded(
                                                        child: Container(
                                                          padding: const EdgeInsets
                                                              .symmetric(
                                                            horizontal: 16,
                                                            vertical: 12,
                                                          ),
                                                          decoration: BoxDecoration(
                                                            color: _isUser(
                                                                    _comments[index]
                                                                        .user
                                                                        .id)
                                                                ? ColorSchemes.primary
                                                                : ColorSchemes
                                                                    .commentBackground,
                                                            borderRadius: BorderRadiusDirectional.only(
                                                                topStart: const Radius
                                                                    .circular(0),
                                                                bottomEnd: _isUser(
                                                                        _comments[index]
                                                                            .user
                                                                            .id)
                                                                    ? const Radius
                                                                        .circular(25)
                                                                    : const Radius
                                                                        .circular(0),
                                                                bottomStart: _isUser(
                                                                        _comments[index]
                                                                            .user
                                                                            .id)
                                                                    ? const Radius.circular(25)
                                                                    : const Radius.circular(0),
                                                                topEnd: const Radius.circular(25)),
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                  _comments[index]
                                                                      .message,
                                                                  style:
                                                                      Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodySmall
                                                                          ?.copyWith(
                                                                            color: _isUser(_comments[index]
                                                                                    .user
                                                                                    .id)
                                                                                ? ColorSchemes
                                                                                    .white
                                                                                : ColorSchemes
                                                                                    .blackGrey,
                                                                            letterSpacing:
                                                                                -0.13,
                                                                          ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    : InkWell(
                                                        onTap: () {
                                                          _onTapPreviewImage(_comments[index].message);
                                                        },
                                                      child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadiusDirectional
                                                                  .only(
                                                            topStart:
                                                                const Radius.circular(
                                                                    0),
                                                            bottomStart:
                                                                const Radius.circular(
                                                                    0),
                                                            bottomEnd: _isUser(
                                                                    _comments[index]
                                                                        .user
                                                                        .id)
                                                                ? const Radius.circular(
                                                                    25)
                                                                : const Radius.circular(
                                                                    0),
                                                            topEnd:
                                                                const Radius.circular(
                                                                    0),
                                                          ),
                                                          child: Image.network(
                                                            _comments[index].message,
                                                            width: 150,
                                                            height: 100,
                                                            fit: BoxFit.cover,
                                                            errorBuilder: (context,
                                                                error, stackTrace) {
                                                              return ClipRRect(
                                                                borderRadius:
                                                                    BorderRadiusDirectional
                                                                        .only(
                                                                  topStart: const Radius
                                                                      .circular(0),
                                                                  bottomStart:
                                                                      const Radius
                                                                          .circular(0),
                                                                  bottomEnd: _isUser(
                                                                          _comments[
                                                                                  index]
                                                                              .user
                                                                              .id)
                                                                      ? const Radius
                                                                          .circular(25)
                                                                      : const Radius
                                                                          .circular(0),
                                                                  topEnd: const Radius
                                                                      .circular(0),
                                                                ),
                                                                child: Image.asset(
                                                                  ImagePaths
                                                                      .imagePlaceHolder,
                                                                  width: 150,
                                                                  height: 100,
                                                                  fit: BoxFit.cover,
                                                                ),
                                                              );
                                                            },
                                                            loadingBuilder: (context,
                                                                child,
                                                                loadingProgress) {
                                                              if (loadingProgress ==
                                                                  null) {
                                                                return child;
                                                              }
                                                              return SkeletonLine(
                                                                style: SkeletonLineStyle(
                                                                  width: 150,
                                                                  height: 100,
                                                                  borderRadius: BorderRadius
                                                                      .circular(
                                                                      12),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                    ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16,right: 16, bottom:8),
                    child: NewMessageWidget(
                      onAttach: () {
                        _bloc.add(MediaIconPressedEvent());
                      },
                      onSend: (message) {
                        FocusScope.of(context).unfocus();
                        _bloc.add(SendPressedEvent(
                          orderId: _orderId,
                          message: message,
                        ));
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
        );
      },
    );
  }

  _scrollToLastIndex() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.bounceOut,
    );
  }

  void _navigateBackEvent() {
    _bloc.add(NavigateBackEvent());
  }

  bool _isUser(int userId) {
    return userId == 1;
  }

  void _askForCameraPermissionEvent(Function() onTab, bool isGallery) {
    _bloc.add(AskForCameraPermissionEvent(
      onTab: () {
        onTab();
      },
      isGallery: isGallery,
    ));
  }

  void _cameraPressedEvent() {
    _bloc.add(CameraPressedEvent());
  }

  void _galleryPressedEvent() {
    _bloc.add(GalleryPressedEvent());
  }

  void _askForCameraPermission(
    Function() onTab,
    bool isGallery,
  ) async {
    bool cameraPermission = await PermissionServiceHandler()
        .handleServicePermission(
            setting: isGallery
                ? PermissionServiceHandler.getSingleImageGalleryPermission()
                : PermissionServiceHandler.getCameraPermission());
    if (cameraPermission) {
      onTab();
    } else {
      _showActionDialog(
        icon: ImagePaths.warning,
        onPrimaryAction: () async {
          _navigateBackEvent();
          openAppSettings().then((value) async {
            if (await (isGallery
                    ? PermissionServiceHandler.getSingleImageGalleryPermission()
                    : PermissionServiceHandler.getCameraPermission())
                .isGranted) {
              onTab();
            }
          });
        },
        onSecondaryAction: () {
          _navigateBackEvent();
        },
        primaryText: S.of(context).ok,
        secondaryText: S.of(context).cancel,
        text: isGallery && Platform.isIOS
            ? S.of(context).youShouldHaveStoragePermission
            : S.of(context).youShouldHaveCameraPermission,
      );
    }
  }

  Future<void> _getImage(
    ImageSource imageSource,
  ) async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: imageSource);
    XFile? imageFile = await compressFile(File(pickedFile!.path));
    if (imageFile == null) {
      return;
    }

    _bloc.add(SendPressedEvent(
      orderId: _orderId,
      message: '',
      isImage: true,
      imagePath: imageFile.path,
    ));
  }

  void _showActionDialog({
    required Function() onPrimaryAction,
    required Function() onSecondaryAction,
    required String primaryText,
    required String secondaryText,
    required String text,
    required String icon,
  }) {
    showActionDialogWidget(
      context: context,
      text: text,
      primaryText: primaryText,
      primaryAction: () {
        onPrimaryAction();
      },
      secondaryText: secondaryText,
      secondaryAction: () {
        onSecondaryAction();
      },
      icon: icon,
    );
  }

  void _showMessageDialog(
    BuildContext context,
    String message,
    String icon,
    Function() onTab,
  ) {
    showMassageDialogWidget(
      context: context,
      text: message,
      buttonText: S.of(context).ok,
      onTap: onTab,
      icon: icon,
    );
  }

  void _onTapPreviewImage(String image) {
    Navigator.pushNamed(context, Routes.galleryImages,
        arguments: GalleryImages(initialIndex: 0, images: [
          GalleryAttachment(attachment: image),
        ]));
  }
}
