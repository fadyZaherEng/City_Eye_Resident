import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:audio_session/audio_session.dart';
import 'package:city_eye/flavors.dart';
import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/routes/routes_manager.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/base/widget/base_stateful_widget.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/complain_keys.dart';
import 'package:city_eye/src/core/utils/convert_asset_entities_to_files.dart';
import 'package:city_eye/src/core/utils/format_time.dart';
import 'package:city_eye/src/core/utils/generate_thumbnail.dart';
import 'package:city_eye/src/core/utils/permission_service_handler.dart';
import 'package:city_eye/src/core/utils/show_action_dialog_widget.dart';
import 'package:city_eye/src/core/utils/show_bottom_sheet_upload_media.dart';
import 'package:city_eye/src/core/utils/show_snack_bar.dart';
import 'package:city_eye/src/domain/entities/complain/widget_id.dart';
import 'package:city_eye/src/domain/entities/complain/widget_model.dart';
import 'package:city_eye/src/domain/entities/gallery/gallery_attachment.dart';
import 'package:city_eye/src/domain/entities/gallery/images_screen.dart';
import 'package:city_eye/src/domain/entities/settings/compound_configuration.dart';
import 'package:city_eye/src/presentation/blocs/complain/complain_bloc.dart';
import 'package:city_eye/src/presentation/widgets/audio_widget.dart';
import 'package:city_eye/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:city_eye/src/presentation/widgets/custom_button_widget.dart';
import 'package:city_eye/src/presentation/widgets/describe_widget.dart';
import 'package:city_eye/src/presentation/widgets/images_widget.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:skeletons/skeletons.dart';
import 'package:video_player/video_player.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class ComplainScreen extends BaseStatefulWidget {
  const ComplainScreen({
    super.key,
  });

  @override
  BaseState<BaseStatefulWidget> baseCreateState() => _ComplainScreenState();
}

class _ComplainScreenState extends BaseState<ComplainScreen> {
  ComplainBloc get _bloc => BlocProvider.of<ComplainBloc>(context);
  final TextEditingController _describeYourProblemController =
      TextEditingController();
  final GlobalKey _descriptionKey = GlobalKey();
  int _maxVideoDuration = 30;
  int _maxCharacter = 150;
  int _minCharacter = 20;
  int _maxImageCount = 3;
  int _miniImageCount = 1;
  int _maxAudioDuration = 30;
  File? selectedVideo;
  bool _isDescribeYourProblemValid = true;
  List<File> images = [];
  VideoPlayerController? videoPlayerController;
  List<WidgetModel> _widgets = [];

  bool _isAudioIconVisible = false;
  bool _isImageIconVisible = false;
  bool _isVideoIconVisible = false;

  var describeWidgetKey = GlobalKey();

  int selectedCameraImages = 0;
  List<AssetEntity> imagesAssets = [];
  List<File> cameraImages = [];

  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  String _audioPath = "";
  bool _isReachedMax = false;

  @override
  void initState() {
    _bloc.add(GetCompoundConfigurationEvent());
    super.initState();
  }

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<ComplainBloc, ComplainState>(
        listener: (context, state) async {
      if (state is ComplainLoadingState) {
        showLoading();
      } else {
        hideLoading();
      }

      if (state is ShowVideoSkeletonState) {
        _widgets.removeWhere(
          (element) => element.id == WidgetId.video,
        );
      } else if (state is GetCompoundConfigurationState) {
        _onGetCompoundConfigurationEvent(
          state.compoundConfiguration,
        );
      } else if (state is ComplainSubmitSuccessState) {
        _onComplainSubmitSuccessState(state.message);
      } else if (state is ComplainSubmitErrorState) {
        _onComplainSubmitErrorState(
          errorMessage: state.errorMessage,
        );
      } else if (state is DescribeProblemValidState) {
        _isDescribeYourProblemValid = true;
      } else if (state is DescribeProblemInvalidState) {
        _isDescribeYourProblemValid = false;
        _scrollToElement(0);
      } else if (state is NavigateBackState) {
        Navigator.pop(context);
      } else if (state is OpenMediaBottomSheetState) {
        _onOpenMediaBottomSheetState(
          mediaType: state.mediaType,
        );
      } else if (state is AddImageState) {
        selectedCameraImages++;
        cameraImages.add(state.image);
        await convertAssetEntitiesToFiles(imagesAssets).then((value) {
          _addImages(cameraImages, value, true);
        });
      } else if (state is AddMultipleImageState) {
        _addImages(cameraImages, state.images, false);
      } else if (state is NoImageSelectedState) {
      } else if (state is AddVideoState) {
        _onAddVideoState(
          video: state.video,
          imageSource: state.imageSource,
        );
      } else if (state is NoVideoSelectedState) {
      } else if (state is NavigateToVideoTrimmerScreenState) {
        _onNavigateToTrimmerScreenState(
          video: state.video,
          maxDuration: state.maxDuration,
        );
      } else if (state is RemoveVideoState) {
        videoPlayerController!.pause();
        videoPlayerController!.dispose();
        videoPlayerController = null;
        selectedVideo = null;
        _widgets.removeWhere(
          (element) => element.id == WidgetId.video,
        );
      } else if (state is RemoveImageState) {
        images = state.images;
        _widgets.removeWhere(
          (element) => element.id == WidgetId.image,
        );
        _widgets.add(WidgetModel(
          widget: _imagesWidget(),
          id: WidgetId.image,
        ));
        if (state.index < imagesAssets.length) {
          imagesAssets.removeAt(state.index);
        } else {
          cameraImages.removeAt(state.index - imagesAssets.length);
          selectedCameraImages--;
        }
        FocusScope.of(context).unfocus();
      } else if (state is InitializeRecorderState) {
        if (Platform.isIOS) {
          await _handleIOSAudio();
        }
        _isReachedMax = false;
        await _recorder.openRecorder();
        if (_recorder.isRecording) {
          _stopRecorderEvent();
        } else {
          _startRecorderEvent();
        }
      } else if (state is StartRecordingState) {
        _startRecording();
      } else if (state is StopRecordingState) {
        _stopRecording();
      } else if (state is SaveAudioPathState) {
        _audioPath = state.audioPath;
        _widgets.removeWhere(
          (element) => element.id == WidgetId.audio,
        );
        _widgets.add(WidgetModel(
          widget: _audioWidget(),
          id: WidgetId.audio,
        ));
        FocusScope.of(context).unfocus();
      } else if (state is RemoveAudioFileState) {
        _audioPath = "";
        _widgets.removeWhere(
          (element) => element.id == WidgetId.audio,
        );
        if (state.isReplace) {
          setState(() {});
          await Future.delayed(const Duration(seconds: 1));
          _bloc.add(SaveAudioPathEvent(audioPath: state.audioPath));
        }
      } else if (state is AudioStatusChangeState) {
        if (state.duration == _maxAudioDuration && _isReachedMax == false) {
          _isReachedMax = true;
          _stopRecorderEvent();
        }
      }
    }, builder: (context, state) {
      return WillPopScope(
          onWillPop: () async {
            FocusScope.of(context).unfocus();
            if (_audioPath.isNotEmpty ||
                images.isNotEmpty ||
                _describeYourProblemController.text.trim().isNotEmpty ||
                selectedVideo != null) {
              _showActionDialog(
                icon: ImagePaths.warning,
                onSecondaryAction: () {
                  _navigateBackEvent();
                  _navigateBackEvent();
                },
                onPrimaryAction: () {
                  _navigateBackEvent();
                },
                secondaryText: S.of(context).discard,
                primaryText: S.of(context).keep,
                text: S.of(context).allChangesWillBeLostIfYouLeaveThisPage,
              );
            }
            return true;
          },
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: buildAppBarWidget(
                context,
                title: S.of(context).complain,
                isHaveBackButton: true,
                onBackButtonPressed: () {
                  FocusScope.of(context).unfocus();
                  if (_audioPath.isNotEmpty ||
                      images.isNotEmpty ||
                      _describeYourProblemController.text.trim().isNotEmpty ||
                      selectedVideo != null) {
                    _showActionDialog(
                      icon: ImagePaths.warning,
                      onSecondaryAction: () {
                        _navigateBackEvent();
                        _navigateBackEvent();
                      },
                      onPrimaryAction: () {
                        _navigateBackEvent();
                      },
                      secondaryText: S.of(context).discard,
                      primaryText: S.of(context).keep,
                      text:
                          S.of(context).allChangesWillBeLostIfYouLeaveThisPage,
                    );
                  } else {
                    _navigateBackEvent();
                  }
                },
              ),
              body: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        key: describeWidgetKey,
                        children: [
                          DescribeWidget(
                            maxLength: _maxCharacter,
                            minLength: _minCharacter,
                            maxAudioLength: _maxAudioDuration,
                            describeText: S.of(context).describeYourProblem,
                            key: _descriptionKey,
                            isRecording: _recorder.isRecording,
                            onProgress: _recorder.onProgress,
                            remainingCharacter: _maxCharacter -
                                _describeYourProblemController.value.text
                                    .toString()
                                    .length,
                            onVideoTap: () => _onTapVideo(),
                            onGalleryTap: () => _onTapGallery(),
                            onMicrophoneTap: () {
                              _onTapMicrophone();
                            },
                            describeController: _describeYourProblemController,
                            onDescribeChanged: (value) {
                              _bloc.add(DescribeProblemValidationEvent(
                                value: value,
                                max: _maxCharacter,
                                min: _minCharacter,
                              ));
                            },
                            isDescribeValid: _isDescribeYourProblemValid,
                            isVideoIconVisible: _isVideoIconVisible,
                            isImageIconVisible: _isImageIconVisible,
                            isAudioIconVisible: _isAudioIconVisible,
                          ),
                          Column(
                            children: _widgets.map((e) => e.widget).toList(),
                          ),
                          state is ShowVideoSkeletonState
                              ? _buildVideoSkeleton()
                              : const SizedBox.shrink(),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 16, right: 16, left: 16),
                            child: CustomButtonWidget(
                              onTap: () {
                                if (_validateSendRequest() &&
                                    !_recorder.isRecording) {
                                  _bloc.add(SubmitRequestEvent(
                                    description: _describeYourProblemController
                                        .text
                                        .trim(),
                                    images: images,
                                    audioPath: _audioPath,
                                    videoFile: selectedVideo != null
                                        ? selectedVideo!.path
                                        : "",
                                    min: _minCharacter,
                                  ));
                                }
                              },
                              text: S.of(context).submit,
                              width: double.infinity,
                              height: 50,
                              backgroundColor: F.isNiceTouch
                                  ? ColorSchemes.ghadeerDarkBlue
                                  : ColorSchemes.primary,
                            ),
                          ),
                        ],
                      )),
                ],
              )));
    });
  }

  void _addImages(
      List<File> cameraImages, List<File> galleryImages, bool isFromCamera) {
    images.clear();
    if (galleryImages.isNotEmpty) {
      images.addAll(galleryImages);
    }
    if (cameraImages.isNotEmpty && isFromCamera) {
      images.addAll(cameraImages);
    }
    _widgets.removeWhere(
      (element) => element.id == WidgetId.image,
    );
    _widgets.add(WidgetModel(
      widget: _imagesWidget(),
      id: WidgetId.image,
    ));
    FocusScope.of(context).unfocus();
    setState(() {});
  }

  void _onGetCompoundConfigurationEvent(
      CompoundConfiguration compoundConfiguration) {
    // ignore: avoid_function_literals_in_foreach_calls
    compoundConfiguration.listOfMultiMediaConfiguration.forEach((element) {
      if (element.pageCode == ComplainKeys.complain) {
        for (var element in element.compoundMultiMediaConfiguration) {
          if (element.multiMediaType.code == ComplainKeys.audio) {
            _maxAudioDuration = element.maxTime == 0 ? 30 : element.maxTime;
            _isAudioIconVisible = element.isVisible;
          } else if (element.multiMediaType.code == ComplainKeys.video) {
            _maxVideoDuration = element.maxTime == 0 ? 30 : element.maxTime;
            _isVideoIconVisible = element.isVisible;
          } else if (element.multiMediaType.code == ComplainKeys.image) {
            _maxImageCount = element.maxCount;
            _miniImageCount = element.minCount;
            _isImageIconVisible = element.isVisible;
          } else if (element.multiMediaType.code == ComplainKeys.text) {
            _maxCharacter = element.maxCount == 0 ? 150 : element.maxCount;
            _minCharacter = element.minCount == 0 ? 20 : element.minCount;
          }
        }
      }
    });
  }

  void _navigateBackEvent() => _bloc.add(NavigateBackEvent());

  void _onComplainSubmitSuccessState(String message) {
    showSnackBar(
      context: context,
      message: message,
      color: ColorSchemes.snackBarSuccess,
      icon: ImagePaths.success,
    );
    _navigateBackEvent();
  }

  void _onComplainSubmitErrorState({
    required errorMessage,
  }) {
    showSnackBar(
      context: context,
      message: errorMessage,
      color: ColorSchemes.snackBarError,
      icon: ImagePaths.error,
    );
  }

  void _openMediaBottomSheetEvent({
    required MediaType mediaType,
  }) {
    _bloc.add(OpenMediaBottomSheetEvent(
      mediaType: mediaType,
    ));
  }

  void _removeImageEvent(
    List<File> images,
    int index,
  ) {
    return _bloc.add(RemoveImageEvent(
      images: images,
      index: index,
    ));
  }

  void _onTapVideo() {
    FocusScope.of(context).unfocus();
    if (selectedVideo != null) {
      _showActionDialog(
        icon: ImagePaths.warning,
        onPrimaryAction: () {
          _navigateBackEvent();
        },
        primaryText: S.of(context).no,
        onSecondaryAction: () {
          _navigateBackEvent();
          _openMediaBottomSheetEvent(
            mediaType: MediaType.video,
          );
        },
        secondaryText: S.of(context).yes,
        text: S.of(context).confirmReplacingTheOldVideoWithANewOne,
      );
    } else {
      _openMediaBottomSheetEvent(
        mediaType: MediaType.video,
      );
    }
  }

  void _onTapGallery() {
    FocusScope.of(context).unfocus();
    if (images.length == _maxImageCount) {
      showSnackBar(
        context: context,
        message: S.of(context).youHaveReachedTheMaximumImageLimit,
        color: ColorSchemes.snackBarInfo,
        icon: ImagePaths.info,
      );
    } else {
      _openMediaBottomSheetEvent(
        mediaType: MediaType.image,
      );
    }
  }

  Future<void> _onTapMicrophone() async {
    FocusScope.of(context).unfocus();
    if (_audioPath.isNotEmpty && !_recorder.isRecording) {
      _showActionDialog(
        icon: ImagePaths.warning,
        onPrimaryAction: () {
          _navigateBackEvent();
        },
        primaryText: S.of(context).no,
        onSecondaryAction: () async {
          _navigateBackEvent();
          if (await _requestMicrophonePermission()) {
            _initializeRecorderEvent();
          }
        },
        secondaryText: S.of(context).yes,
        text: S.of(context).confirmReplacingTheOldRecordingWithANewOne,
      );
    } else {
      if (await _requestMicrophonePermission()) {
        _initializeRecorderEvent();
      }
    }
  }

  void _onOpenMediaBottomSheetState({
    required MediaType mediaType,
  }) {
    showBottomSheetUploadMedia(
      context: context,
      onTapCamera: () async {
        _navigateBackEvent();
        if (await PermissionServiceHandler().handleServicePermission(
          setting: PermissionServiceHandler.getCameraPermission(),
        )) {
          if (mediaType == MediaType.image) {
            _getImage(ImageSource.camera);
          } else {
            _getVideo(ImageSource.camera);
          }
        } else {
          _showActionDialog(
            icon: ImagePaths.warning,
            onPrimaryAction: () {
              _navigateBackEvent();
              openAppSettings().then((value) async {
                if (await PermissionServiceHandler().handleServicePermission(
                    setting: PermissionServiceHandler.getCameraPermission())) {}
              });
            },
            onSecondaryAction: () {
              _navigateBackEvent();
            },
            primaryText: S.current.ok,
            secondaryText: S.current.cancel,
            text: S.current.youShouldHaveCameraPermission,
          );
        }
      },
      onTapGallery: () async {
        _navigateBackEvent();
        Permission permission = mediaType == MediaType.image
            ? PermissionServiceHandler.getGalleryPermission(
                true,
                androidDeviceInfo: Platform.isAndroid
                    ? await DeviceInfoPlugin().androidInfo
                    : null,
              )
            : PermissionServiceHandler.getSingleVideoGalleryPermission(
                androidDeviceInfo: Platform.isAndroid
                    ? await DeviceInfoPlugin().androidInfo
                    : null,
              );
        if (await PermissionServiceHandler().handleServicePermission(
          setting: permission,
        )) {
          if (mediaType == MediaType.image) {
            _getImage(ImageSource.gallery);
          } else {
            _getVideo(ImageSource.gallery);
          }
        } else {
          _showActionDialog(
            icon: ImagePaths.warning,
            onPrimaryAction: () {
              _navigateBackEvent();
              openAppSettings().then((value) async {
                if (await PermissionServiceHandler().handleServicePermission(
                  setting: permission,
                )) {}
              });
            },
            onSecondaryAction: () {
              _navigateBackEvent();
            },
            primaryText: S.current.ok,
            secondaryText: S.current.cancel,
            text: S.current.youShouldHaveCameraPermission,
          );
        }
      },
    );
  }

  Future<void> _getImage(
    ImageSource img,
  ) async {
    if (img == ImageSource.gallery) {
      List<AssetEntity>? images = [];
      images = await AssetPicker.pickAssets(
        context,
        pickerConfig: AssetPickerConfig(
          selectedAssets: imagesAssets,
          maxAssets: _maxImageCount - selectedCameraImages,
          requestType: RequestType.image,
          specialPickerType: SpecialPickerType.noPreview,
        ),
      );

      if (images != null) {
        imagesAssets = images;
      }
      List<XFile> imagesList = [];

      await convertAssetEntitiesToFiles(imagesAssets).then((value) {
        imagesList = value.map((e) => XFile(e.path)).toList();
      });

      for (int i = 0; i < cameraImages.length; i++) {
        if (!imagesList.contains(XFile(cameraImages[i].path))) {
          imagesList.add(XFile(cameraImages[i].path));
        }
      }
      _bloc.add(AddMultipleImagesEvent(images: imagesList));
    } else {
      final ImagePicker picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: img,
      );
      XFile? imageFile = pickedFile;
      _bloc.add(AddImageEvent(image: imageFile));
    }
  }

  Future<void> _getVideo(
    ImageSource img,
  ) async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickVideo(
        source: img,
        maxDuration: Duration(
          seconds: _maxVideoDuration,
        ));
    XFile? videoFile = pickedFile;
    _bloc.add(AddVideoEvent(
      video: videoFile,
      imageSource: img,
    ));
  }

  void _onAddVideoState({
    required File video,
    required ImageSource imageSource,
  }) {
    selectedVideo = video;
    videoPlayerController = VideoPlayerController.file(
      selectedVideo!,
    )..initialize().then((_) {
        if (videoPlayerController!.value.duration.inSeconds >
            _maxVideoDuration) {
          _bloc.add(NavigateToVideoTrimmerScreenEvent(
            video: selectedVideo!,
            maxDuration: _maxVideoDuration,
          ));
          selectedVideo = null;
          videoPlayerController = null;
        } else {
          _widgets.removeWhere(
            (element) => element.id == WidgetId.video,
          );
          setState(() {});
          _widgets.add(WidgetModel(
            widget: _videoWidget(),
            id: WidgetId.video,
          ));
          FocusScope.of(context).unfocus();
        }
      });
  }

  void _onNavigateToTrimmerScreenState({
    required File video,
    required int maxDuration,
  }) {
    Navigator.pushNamed(
      context,
      Routes.videoTrimmer,
      arguments: {
        "video": video,
        "maxDuration": maxDuration,
      },
    ).then((value) {
      if (value != null) {
        selectedVideo = File(value as String);
        videoPlayerController = VideoPlayerController.file(
          selectedVideo!,
        )..initialize().then((_) {
            _widgets.removeWhere(
              (element) => element.id == WidgetId.video,
            );
            setState(() {});
            _widgets.add(WidgetModel(
              widget: _videoWidget(),
              id: WidgetId.video,
            ));
            FocusScope.of(context).unfocus();
          });
      }
    });
  }

  Future _showActionDialog({
    required Function() onPrimaryAction,
    required Function() onSecondaryAction,
    required String primaryText,
    required String secondaryText,
    required String text,
    required String icon,
  }) {
    return showActionDialogWidget(
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

  Future<void> _handleIOSAudio() async {
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions:
          AVAudioSessionCategoryOptions.allowBluetooth |
              AVAudioSessionCategoryOptions.defaultToSpeaker,
      avAudioSessionMode: AVAudioSessionMode.spokenAudio,
      avAudioSessionRouteSharingPolicy:
          AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
      androidAudioAttributes: const AndroidAudioAttributes(
        contentType: AndroidAudioContentType.speech,
        flags: AndroidAudioFlags.none,
        usage: AndroidAudioUsage.voiceCommunication,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
      androidWillPauseWhenDucked: true,
    ));
  }

  Future<bool> _requestMicrophonePermission() async {
    bool isGranted = false;

    isGranted = await PermissionServiceHandler().handleServicePermission(
        setting: PermissionServiceHandler.getMicrophonePermission());

    if (isGranted) return true;

    _showActionDialog(
      icon: ImagePaths.warning,
      onPrimaryAction: () {
        _navigateBackEvent();
        openAppSettings().then((value) async {
          isGranted = await PermissionServiceHandler().handleServicePermission(
              setting: PermissionServiceHandler.getMicrophonePermission());
          return isGranted;
        });
      },
      onSecondaryAction: () {
        _navigateBackEvent();
      },
      primaryText: S.current.ok,
      secondaryText: S.current.cancel,
      text: S.current.youShouldHaveMicroPhonePermission,
    );

    return isGranted;
  }

  Future<void> _initializeRecorderEvent() async {
    _bloc.add(InitializeRecorderEvent());
  }

  Future<void> _startRecorderEvent() async {
    _bloc.add(StartRecordingEvent());
  }

  Future<void> _stopRecorderEvent() async {
    _bloc.add(StopRecordingEvent());
  }

  Future<void> _removeAudioFileEvent({
    String audioPath = "",
    bool isReplace = false,
  }) async {
    _bloc.add(RemoveAudioFileEvent(
      isReplace: isReplace,
      audioPath: audioPath,
    ));
  }

  Future<void> _startRecording() async {
    Directory? dir;
    if (Platform.isIOS) {
      dir = await getApplicationDocumentsDirectory();
    } else {
      dir = await getApplicationDocumentsDirectory();
    }
    await _recorder.setSubscriptionDuration(const Duration(
      milliseconds: 500,
    ));
    await _recorder.startRecorder(toFile: "${dir.path}/audio.aac");
    _recorder.onProgress!.listen((time) async {
      _bloc.add(AudioStatusChangeEvent(
        isRecording: true,
        duration: time.duration.inSeconds,
      ));
    });
  }

  Future<void> _stopRecording() async {
    String audioPath = await _recorder.stopRecorder() ?? "";
    if (_audioPath.isEmpty) {
      _bloc.add(AudioStatusChangeEvent(
        isRecording: false,
        duration: 0,
      ));
      _bloc.add(SaveAudioPathEvent(audioPath: audioPath));
    } else {
      _removeAudioFileEvent(
        isReplace: true,
        audioPath: audioPath,
      );
    }
  }

  Widget _videoWidget() {
    return videoPlayerController == null
        ? const SizedBox.shrink()
        : videoPlayerController!.value.isInitialized
            ? Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 150,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey),
                          child: InkWell(
                            onTap: () {
                              _navigateToPlayVideoScreenEvent(
                                  selectedVideo, videoPlayerController!);
                            },
                            child: SizedBox(
                              height: 150,
                              child: FutureBuilder<Uint8List?>(
                                future: generateThumbnail(selectedVideo!.path),
                                builder: (BuildContext context,
                                    AsyncSnapshot<Uint8List?> snapshot) {
                                  if (snapshot.connectionState ==
                                          ConnectionState.done &&
                                      snapshot.data != null) {
                                    return Image.memory(
                                      snapshot.data!,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    );
                                  } else if (snapshot.error != null) {
                                    return _buildPlaceHolderImage();
                                  } else {
                                    return const Center(
                                        child:
                                            CircularProgressIndicator());
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        Positioned.directional(
                          textDirection: Directionality.of(context),
                          start: 6,
                          top: -10,
                          child: InkWell(
                            onTap: () {
                              _showActionDialog(
                                icon: ImagePaths.warning,
                                onSecondaryAction: () {
                                  _navigateBackEvent();
                                  _bloc.add(RemoveVideoEvent());
                                },
                                onPrimaryAction: () {
                                  _navigateBackEvent();
                                },
                                secondaryText: S.of(context).yes,
                                primaryText: S.of(context).no,
                                text: S
                                    .of(context)
                                    .areYouSureYouWantToDeleteThisVideo,
                              );
                            },
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: const BoxDecoration(
                                color: ColorSchemes.white,
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset(
                                ImagePaths.close,
                                fit: BoxFit.scaleDown,
                                color: ColorSchemes.gray,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _navigateToPlayVideoScreenEvent(
                          selectedVideo, videoPlayerController!);
                    },
                    child: SvgPicture.asset(
                      fit: BoxFit.scaleDown,
                      ImagePaths.play,
                      color: Colors.white,
                      width: 45,
                      height: 45,
                    ),
                  ),
                  Positioned.directional(
                    end: 18,
                    bottom: 18,
                    textDirection: Directionality.of(context),
                    child: Text(
                      formatTime(videoPlayerController!.value.duration),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: ColorSchemes.white,
                          ),
                    ),
                  ),
                ],
              )
            : const SizedBox.shrink();
  }

  Widget _imagesWidget() {
    return ImageWidgets(
      images: images,
      imagesMaxNumber: _maxImageCount,
      imagesMinNumber: _miniImageCount,
      onAddImageTap: () {
        _openMediaBottomSheetEvent(
          mediaType: MediaType.image,
        );
      },
      onTapImage: (index) {
        List<GalleryAttachment> galleryImages = [];
        for (var image in images) {
          galleryImages.add(GalleryAttachment(attachment: image.path));
        }
        Navigator.pushNamed(context, Routes.galleryImages,
            arguments: GalleryImages(
              initialIndex: index,
              images: galleryImages,
            ));
      },
      onClearImageTap: (index) {
        _showActionDialog(
          icon: ImagePaths.warning,
          text: S.of(context).areYouSureYouWantToDeleteThisImage,
          primaryText: S.of(context).no,
          onPrimaryAction: () {
            _navigateBackEvent();
          },
          secondaryText: S.of(context).yes,
          onSecondaryAction: () {
            _navigateBackEvent();
            _removeImageEvent(
              images,
              index,
            );
          },
        );
      },
    );
  }

  Widget _audioWidget() {
    return _audioPath.isEmpty
        ? const SizedBox.shrink()
        : AudioWidget(
            audioPath: _audioPath,
            onClearAudioTap: () {
              _showActionDialog(
                icon: ImagePaths.warning,
                onSecondaryAction: () {
                  _navigateBackEvent();
                  _removeAudioFileEvent();
                },
                onPrimaryAction: () {
                  _navigateBackEvent();
                },
                secondaryText: S.of(context).yes,
                primaryText: S.of(context).no,
                text: S.of(context).areYouSureYouWantToDeleteThisAudio,
              );
            },
          );
  }

  void _scrollToElement(int index) {
    Scrollable.ensureVisible(describeWidgetKey.currentContext!);
  }

  void _navigateToPlayVideoScreenEvent(
      File? selectedVideo, VideoPlayerController videoPlayerController) {
    Navigator.pushNamed(
      context,
      Routes.playVideoScreen,
      arguments: {
        "video": selectedVideo ?? File(""),
        "videoPlayerController": videoPlayerController,
      },
    );
  }

  Widget _buildPlaceHolderImage() {
    return Image.asset(
      ImagePaths.imagePlaceHolder,
      fit: BoxFit.fill,
    );
  }

  bool _validateSendRequest() {
    if (_describeYourProblemController.text.trim().length >= _minCharacter ||
        _audioPath.isNotEmpty ||
        images.length >= _miniImageCount ||
        selectedVideo != null) {
      if (_describeYourProblemController.text.trim().isEmpty ||
          _describeYourProblemController.text.trim().length >= _minCharacter) {
        return true;
      } else {
        _bloc.add(DescribeProblemValidationEvent(
          value: _describeYourProblemController.text.trim(),
          max: _maxCharacter,
          min: _minCharacter,
        ));
        return false;
      }
    } else {
      showSnackBar(
          context: context,
          message: S.of(context).toastMessage,
          color: ColorSchemes.snackBarError,
          icon: ImagePaths.warning);
      _isDescribeYourProblemValid = false;
      setState(() {});
      return false;
    }
  }

  Widget _buildVideoSkeleton() => Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          width: double.infinity,
          height: 150,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: Colors.grey),
          child: const SkeletonLine(
            style: SkeletonLineStyle(
              width: double.infinity,
              height: 150,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ),
      );
}

enum MediaType {
  video,
  image,
}
