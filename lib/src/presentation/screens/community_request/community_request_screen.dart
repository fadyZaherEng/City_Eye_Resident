// ignore_for_file: use_build_context_synchronously

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
import 'package:city_eye/src/core/utils/community_request_keys.dart';
import 'package:city_eye/src/core/utils/compress_file.dart';
import 'package:city_eye/src/core/utils/convert_asset_entities_to_files.dart';
import 'package:city_eye/src/core/utils/format_time.dart';
import 'package:city_eye/src/core/utils/generate_thumbnail.dart';
import 'package:city_eye/src/core/utils/permission_service_handler.dart';
import 'package:city_eye/src/core/utils/show_action_dialog_widget.dart';
import 'package:city_eye/src/core/utils/show_bottom_sheet_upload_media.dart';
import 'package:city_eye/src/core/utils/show_massage_dialog_widget.dart';
import 'package:city_eye/src/core/utils/show_searchable_bottom_sheet.dart';
import 'package:city_eye/src/core/utils/show_snack_bar.dart';
import 'package:city_eye/src/domain/entities/community_request/widget_model.dart';
import 'package:city_eye/src/domain/entities/gallery/gallery_attachment.dart';
import 'package:city_eye/src/domain/entities/gallery/images_screen.dart';
import 'package:city_eye/src/domain/entities/settings/page_field.dart';
import 'package:city_eye/src/presentation/blocs/community_request/community_request_bloc.dart';
import 'package:city_eye/src/presentation/screens/community_request/skeleton/community_request_skeleton.dart';
import 'package:city_eye/src/presentation/screens/community_request/widgets/dynamic_widgets.dart';
import 'package:city_eye/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:city_eye/src/presentation/widgets/custom_button_widget.dart';
import 'package:city_eye/src/presentation/widgets/describe_widget.dart';
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
import '../../../domain/entities/community_request/media_type.dart';
import '../../../domain/entities/community_request/widget_id.dart';
import '../../widgets/audio_widget.dart';
import '../../widgets/images_widget.dart';

class CommunityRequestScreen extends BaseStatefulWidget {
  const CommunityRequestScreen({super.key});

  @override
  BaseState<BaseStatefulWidget> baseCreateState() =>
      _CommunityRequestScreenState();
}

class _CommunityRequestScreenState extends BaseState<CommunityRequestScreen> {
  CommunityRequestBloc get _bloc =>
      BlocProvider.of<CommunityRequestBloc>(context);

  final TextEditingController _describeYourRequestController =
      TextEditingController();
  final GlobalKey _descriptionKey = GlobalKey();
  final List<WidgetModel> _widgets = [];
  int _maxAudioDuration = 30;
  int _maxVideoDuration = 30;
  int _maxCharacter = 150;
  int _minCharacter = 20;
  int _miniImageCount = 1;
  int _maxImageCount = 3;
  String _audioPath = "";
  File? selectedVideo;
  bool _isDescribeYourRequestValid = true;
  List<File> _images = [];
  VideoPlayerController? _videoPlayerController;

  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  bool _isReachedMax = false;

  bool _isAudioIconVisible = false;
  bool _isImageIconVisible = false;
  bool _isVideoIconVisible = false;

  int selectedCameraImages = 0;
  List<AssetEntity> imagesAssets = [];
  List<File> cameraImages = [];

  ///**************** Dynamic Widgets **********************
  List<PageField> _questions = [];
  BuildContext? _scrollKey;

  @override
  void initState() {
    _bloc.add(GetCompoundConfigurationEvent());
    _bloc.add(GetQuestionsEvent());
    super.initState();
  }

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<CommunityRequestBloc, CommunityRequestState>(
      listener: (context, state) async {
        debugPrint(state.toString());
        if (state is CommunityRequestLoadingState) {
          showLoading();
        } else {
          hideLoading();
        }
        if (state is ShowVideoSkeletonState) {
          _widgets.removeWhere(
            (element) => element.id == WidgetId.video,
          );
        } else if (state is GetCompoundConfigurationState) {
          // ignore: avoid_function_literals_in_foreach_calls
          state.configuration.listOfMultiMediaConfiguration.forEach((element) {
            if (element.pageCode == CommunityRequestKeys.community) {
              for (var element in element.compoundMultiMediaConfiguration) {
                if (element.multiMediaType.code == CommunityRequestKeys.audio) {
                  _maxAudioDuration =
                      element.maxTime == 0 ? 30 : element.maxTime;
                  _isAudioIconVisible = element.isVisible;
                } else if (element.multiMediaType.code ==
                    CommunityRequestKeys.video) {
                  _maxVideoDuration =
                      element.maxTime == 0 ? 20 : element.maxTime;
                  _isVideoIconVisible = element.isVisible;
                } else if (element.multiMediaType.code ==
                    CommunityRequestKeys.image) {
                  _maxImageCount = element.maxCount;
                  _miniImageCount = element.minCount;
                  _isImageIconVisible = element.isVisible;
                } else if (element.multiMediaType.code ==
                    CommunityRequestKeys.text) {
                  _maxCharacter =
                      element.maxCount == 0 ? 150 : element.maxCount;
                  _minCharacter = element.minCount == 0 ? 20 : element.minCount;
                }
              }
            }
          });
        } else if (state is CommunityRequestSuccessState) {
          _onCommunityRequestSuccessState(state.message);
        } else if (state is CommunityRequestErrorState) {
          _onCommunityRequestErrorState(
            errorMessage: state.errorMessage,
          );
        } else if (state is CommunityDescribeRequestValidState) {
          _isDescribeYourRequestValid = true;
        } else if (state is CommunityDescribeRequestInvalidState) {
          _isDescribeYourRequestValid = false;
          _scrollTo();
        } else if (state is CommunityBackState) {
          Navigator.pop(context);
        } else if (state is CommunityOpenMediaBottomSheetState) {
          _onOpenMediaBottomSheetState(
            mediaType: state.mediaType,
            question: state.question,
            isQuestion: false,
          );
        } else if (state is CommunityAddImageState) {
          selectedCameraImages++;
          cameraImages.add(state.image);
          await convertAssetEntitiesToFiles(imagesAssets).then((value) {
            _addImages(cameraImages, value, true);
          });
        } else if (state is CommunityAddMultipleImageState) {
          _isDescribeYourRequestValid = true;
          _addImages(cameraImages, state.images, false);
        } else if (state is CommunityAddVideoState) {
          _onAddVideoState(
            video: state.video,
            imageSource: state.imageSource,
          );
        } else if (state is NavigateToVideoTrimmerScreenState) {
          _onNavigateToTrimmerScreenState(
            video: state.video,
            maxDuration: state.maxDuration,
          );
        } else if (state is CommunityRemoveVideoState) {
          _isDescribeYourRequestValid = false;
          _videoPlayerController!.pause();
          _videoPlayerController!.dispose();
          _videoPlayerController = null;
          selectedVideo = null;
          _widgets.removeWhere(
            (element) => element.id == WidgetId.video,
          );
        } else if (state is CommunityRemoveImageState) {
          _images = state.images;
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
          if (_images.length < _miniImageCount) {
            _isDescribeYourRequestValid = false;
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
          _isDescribeYourRequestValid = state.audioPath.isNotEmpty;
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
          /******************* Dynamic Widgets States ****************************/
        } else if (state is GetQuestionsSuccessState) {
          _questions = state.questions;
        } else if (state is GetQuestionsErrorState) {
          showSnackBar(
            context: context,
            message: state.errorMessage,
            color: ColorSchemes.snackBarError,
            icon: ImagePaths.error,
          );
          _navigateBackEvent();
        } else if (state is UpdateMapQuestionToWidgetState) {
          _questions = state.questions;
        } else if (state is ShowDialogToDeleteQuestionAnswerState) {
          _showActionDialog(
              icon: ImagePaths.warning,
              text: S.of(context).areYouSureYouWantToDeleteThisImage,
              onPrimaryAction: () {
                _navigateBackEvent();
                _bloc.add(DeleteQuestionAnswerEvent(question: state.question));
              },
              onSecondaryAction: () {
                _navigateBackEvent();
              },
              primaryText: S.of(context).yes,
              secondaryText: S.of(context).no);
        } else if (state is DynamicMediaBottomSheetState) {
          _onOpenMediaBottomSheetState(
            mediaType: state.mediaType,
            question: state.question,
            isQuestion: true,
          );
        } else if (state is ScrollToUnAnsweredMandatoryQuestionState) {
          _scrollKey = state.key.currentContext;
          _scrollTo();
        } else if (state is ShowQrSearchableBottomSheetState) {
          _openSearchableBottomSheet(state.question, state.isMultiChoice);
        }
      },
      builder: (context, state) {
        return WillPopScope(
            onWillPop: () {
              _onBackAction();
              return Future.value(true);
            },
            child: Scaffold(
                appBar: _buildAppBar(),
                body: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: state is ShowSkeletonState
                        ? const CommunityRequestSkeleton()
                        : Column(
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
                                    _describeYourRequestController.value.text
                                        .toString()
                                        .length,
                                onVideoTap: () => _onTapVideo(),
                                onGalleryTap: () => _onTapGallery(),
                                onMicrophoneTap: () {
                                  _onTapMicrophone();
                                },
                                describeController:
                                    _describeYourRequestController,
                                onDescribeChanged: (value) {
                                  _bloc.add(DescribeRequestValidationEvent(
                                    value: value,
                                    min: _minCharacter,
                                  ));
                                },
                                isDescribeValid: _isDescribeYourRequestValid,
                                isAudioIconVisible: _isAudioIconVisible,
                                isImageIconVisible: _isImageIconVisible,
                                isVideoIconVisible: _isVideoIconVisible,
                              ),
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: _widgets.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return _widgets[index].widget;
                                  }),
                              state is ShowVideoSkeletonState
                                  ? _buildVideoSkeleton()
                                  : const SizedBox.shrink(),
                              DynamicWidgets(
                                question: _questions,
                                onTapSingleSelection: (element, answerId) {
                                  _bloc.add(SelectSingleSelectionAnswerEvent(
                                      question: element, answerId: answerId));
                                },
                                onTapMultiSelection: (element, answerId) {
                                  _bloc.add(SelectMultiSelectionAnswerEvent(
                                      answerId: answerId, question: element));
                                },
                                onTapPickDateAnswer: (element, answer) {
                                  _bloc.add(AddAnswerToQuestionEvent(
                                      answer: answer, question: element));
                                },
                                onTapDateDeleteAnswer: (element) {
                                  _bloc.add(DeleteQuestionAnswerEvent(
                                      question: element));
                                },
                                onTapTextAnswerQuestion: (element, answer) {
                                  _bloc.add(AddAnswerToQuestionEvent(
                                      question: element, answer: answer));
                                },
                                onTapNumericAnswerQuestion: (element, answer) {
                                  _bloc.add(AddAnswerToQuestionEvent(
                                      question: element, answer: answer));
                                },
                                onShowUploadImageBottomSheet: (element) {
                                  _bloc.add(ShowMediaBottomSheetEvent(
                                      question: element));
                                },
                                onShowDialogToDeleteImage: (element) {
                                  _bloc.add(
                                      ShowDialogToDeleteQuestionAnswerEvent(
                                          question: element));
                                },
                                onOpenSearchableBottomSheet:
                                    (element, isMultiChoice) {
                                  _bloc.add(ShowQrSearchableBottomSheetEvent(
                                      question: element,
                                      isMultiChoice: isMultiChoice));
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: CustomButtonWidget(
                                  width: double.infinity,
                                  onTap: () {
                                    if (_validateSendRequest() &&
                                        !_recorder.isRecording) {
                                      _bloc.add(CommunitySendRequestEvent(
                                        description:
                                            _describeYourRequestController.text,
                                        images: _images,
                                        audioPath: _audioPath,
                                        videoFile: selectedVideo != null
                                            ? selectedVideo!.path
                                            : "",
                                        questions: _questions,
                                        minLength: _minCharacter,
                                      ));
                                    }
                                  },
                                  text: S.of(context).send,
                                  backgroundColor: F.isNiceTouch
                                      ? ColorSchemes.ghadeerDarkBlue
                                      : ColorSchemes.primary,
                                ),
                              ),
                            ],
                          ))));
      },
    );
  }

  AppBar _buildAppBar() {
    return buildAppBarWidget(context,
        title: S.of(context).communityRequest,
        isHaveBackButton: true, onBackButtonPressed: () {
      FocusScope.of(context).unfocus();
      _onBackAction();
    });
  }

  void _addImages(
      List<File> cameraImages, List<File> galleryImages, bool isFromCamera) {
    _images.clear();
    if (galleryImages.isNotEmpty) {
      _images.addAll(galleryImages);
    }
    if (cameraImages.isNotEmpty && isFromCamera) {
      _images.addAll(cameraImages);
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

  void _onTapVideo() {
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
    if (_images.length == _maxImageCount) {
      showMassageDialogWidget(
        context: context,
        text: S.of(context).youHaveReachedTheMaximumImageLimit,
        icon: ImagePaths.info,
        buttonText: S.of(context).ok,
        onTap: () {
          _navigateBackEvent();
        },
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
      primaryText: S.of(context).ok,
      secondaryText: S.of(context).cancel,
      text: S.of(context).youShouldHaveMicroPhonePermission,
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

  void _onOpenMediaBottomSheetState({
    required MediaType mediaType,
    required PageField question,
    bool isQuestion = false,
  }) {
    showBottomSheetUploadMedia(
      context: context,
      onTapCamera: () async {
        _navigateBackEvent();
        if (await PermissionServiceHandler().handleServicePermission(
          setting: PermissionServiceHandler.getCameraPermission(),
        )) {
          if (mediaType == MediaType.image) {
            _getImage(ImageSource.camera, question, isQuestion);
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
            primaryText: S.of(context).ok,
            secondaryText: S.of(context).cancel,
            text: S.of(context).youShouldHaveCameraPermission,
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
            _getImage(ImageSource.gallery, question, isQuestion);
          } else {
            _getVideo(ImageSource.gallery);
          }
        } else {
          _showActionDialog(
            icon: ImagePaths.warning,
            onPrimaryAction: () {
              _navigateBackEvent();
              openAppSettings(); /*.then((value) async {
                if (await PermissionServiceHandler().handleServicePermission(
                  setting: permission,
                )) {}
              });*/
            },
            onSecondaryAction: () {
              _navigateBackEvent();
            },
            primaryText: S.of(context).ok,
            secondaryText: S.of(context).cancel,
            text: S.of(context).youShouldHaveCameraPermission,
          );
        }
      },
    );
  }

  Future<void> _getImage(
    ImageSource img,
    PageField question,
    bool isQuestion,
  ) async {
    if (!isQuestion && img == ImageSource.gallery) {
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
      _bloc.add(CommunityAddMultipleImagesEvent(images: imagesList));
    } else {
      final ImagePicker picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: img,
      );
      XFile? imageFile = pickedFile;
      XFile? compressedImage = await compressFile(File(imageFile!.path));
      if (compressedImage!.path.isNotEmpty) {
        isQuestion
            ? _bloc.add(AddQuestionImageEvent(
                question: question, image: compressedImage))
            : _bloc.add(CommunityAddImageEvent(image: compressedImage));
      }
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
    _bloc.add(CommunityAddVideoEvent(
      video: videoFile,
      imageSource: img,
    ));
  }

  void _onAddVideoState({
    required File video,
    required ImageSource imageSource,
  }) {
    selectedVideo = video;
    _videoPlayerController = VideoPlayerController.file(
      selectedVideo!,
    )..initialize().then((_) {
        if (_videoPlayerController!.value.duration.inSeconds >
            _maxVideoDuration) {
          _bloc.add(NavigateToVideoTrimmerScreenEvent(
            video: selectedVideo!,
            maxDuration: _maxVideoDuration,
          ));
          selectedVideo = null;
          _videoPlayerController = null;
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
    _isDescribeYourRequestValid = true;
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
        _videoPlayerController = VideoPlayerController.file(
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

  Widget _videoWidget() {
    return _videoPlayerController == null
        ? const SizedBox.shrink()
        : _videoPlayerController!.value.isInitialized
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
                                  selectedVideo, _videoPlayerController!);
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
                                        child: CircularProgressIndicator());
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
                                  _bloc.add(CommunityRemoveVideoEvent());
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
                          selectedVideo, _videoPlayerController!);
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
                      formatTime(_videoPlayerController!.value.duration),
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
      images: _images,
      imagesMaxNumber: _maxImageCount,
      imagesMinNumber: _miniImageCount,
      onAddImageTap: () {
        _openMediaBottomSheetEvent(
          mediaType: MediaType.image,
        );
      },
      onTapImage: (index) {
        List<GalleryAttachment> galleryImages = [];
        for (var image in _images) {
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
              _images,
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

  void _navigateBackEvent() {
    _bloc.add(CommunityNavigationBackEvent());
  }

  void _openMediaBottomSheetEvent({
    required MediaType mediaType,
    PageField? question,
  }) {
    _bloc.add(CommunityOpenMediaBottomSheetEvent(
      mediaType: mediaType,
      question: question ?? PageField(),
    ));
  }

  void _removeImageEvent(
    List<File> images,
    int index,
  ) {
    return _bloc.add(CommunityRemoveImageEvent(
      images: images,
      index: index,
    ));
  }

  void _onCommunityRequestSuccessState(String message) {
    FocusScope.of(context).unfocus();

    showSnackBar(
      context: context,
      message: message,
      color: ColorSchemes.snackBarSuccess,
      icon: ImagePaths.success,
    );
    _navigateBackEvent();

    /* _showMessageDialog(
        text: message,
        icon: ImagePaths.success,
        onTap: () {
          _navigateBackEvent();
          _navigateBackEvent();
        });*/
  }

  void _onCommunityRequestErrorState({
    required String errorMessage,
  }) {
    showSnackBar(
      context: context,
      message: errorMessage,
      color: ColorSchemes.snackBarError,
      icon: ImagePaths.error,
    );
    _navigateBackEvent();
  }

  Future<void> _onBackAction() async {
    final hasAnsweredQuestions =
        _questions.any((element) => element.value != "");

    if (_audioPath.isNotEmpty ||
        _images.isNotEmpty ||
        _describeYourRequestController.text.trim().isNotEmpty ||
        selectedVideo != null ||
        hasAnsweredQuestions) {
      _showActionDialog(
        icon: ImagePaths.warning,
        onSecondaryAction: () {
          _navigateBackEvent();
          _navigateBackEvent();
          _resetAnswer();
        },
        onPrimaryAction: () {
          _navigateBackEvent();
        },
        secondaryText: S.of(context).discard,
        primaryText: S.of(context).keep,
        text: S.of(context).allChangesWillBeLostIfYouLeaveThisPage,
      );
    } else {
      _navigateBackEvent();
    }
  }

  Future<void> _scrollTo() async {
    if (_describeYourRequestController.text.length < _minCharacter &&
        _audioPath.isEmpty &&
        _images.length < _miniImageCount &&
        selectedVideo == null) {
      Scrollable.ensureVisible(_descriptionKey.currentContext!,
          duration: const Duration(milliseconds: 500));
    } else {
      if (_scrollKey != null) {
        Scrollable.ensureVisible(_scrollKey!,
            duration: const Duration(milliseconds: 500));
      }
    }
    setState(() {});
  }

  void _resetAnswer() {
    for (var i = 0; i < _questions.length; i++) {
      _questions[i] = _questions[i].copyWith(
        value: "",
      );
      for (var j = 0; j < _questions[i].choices.length; j++) {
        _questions[i].choices[j].isSelected = false;
      }
    }
  }

  void _openSearchableBottomSheet(PageField question, bool isMultiChoice) {
    showSearchableBottomSheet(
      context: context,
      pageField: question,
      isMultiChoice: isMultiChoice,
      onSaveMultiChoice: (pageField, choices) {
        _bloc.add(UpdateSearchableMultiQuestionEvent(
            question: pageField, answer: choices));
      },
      onChoicesSelected: (pageField, choice) {
        _bloc.add(UpdateSearchableSingleQuestionEvent(
            question: pageField, answer: choice));
        _navigateBackEvent();
      },
    );
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
    if (_describeYourRequestController.text.trim().length >= _minCharacter ||
        _audioPath.isNotEmpty ||
        _images.length >= _miniImageCount ||
        selectedVideo != null) {
      if (_describeYourRequestController.text == "" ||
          _describeYourRequestController.text.trim().length >= _minCharacter) {
        return true;
      } else {
        _bloc.add(DescribeRequestValidationEvent(
          value: _describeYourRequestController.text,
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
      _isDescribeYourRequestValid = false;
      _scrollTo();
      return false;
    }
  }

  Widget _buildVideoSkeleton() => const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: SkeletonLine(
          style: SkeletonLineStyle(
            width: double.infinity,
            height: 150,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
      );
}
