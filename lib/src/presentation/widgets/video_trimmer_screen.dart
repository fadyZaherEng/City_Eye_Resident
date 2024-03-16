import 'dart:io';
import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/show_action_dialog_widget.dart';
import 'package:city_eye/src/core/utils/show_massage_dialog_widget.dart';
import 'package:city_eye/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:city_eye/src/presentation/widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:video_trimmer/video_trimmer.dart';

class VideoTrimmerScreen extends StatefulWidget {
  final File file;
  final int maxDuration;

  const VideoTrimmerScreen({
    Key? key,
    required this.file,
    required this.maxDuration,
  }) : super(key: key);

  @override
  State<VideoTrimmerScreen> createState() => _VideoTrimmerScreenState();
}

class _VideoTrimmerScreenState extends State<VideoTrimmerScreen> {
  final Trimmer _trimmer = Trimmer();

  double _startValue = 0.0;
  double _endValue = 0.0;
  double _initailStartValue = 0.0;
  double _initialEndValue = 0.0;

  bool _isPlaying = false;
  bool _progressVisibility = false;

  Future<String?> _saveVideo() async {
    setState(() {
      _progressVisibility = true;
    });

    String? _value;

    await _trimmer
        .saveTrimmedVideo(
            startValue: _startValue,
            endValue: _endValue,
            onSave: (String? outputPath) {
              _value = outputPath;
              Navigator.pop(context, _value);
            })
        .then((value) {
      setState(() {
        _progressVisibility = false;
      });
    });

    return _value;
  }

  void _loadVideo() {
    _trimmer.loadVideo(videoFile: widget.file);
  }

  @override
  void initState() {
    super.initState();

    _loadVideo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          buildAppBarWidget(
            context,
            title: S.of(context).videoTrimmer,
            isHaveBackButton: true,
            onBackButtonPressed: () {
              if (_startValue == _initailStartValue &&
                  _endValue == _initialEndValue) {
                _navigateBack();
              } else {
                showActionDialogWidget(
                    context: context,
                    text: S.of(context).thereAreChangesAppliedToTheVideo,
                    icon: ImagePaths.warning,
                    primaryText: S.of(context).save,
                    secondaryText: S.of(context).discard,
                    primaryAction: () async {
                      if (!_progressVisibility) {
                        if (Duration(
                                    milliseconds:
                                        (_endValue - _startValue).toInt())
                                .inSeconds >
                            30) {
                          _navigateBack();
                          _showMessageDialog();
                        } else {
                          await _saveVideo();
                          _navigateBack();
                        }
                      }
                    },
                    secondaryAction: () {
                      _navigateBack();
                      _navigateBack();
                    });
              }
            },
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(child: VideoViewer(trimmer: _trimmer)),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 100,
            child: TrimViewer(
              trimmer: _trimmer,
              viewerHeight: 60.0,
              showDuration: true,
              durationStyle: DurationStyle.FORMAT_HH_MM_SS,
              durationTextStyle: TextStyle(color: Colors.black),
              viewerWidth: MediaQuery.of(context).size.width,
              onChangeStart: (value) {
                _startValue = value;
              },
              onChangeEnd: (value) {
                _endValue = value;
                if (_initialEndValue == 0.0) {
                  _initialEndValue = value;
                }
              },
              onChangePlaybackState: (value) =>
                  setState(() => _isPlaying = value),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: CustomButtonWidget(
                    height: 45,
                    textColor: ColorSchemes.black,
                    backgroundColor: ColorSchemes.white,
                    text: S.of(context).cancel,
                    borderColor: ColorSchemes.lightGray,
                    onTap: () {
                      _navigateBack();
                    },
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: CustomButtonWidget(
                    height: 45,
                    textColor: ColorSchemes.white,
                    backgroundColor: ColorSchemes.primary,
                    text: S.of(context).save,
                    borderColor: ColorSchemes.lightGray,
                    onTap: () async {
                      if (!_progressVisibility) {
                        if (Duration(
                                    milliseconds:
                                        (_endValue - _startValue).toInt())
                                .inSeconds >
                            widget.maxDuration) {
                          _showMessageDialog();
                        } else {
                          await _saveVideo();
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _showMessageDialog() {
    showMassageDialogWidget(
        context: context,
        text:
            "${S.of(context).keepItShortAndSweetVideosAreBestAt} ${widget.maxDuration} ${S.of(context).secondsOrLessThanks}",
        icon: ImagePaths.frame,
        buttonText: S.current.ok,
        onTap: () {
          _navigateBack();
        });
  }

  void _navigateBack() {
    Navigator.pop(context);
  }
}
