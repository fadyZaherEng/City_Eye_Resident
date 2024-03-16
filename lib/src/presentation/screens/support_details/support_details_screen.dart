import 'dart:io';
import 'dart:typed_data';

import 'package:audio_session/audio_session.dart';
import 'package:city_eye/flavors.dart';
import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/routes/routes_manager.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/base/widget/base_stateful_widget.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/android_date_picker.dart';
import 'package:city_eye/src/core/utils/compress_file.dart';
import 'package:city_eye/src/core/utils/convert_asset_entities_to_files.dart';
import 'package:city_eye/src/core/utils/extensions/date_format.dart';
import 'package:city_eye/src/core/utils/format_time.dart';
import 'package:city_eye/src/core/utils/generate_thumbnail.dart';
import 'package:city_eye/src/core/utils/ios_date_picker.dart';
import 'package:city_eye/src/core/utils/permission_service_handler.dart';
import 'package:city_eye/src/core/utils/show_action_dialog_widget.dart';
import 'package:city_eye/src/core/utils/show_bottom_sheet_upload_media.dart';
import 'package:city_eye/src/core/utils/show_massage_dialog_widget.dart';
import 'package:city_eye/src/core/utils/show_snack_bar.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/request/request_support_multi_media.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/request/submit_support_request.dart';
import 'package:city_eye/src/di/data_layer_injector.dart';
import 'package:city_eye/src/domain/entities/gallery/gallery_attachment.dart';
import 'package:city_eye/src/domain/entities/gallery/images_screen.dart';
import 'package:city_eye/src/domain/entities/home/home_support.dart';
import 'package:city_eye/src/domain/entities/settings/compound_multi_media_configuration.dart';
import 'package:city_eye/src/domain/entities/support_details/day_times.dart';
import 'package:city_eye/src/domain/entities/support_details/days.dart';
import 'package:city_eye/src/domain/entities/support_details/holidays.dart';
import 'package:city_eye/src/domain/entities/support_details/support_details_date.dart';
import 'package:city_eye/src/domain/usecase/get_support_index_use_case.dart';
import 'package:city_eye/src/domain/usecase/set_support_index_use_case.dart';
import 'package:city_eye/src/presentation/blocs/support_details/support_details_bloc.dart';
import 'package:city_eye/src/presentation/screens/support_details/widgets/prepared_visit_time_widget.dart';
import 'package:city_eye/src/presentation/screens/support_details/widgets/support_services_details_widget.dart';
import 'package:city_eye/src/presentation/widgets/audio_widget.dart';
import 'package:city_eye/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:city_eye/src/presentation/widgets/custom_button_widget.dart';
import 'package:city_eye/src/presentation/widgets/describe_widget.dart';
import 'package:city_eye/src/presentation/widgets/images_widget.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:skeletons/skeletons.dart';
import 'package:video_player/video_player.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class SupportDetailsScreen extends BaseStatefulWidget {
  final List<HomeSupport> supportServices;
  final HomeSupport selectedSupportService;
  final bool isFromSupportScreen;

  const SupportDetailsScreen({
    Key? key,
    required this.supportServices,
    required this.selectedSupportService,
    this.isFromSupportScreen = false,
  }) : super(key: key);

  @override
  BaseState<SupportDetailsScreen> baseCreateState() =>
      _SupportDetailsWidgetState();
}

class _SupportDetailsWidgetState extends BaseState<SupportDetailsScreen> {
  SupportDetailsBloc get _bloc => BlocProvider.of<SupportDetailsBloc>(context);

  final TextEditingController _describeYourRequestController =
      TextEditingController();
  final ScrollController _scrollController = ScrollController();
  HomeSupport _selectedSupportService = const HomeSupport();
  List<DayTimes> _preparedVisitTime = [];
  bool _isDescribeYourRequestValid = true;
  final GlobalKey _descriptionKey = GlobalKey();
  List<File> images = [];
  VideoPlayerController? videoPlayerController;
  File? selectedVideo;
  Uint8List? thumbnail;
  DateTime _selectedDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  String _audioPath = "";
  DayTimes _selectedPreparedTime = const DayTimes();

  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  bool _isReachedMax = false;
  int _idAfterSubmitSupport = 0;

  int selectedCameraImages = 0;
  List<AssetEntity> imagesAssets = [];
  List<File> cameraImages = [];
  bool showSkeleton = false;
  CompoundMultiMediaConfiguration _imageMultiMediaConfiguration =
      const CompoundMultiMediaConfiguration();
  CompoundMultiMediaConfiguration _audioMultiMediaConfiguration =
      const CompoundMultiMediaConfiguration();
  CompoundMultiMediaConfiguration _videoMultiMediaConfiguration =
      const CompoundMultiMediaConfiguration();
  CompoundMultiMediaConfiguration _textMultiMediaConfiguration =
      const CompoundMultiMediaConfiguration();
  String _preparedVisitTimeErrorMessage = "";

  SupportDetailsDate _supportDetailsDate = const SupportDetailsDate();

  @override
  void initState() {
    _bloc.add(GetSupportCompoundMultiMediaConfigurationEvent());
    super.initState();
    _selectSupportServiceEvent(widget.selectedSupportService);
  }

  bool addDuration = true;

  @override
  void dispose() {
    // _bloc.close();
    super.dispose();
  }

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<SupportDetailsBloc, SupportDetailsState>(
      listener: (context, state) async {
        if (state is ShowLoadingState) {
          showLoading();
        } else if (state is HideLoadingState) {
          hideLoading();
        } else if (state is SelectSupportServiceState) {
          _selectedSupportService = state.supportService;
          _selectedDate = DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day);
          _bloc.add(
            GetSupportDetailsDateEvent(
              date: _selectedDate.toString().formattedDateIntoYYYYMD,
              categoryId: _selectedSupportService.id,
            ),
          );
          _preparedVisitTimeErrorMessage = "";

          _scrollToSupportServiceEvent(_selectedSupportService);
        } else if (state is SuccessGetSupportMultiMediaConfigurationState) {
          _bloc.add(GetSupportMultiMediaEvent(
              multiMediaConfiguration: state.supportMultiMediaConfiguration));
        } else if (state is GetSupportMultiMediaState) {
          _imageMultiMediaConfiguration = state.imageMultiMediaConfiguration;
          _audioMultiMediaConfiguration = state.audioMultiMediaConfiguration;
          _videoMultiMediaConfiguration = state.videoMultiMediaConfiguration;
          _textMultiMediaConfiguration = state.textMultiMediaConfiguration;
          // _textMultiMediaConfiguration = state.textMultiMediaConfiguration;
        } else if (state is ScrollToSupportServiceState) {
          _scrollToElement(state.selectedSupportServiceIndex);
        } else if (state is SuccessGetSupportDetailsDateState) {
          hideLoading();
          _supportDetailsDate = state.supportDetailsDate;
          if (state.supportDetailsDate.supportCategory.rules.days.isNotEmpty) {
            _preparedVisitTime =
                state.supportDetailsDate.supportCategory.rules.days[0].dayTimes;
          } else {
            _preparedVisitTime = [];
          }
          if (!state.supportDetailsDate.supportCategory.rules
                  .canRequestOnSameDay &&
              addDuration) {
            _selectedDate = _getFirstDate(DateTime(DateTime.now().year,
                    DateTime.now().month, DateTime.now().day)
                .add(const Duration(days: 1)));
            addDuration = false;
          } else {
            _selectedDate = _getFirstDate(_selectedDate);
          }
        } else if (state is SelectPreparedTimeVisitState) {
          _preparedVisitTime = state.preparedVisitTimes;
          _selectedPreparedTime = state.selectedPreparedVisitTime;
          bool isSelected = false;
          if (_preparedVisitTime.isNotEmpty) {
            for (int i = 0; i < _preparedVisitTime.length; i++) {
              if (_preparedVisitTime[i].isSelected) {
                isSelected = true;
                break;
              }
            }
          }
          for (int i = 0; i < _preparedVisitTime.length; i++) {
            if (_preparedVisitTime[i].isSelected) {
              isSelected = true;
              break;
            }
          }

          if (!isSelected) {
            _preparedVisitTimeErrorMessage = S.of(context).thisFieldIsRequired;
          } else {
            _preparedVisitTimeErrorMessage = "";
          }
        } else if (state is DescribeRequestValidState) {
          _isDescribeYourRequestValid = true;
        } else if (state is DescribeRequestInvalidState) {
          _isDescribeYourRequestValid = false;
          Scrollable.ensureVisible(
            _descriptionKey.currentContext!,
            duration: const Duration(milliseconds: 500),
          );
        } else if (state is NavigateBackState) {
          _navigateBack();
        } else if (state is OpenMediaBottomSheetState) {
          showBottomSheetUploadMedia(
            context: context,
            onTapCamera: () async {
              _navigateBackEvent();
              if (await PermissionServiceHandler().handleServicePermission(
                  setting: PermissionServiceHandler.getCameraPermission())) {
                if (state.mediaType == MediaType.image) {
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
                      if (await PermissionServiceHandler()
                          .handleServicePermission(
                              setting: PermissionServiceHandler
                                  .getCameraPermission())) {}
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
              Permission permission = state.mediaType == MediaType.image
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

              if (await PermissionServiceHandler()
                  .handleServicePermission(setting: permission)) {
                if (state.mediaType == MediaType.image) {
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
                      if (await PermissionServiceHandler()
                          .handleServicePermission(setting: permission)) {}
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
        } else if (state is RemoveImageState) {
          images = state.images;

          if (state.index < imagesAssets.length) {
            imagesAssets.removeAt(state.index);
          } else {
            cameraImages.removeAt(state.index - imagesAssets.length);
            selectedCameraImages--;
          }
        } else if (state is AddVideoState) {
          selectedVideo = state.video;
          thumbnail = await generateThumbnail(selectedVideo!.path);
          videoPlayerController = VideoPlayerController.file(selectedVideo!)
            ..initialize().then((_) {
              if (videoPlayerController!.value.duration.inSeconds >
                  _videoMultiMediaConfiguration.maxTime) {
                _bloc.add(NavigateToVideoTrimmerScreenEvent(
                  video: selectedVideo!,
                  maxDuration: _videoMultiMediaConfiguration.maxTime,
                ));
                selectedVideo = null;
                videoPlayerController = null;
              } else {
                setState(() {});
              }
            });
        } else if (state is NoVideoSelectedState) {
        } else if (state is RemoveVideoState) {
          videoPlayerController!.pause();
          videoPlayerController!.dispose();
          videoPlayerController = null;
          selectedVideo = null;
        } else if (state is SelectPreparedTimeVisitDateState) {
          _selectedDate = state.selectedDate;
          _bloc.add(
            GetSupportDetailsDateEvent(
              date: _selectedDate.toString().formattedDateIntoYYYYMD,
              categoryId: _selectedSupportService.id,
            ),
          );

          _preparedVisitTimeErrorMessage = "";

          for (int i = 0; i < _preparedVisitTime.length; i++) {
            if (_preparedVisitTime[i].isSelected) {
              _preparedVisitTime[i] =
                  _preparedVisitTime[i].copyWith(isSelected: false);
            }
          }
        } else if (state is NavigateToVideoTrimmerScreenState) {
          Navigator.pushNamed(
            context,
            Routes.videoTrimmer,
            arguments: {
              "video": state.video,
              "maxDuration": state.maxDuration,
            },
          ).then((value) {
            if (value != null) {
              selectedVideo = File(value as String);
              videoPlayerController = VideoPlayerController.file(selectedVideo!)
                ..initialize().then((_) {
                  setState(() {});
                });
            }
          });
        } else if (state is ChangeRecordingState) {
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
          FocusScope.of(context).unfocus();
        } else if (state is RemoveAudioFileState) {
          _audioPath = "";
          if (state.isReplace) {
            setState(() {});
            await Future.delayed(const Duration(seconds: 1));
            _bloc.add(SaveAudioPathEvent(audioPath: state.audioPath));
          }
        } else if (state is AudioStatusChangeState) {
          if (state.duration == _audioMultiMediaConfiguration.maxTime &&
              _isReachedMax == false) {
            _isReachedMax = true;
            _stopRecorderEvent();
          }
        } else if (state is ResetAllValuesState) {
          _audioPath = "";
          selectedVideo = null;
          videoPlayerController = null;
          images = [];
          _selectedDate = DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day);
          for (int i = 0; i < _preparedVisitTime.length; i++) {
            if (_preparedVisitTime[i].isSelected) {
              _preparedVisitTime[i] =
                  _preparedVisitTime[i].copyWith(isSelected: false);
            }
          }
          _isDescribeYourRequestValid = true;
          _describeYourRequestController.clear();
          imagesAssets = [];
          cameraImages = [];
          selectedCameraImages = 0;
        } else if (state is SuccessSubmitSupportRequestState) {
          _idAfterSubmitSupport = state.submitSupport.id;
          await SetSupportIndexUseCase(injector())(
                  [state.submitSupport.id.toString(), "1", "open_support"])
              .then((value) {
            if (widget.isFromSupportScreen) {
              Navigator.pop(context, true);
            } else {
              Navigator.pushNamedAndRemoveUntil(
                  context, Routes.main, (route) => false,
                  arguments: {
                    "selectIndex":
                        int.parse(GetSupportIndexUseCase(injector())()[1]) == 1
                            ? 1
                            : 0,
                  });
            }
          });
          showSnackBar(
            context: context,
            message: state.message,
            color: ColorSchemes.snackBarSuccess,
            icon: ImagePaths.success,
          );
        } else if (state is FailedSubmitSupportRequestState) {
          _idAfterSubmitSupport = 0;
          showSnackBar(
            context: context,
            message: state.message,
            color: ColorSchemes.snackBarError,
            icon: ImagePaths.error,
          );
        } else if (state is ErrorGetSupportDetailsDateState) {
        } else if (state is ShowPreparedTimeVisitSkeletonState) {
          showSkeleton = true;
        } else if (state is HidePreparedTimeVisitSkeletonState) {
          showSkeleton = false;
        }
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            bool isDateSelected = false;
            for (var element in _preparedVisitTime) {
              if (element.isSelected) {
                isDateSelected = true;
                break;
              }
            }
            if (_audioPath.isNotEmpty ||
                selectedVideo != null ||
                images.isNotEmpty ||
                isDateSelected ||
                _describeYourRequestController.text.isNotEmpty) {
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
            } else {
              _navigateBackEvent();
            }
            return false;
          },
          child: Scaffold(
            appBar: buildAppBarWidget(
              context,
              title: S.of(context).supportDetails,
              isHaveBackButton: true,
              onBackButtonPressed: () {
                bool isDateSelected = false;
                for (var element in _preparedVisitTime) {
                  if (element.isSelected) {
                    isDateSelected = true;
                    break;
                  }
                }
                if (_audioPath.isNotEmpty ||
                    selectedVideo != null ||
                    images.isNotEmpty ||
                    _describeYourRequestController.text.isNotEmpty ||
                    isDateSelected) {
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      SupportServicesDetailsWidget(
                        supportServices: widget.supportServices,
                        selectedSupportService: _selectedSupportService,
                        scrollController: _scrollController,
                        onTab: (supportService) {
                          if (_selectedSupportService.id == supportService.id) {
                            return;
                          }

                          bool isDateSelected = false;
                          for (var element in _preparedVisitTime) {
                            if (element.isSelected) {
                              isDateSelected = true;
                              break;
                            }
                          }
                          if (_audioPath.isNotEmpty ||
                              selectedVideo != null ||
                              images.isNotEmpty ||
                              _describeYourRequestController.text.isNotEmpty ||
                              isDateSelected) {
                            _showActionDialog(
                              icon: ImagePaths.warning,
                              onSecondaryAction: () {
                                _navigateBackEvent();
                                _bloc.add(ResetAllValuesEvent());
                                _selectSupportServiceEvent(supportService);
                              },
                              onPrimaryAction: () {
                                _navigateBackEvent();
                                _selectSupportServiceEvent(supportService);
                              },
                              secondaryText: S.of(context).yes,
                              primaryText: S.of(context).no,
                              text: S
                                  .of(context)
                                  .areYouSureYouWantToDiscardTheChanges,
                            );
                          } else {
                            _selectSupportServiceEvent(supportService);
                          }
                        },
                      ),
                      DescribeWidget(
                        maxLength: _textMultiMediaConfiguration.maxCount == 0
                            ? 30
                            : _textMultiMediaConfiguration.maxCount,
                        minLength: _textMultiMediaConfiguration.minCount == 0
                            ? 20
                            : _textMultiMediaConfiguration.minCount,
                        maxAudioLength:
                            _audioMultiMediaConfiguration.maxTime == 0
                                ? 30
                                : _audioMultiMediaConfiguration.maxTime,
                        describeText: S.of(context).describeYourProblem,
                        key: _descriptionKey,
                        describeController: _describeYourRequestController,
                        isDescribeValid: _isDescribeYourRequestValid,
                        isAudioIconVisible:
                            _audioMultiMediaConfiguration.isVisible,
                        isImageIconVisible:
                            _imageMultiMediaConfiguration.isVisible,
                        isVideoIconVisible:
                            _videoMultiMediaConfiguration.isVisible,
                        isRecording: _recorder.isRecording,
                        onProgress: _recorder.onProgress,
                        remainingCharacter:
                            (_textMultiMediaConfiguration.maxCount == 0
                                    ? 30
                                    : _textMultiMediaConfiguration.maxCount) -
                                _describeYourRequestController.value.text
                                    .toString()
                                    .length,
                        onDescribeChanged: (value) {
                          _bloc.add(DescribeRequestValidationEvent(
                            value: value,
                            min: _textMultiMediaConfiguration.minCount,
                          ));
                        },
                        onVideoTap: () {
                          if (selectedVideo != null) {
                            _showActionDialog(
                              icon: ImagePaths.warning,
                              onPrimaryAction: () {
                                _navigateBackEvent();
                              },
                              primaryText: S.of(context).no,
                              onSecondaryAction: () {
                                _navigateBackEvent();
                                _openMediaBottomSheetEvent(MediaType.video);
                              },
                              secondaryText: S.of(context).yes,
                              text: S
                                  .of(context)
                                  .confirmReplacingTheOldVideoWithANewOne,
                            );
                          } else {
                            _openMediaBottomSheetEvent(MediaType.video);
                          }
                        },
                        onGalleryTap: () {
                          if (images.length ==
                              _imageMultiMediaConfiguration.maxCount) {
                            showSnackBar(
                              context: context,
                              message: S
                                  .of(context)
                                  .youHaveReachedTheMaximumImageLimit,
                              color: ColorSchemes.snackBarInfo,
                              icon: ImagePaths.info,
                            );
                          } else {
                            _openMediaBottomSheetEvent(MediaType.image);
                          }
                        },
                        onMicrophoneTap: () {
                          _onTapMicrophone();
                        },
                      ),
                      const SizedBox(height: 16),
                      state is ShowVideoSkeletonState
                          ? _buildVideoSkeleton()
                          : videoPlayerController == null
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
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    color: Colors.grey),
                                                child: InkWell(
                                                  onTap: () {
                                                    _navigateToPlayVideoScreenEvent(
                                                        selectedVideo,
                                                        videoPlayerController!);
                                                  },
                                                  child: SizedBox(
                                                    width: double.infinity,
                                                    height: 150,
                                                    child: thumbnail != null
                                                        ? Image.memory(
                                                            thumbnail!,
                                                            fit: BoxFit.cover,
                                                            width:
                                                                double.infinity,
                                                            height:
                                                                double.infinity,
                                                          )
                                                        : const SizedBox
                                                            .shrink(),
                                                  ),
                                                ),
                                              ),
                                              Positioned.directional(
                                                textDirection:
                                                    Directionality.of(context),
                                                start: 6,
                                                top: -10,
                                                child: InkWell(
                                                  onTap: () {
                                                    _showActionDialog(
                                                      icon: ImagePaths.warning,
                                                      onSecondaryAction: () {
                                                        _navigateBackEvent();
                                                        _bloc.add(
                                                            RemoveVideoEvent());
                                                      },
                                                      onPrimaryAction: () {
                                                        _navigateBackEvent();
                                                      },
                                                      secondaryText:
                                                          S.of(context).yes,
                                                      primaryText:
                                                          S.of(context).no,
                                                      text: S
                                                          .of(context)
                                                          .areYouSureYouWantToDeleteThisVideo,
                                                    );
                                                  },
                                                  child: Container(
                                                    width: 20,
                                                    height: 20,
                                                    decoration:
                                                        const BoxDecoration(
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
                                                selectedVideo,
                                                videoPlayerController!);
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
                                          textDirection:
                                              Directionality.of(context),
                                          child: Text(
                                            formatTime(videoPlayerController!
                                                .value.duration),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                  color: ColorSchemes.white,
                                                ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : const SizedBox.shrink(),
                      ImageWidgets(
                        images: images,
                        imagesMaxNumber: _imageMultiMediaConfiguration.maxCount,
                        imagesMinNumber: _imageMultiMediaConfiguration.minCount,
                        onAddImageTap: () {
                          _openMediaBottomSheetEvent(MediaType.image);
                        },
                        onTapImage: (index) {
                          List<GalleryAttachment> galleryImages = [];
                          for (var image in images) {
                            galleryImages
                                .add(GalleryAttachment(attachment: image.path));
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
                            text: S
                                .of(context)
                                .areYouSureYouWantToDeleteThisImage,
                            primaryText: S.of(context).no,
                            onPrimaryAction: () {
                              _navigateBackEvent();
                            },
                            secondaryText: S.of(context).yes,
                            onSecondaryAction: () {
                              _navigateBackEvent();
                              _removeImageEvent(images, index);
                            },
                          );
                        },
                      ),
                      _audioPath.isEmpty
                          ? const SizedBox.shrink()
                          : AudioWidget(
                              compoundMultiMediaConfiguration:
                                  _audioMultiMediaConfiguration,
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
                                  text: S
                                      .of(context)
                                      .areYouSureYouWantToDeleteThisAudio,
                                );
                              },
                            ),
                      const SizedBox(
                        height: 8,
                      ),
                      _buildPreparedVisitTimeWidget(showSkeleton),
                      Visibility(
                        visible: _preparedVisitTimeErrorMessage.isNotEmpty,
                        child: const SizedBox(
                          height: 8,
                        ),
                      ),
                      Visibility(
                        visible: _preparedVisitTimeErrorMessage.isNotEmpty,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            _preparedVisitTimeErrorMessage,
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      color: ColorSchemes.redError,
                                    ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: CustomButtonWidget(
                          onTap: () {
                            if ((_describeYourRequestController.text.length >=
                                        _textMultiMediaConfiguration.minCount &&
                                    _describeYourRequestController.text
                                        .trim()
                                        .toString()
                                        .isNotEmpty) ||
                                (images.length >=
                                        _imageMultiMediaConfiguration
                                            .minCount &&
                                    images.isNotEmpty) ||
                                _audioPath.isNotEmpty ||
                                selectedVideo != null) {
                              if (_describeYourRequestController.text
                                      .trim()
                                      .toString()
                                      .isEmpty ||
                                  _describeYourRequestController.text.length >=
                                      _textMultiMediaConfiguration.minCount) {
                                bool isSelected = false;
                                for (int i = 0;
                                    i < _preparedVisitTime.length;
                                    i++) {
                                  if (_preparedVisitTime[i].isSelected) {
                                    isSelected = true;
                                    _preparedVisitTimeErrorMessage = "";
                                    break;
                                  } else {
                                    isSelected = false;
                                    _preparedVisitTimeErrorMessage =
                                        S.of(context).thisFieldIsRequired;
                                  }
                                }

                                if ((isSelected ||
                                        _preparedVisitTime.isEmpty) &&
                                    !_recorder.isRecording) {
                                  _bloc.add(
                                    SendSupportRequestEvent(
                                      submitSupportRequest:
                                          SubmitSupportRequest(
                                        description:
                                            _describeYourRequestController.text
                                                .trim(),
                                        categoryId: _selectedSupportService.id,
                                        date: _selectedDate
                                            .toString()
                                            .formattedDateIntoYYYYMD,
                                        timeId: _preparedVisitTime.isNotEmpty
                                            ? _selectedPreparedTime.isSelected
                                                ? _selectedPreparedTime.id
                                                : 0
                                            : -1,
                                        isSupplier: _supportDetailsDate
                                            .supportCategory.isSupplier,
                                        canRequestOnSameDay: _supportDetailsDate
                                            .supportCategory
                                            .rules
                                            .canRequestOnSameDay,
                                        bufferPerDay: _supportDetailsDate
                                            .supportCategory.rules.bufferPerDay,
                                        bufferPerSlot: _supportDetailsDate
                                            .supportCategory
                                            .rules
                                            .bufferPerSlot,
                                        supplierId: _supportDetailsDate
                                            .supportCategory.supplier.id,
                                      ),
                                      supportMultiMediaRequest:
                                          SupportMultiMediaRequest(
                                        imageCode: _imageMultiMediaConfiguration
                                            .multiMediaType.code,
                                        audioCode: _audioMultiMediaConfiguration
                                            .multiMediaType.code,
                                        videoCode: _videoMultiMediaConfiguration
                                            .multiMediaType.code,
                                        images: List<String>.from(
                                          images.map((e) => e.path).toList(),
                                        ).toList(),
                                        videos: selectedVideo != null
                                            ? List<String>.from(
                                                [selectedVideo?.path]).toList()
                                            : [],
                                        audios: _audioPath.isNotEmpty
                                            ? List<String>.from([_audioPath])
                                                .toList()
                                            : [],
                                      ),
                                    ),
                                  );
                                }
                              } else {
                                if (_textMultiMediaConfiguration.minCount ==
                                        0 &&
                                    _textMultiMediaConfiguration.maxCount ==
                                        0) {
                                  _isDescribeYourRequestValid = true;
                                }
                              }
                              setState(() {});
                            } else {
                              for (int i = 0;
                                  i < _preparedVisitTime.length;
                                  i++) {
                                if (_preparedVisitTime[i].isSelected) {
                                  _preparedVisitTimeErrorMessage = "";
                                  break;
                                } else {
                                  _preparedVisitTimeErrorMessage =
                                      S.of(context).thisFieldIsRequired;
                                }
                              }

                              if (_textMultiMediaConfiguration.minCount == 0 &&
                                  _textMultiMediaConfiguration.maxCount == 0) {
                                _isDescribeYourRequestValid = true;
                              }
                              setState(() {});
                              showSnackBar(
                                  context: context,
                                  message: S.of(context).toastMessage,
                                  color: ColorSchemes.snackBarError,
                                  icon: ImagePaths.warning);
                              /*_bloc.add(DescribeRequestValidationEvent(
                                value: _describeYourRequestController.text,
                                min: _textMultiMediaConfiguration.minCount,
                              ));*/
                            }
                          },
                          text: S.of(context).sendRequest,
                          width: double.infinity,
                          height: 50,
                          backgroundColor: F.isNiceTouch
                              ? ColorSchemes.ghadeerDarkBlue
                              : ColorSchemes.primary,
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPreparedVisitTimeWidget(
    bool showSkeleton,
  ) {
    return PreparedVisitTimeWidget(
      selectedDate: _selectedDate,
      showSkeleton: showSkeleton,
      onSelectTimeTap: (selectedPreparedVisitTime) {
        _bloc.add(SelectPreparedVisitTimeEvent(
            preparedVisitTimes: _preparedVisitTime,
            selectedPreparedVisitTime: selectedPreparedVisitTime));
      },
      preparedVisitTime: _preparedVisitTime,
      onDateTap: () {
        if (true) {
          androidDatePicker(
            context: context,
            lastDate: _supportDetailsDate.supportCategory.rules.maxDays != 0
                ? DateTime(DateTime.now().year, DateTime.now().month,
                        DateTime.now().day)
                    .add(Duration(
                        days:
                            _supportDetailsDate.supportCategory.rules.maxDays))
                : DateTime(2100),
            firstDate: _getFirstDate(
                _supportDetailsDate.supportCategory.rules.canRequestOnSameDay
                    ? DateTime(DateTime.now().year, DateTime.now().month,
                        DateTime.now().day)
                    : DateTime(DateTime.now().year, DateTime.now().month,
                            DateTime.now().day)
                        .add(const Duration(days: 1))),
            activeDates: _supportDetailsDate.compoundConfigration.holidays
                .map((e) => DateTime.parse(e.date))
                .where((element) => element.isAfter(DateTime(
                    DateTime.now().year,
                    DateTime.now().month,
                    DateTime.now().day)))
                .toList(),
            onSelectDate: (date) {
              if (date == null || date == _selectedDate) {
                return;
              }
              _bloc.add(
                SelectPreparedTimeVisitDateEvent(
                  selectedDate: date,
                ),
              );
            },
            selectedDate: _selectedDate,
          );
        } else {
          DateTime tempDate = _selectedDate;
          iosDatePicker(
            context: context,
            showDayOfWeek: true,
            selectedDate: DateTime(
                _selectedDate.year, _selectedDate.month, _selectedDate.day),
            minimumDate: DateTime(
                DateTime.now().year, DateTime.now().month, DateTime.now().day),
            onChange: (date) {
              tempDate = date;
            },
            onCancel: () {
              _navigateBackEvent();
            },
            onDone: () {
              if (tempDate != _selectedDate) {
                _bloc.add(
                    SelectPreparedTimeVisitDateEvent(selectedDate: tempDate));
              }
              _navigateBackEvent();
            },
          );
        }
      },
    );
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

  void _addImages(
      List<File> cameraImages, List<File> galleryImages, bool isFromCamera) {
    images.clear();
    if (galleryImages.isNotEmpty) {
      images.addAll(galleryImages);
    }
    if (cameraImages.isNotEmpty && isFromCamera) {
      images.addAll(cameraImages);
    }
    setState(() {});
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

  void _openMediaBottomSheetEvent(MediaType mediaType) {
    return _bloc.add(OpenMediaBottomSheetEvent(mediaType: mediaType));
  }

  void _removeImageEvent(List<File> images, int index) {
    return _bloc.add(RemoveImageEvent(images: images, index: index));
  }

  void _selectSupportServiceEvent(HomeSupport supportService) {
    addDuration = true;
    _bloc.add(SelectSupportServiceEvent(supportService: supportService));
  }

  void _scrollToSupportServiceEvent(HomeSupport supportService) {
    _bloc.add(
      ScrollToSupportServiceEvent(
          supportServices: widget.supportServices,
          supportService: supportService),
    );
  }

  void _navigateBackEvent() {
    _bloc.add(NavigateBackEvent());
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

  void _scrollToElement(int index) {
    _scrollController.animateTo(
      index * 80,
      duration: const Duration(milliseconds: 200),
      curve: Curves.linearToEaseOut,
    );
  }

  void _navigateBack() {
    Navigator.pop(context);
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
          maxAssets:
              _imageMultiMediaConfiguration.maxCount - selectedCameraImages,
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
      final pickedFile = await picker.pickImage(source: img);
      if (pickedFile == null) {
        return;
      }
      XFile? compressedImage = await compressFile(File(pickedFile.path));
      if (compressedImage == null) {
        return;
      }

      _bloc.add(AddImageEvent(image: compressedImage));
    }
  }

  Future<void> _getVideo(
    ImageSource img,
  ) async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickVideo(
        source: img,
        maxDuration: Duration(
          seconds: _videoMultiMediaConfiguration.maxTime,
        ));
    XFile? videoFile =
        XFile(pickedFile!.path, length: await pickedFile.length());

    _bloc.add(AddVideoEvent(video: videoFile, imageSource: img));
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

  String getDayNameFromDate(DateTime? dateTime) {
    if (dateTime == null) return "";

    return DateFormat('EEEE').format(dateTime);
  }

  List<DayTimes> getDayAvailableTimes(String day) {
    if (day.isEmpty) return [];
    try {
      return _supportDetailsDate.supportCategory.rules.days
          .firstWhere((element) {
            return element.name
                    .toLowerCase()
                    .replaceAll("أ", "ا")
                    .replaceAll('ة', 'ه')
                    .toLowerCase() ==
                day.replaceAll("أ", "ا").replaceAll('ة', 'ه').toLowerCase();
          })
          .dayTimes
          .toList();
    } catch (e) {
      return [];
    }
  }

  DateTime _getFirstDate(DateTime date) {
    DateTime firstDate = date;
    while (isDateHoliday(firstDate)) {
      firstDate = firstDate.add(const Duration(days: 1));
    }
    return firstDate;
  }

  bool isDateHoliday(DateTime selectedDate) {
    DateTime today = _supportDetailsDate
            .supportCategory.rules.canRequestOnSameDay
        ? DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day)
        : DateTime(
                DateTime.now().year, DateTime.now().month, DateTime.now().day)
            .add(const Duration(days: 1));
    List<Holidays> holidays =
        _supportDetailsDate.compoundConfigration.holidays.where((holiday) {
      DateTime holidayDate = DateTime.parse(holiday.date);
      return holidayDate.isAfter(today) || holidayDate.isAtSameMomentAs(today);
    }).toList();
    if (holidays.isEmpty) return false;
    for (int i = 0; i < holidays.length; i++) {
      if (DateTime(
              DateTime.parse(holidays[i].date).year,
              DateTime.parse(holidays[i].date).month,
              DateTime.parse(holidays[i].date).day)
          .isAtSameMomentAs(selectedDate)) {
        return true;
      }
    }

    return false;
  }
}

enum MediaType {
  video,
  image,
}
