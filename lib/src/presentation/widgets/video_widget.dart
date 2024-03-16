import 'dart:io';
import 'dart:typed_data';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoWidget extends StatefulWidget {
  final File? video;
  final VideoPlayerController? videoController;
  final Function() onClearVideoTap;

  const VideoWidget({
    Key? key,
    required this.video,
    required this.videoController,
    required this.onClearVideoTap,
  }) : super(key: key);

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  bool isVideoPlaying = false;

  @override
  void initState() {
    widget.videoController!.addListener(() {
      if (widget.videoController!.value.position ==
          widget.videoController!.value.duration) {
        isVideoPlaying = false;
      } else {
        isVideoPlaying = true;
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).video,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: ColorSchemes.black,
                  letterSpacing: -0.24,
                ),
          ),
          const SizedBox(
            height: 26,
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: double.infinity,
                height: 150,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8), color: Colors.red),
                child: AspectRatio(
                  aspectRatio: widget.videoController!.value.aspectRatio * 2,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      VideoPlayer(
                        widget.videoController!,
                      ),
                      if (!isVideoPlaying)
                        SizedBox(
                          height: 150,
                          child: FutureBuilder<Uint8List?>(
                            future: _generateThumbnail(),
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
                                return const Icon(Icons.error);
                              } else {
                                return const CircularProgressIndicator();
                              }
                            },
                          ),
                        ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          widget.videoController!.value.isPlaying
                              ? widget.videoController!.pause()
                              : widget.videoController!.play();
                          setState(() {});
                        },
                        child: Stack(
                          children: <Widget>[
                            _buildPlay(),
                            Positioned(
                                left: 8,
                                bottom: 28,
                                child: StreamBuilder<String>(
                                    stream: getVideoPosition(),
                                    builder: (context, snapshot) {
                                      return Text(snapshot.data ?? "");
                                    })),
                            Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Row(
                                  children: [
                                    Expanded(child: _buildIndicator()),
                                    const SizedBox(width: 12),
                                    const SizedBox(width: 8),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned.directional(
                textDirection: Directionality.of(context),
                start: 6,
                top: -10,
                child: InkWell(
                  onTap: () {
                    widget.onClearVideoTap();
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
          const SizedBox(
            height: 16,
          ),
          Container(
            height: 1,
            color: ColorSchemes.border,
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }

  Stream<String> getVideoPosition() async* {
    while (widget.videoController!.value.isPlaying) {
      final duration = Duration(
          milliseconds:
              widget.videoController!.value.position.inMilliseconds.round());
      yield [duration.inMinutes, duration.inSeconds]
          .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
          .join(':');
      await Future.delayed(const Duration(seconds: 1));
    }

    final duration = Duration(
        milliseconds:
            widget.videoController!.value.position.inMilliseconds.round());
    yield [duration.inMinutes, duration.inSeconds]
        .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
        .join(':');
  }

  Widget _buildIndicator() => Container(
        margin: const EdgeInsets.all(8).copyWith(right: 0),
        height: 16,
        child: VideoProgressIndicator(
          widget.videoController!,
          allowScrubbing: true,
        ),
      );

  Widget _buildPlay() => AnimatedSwitcher(
        duration: const Duration(milliseconds: 50),
        reverseDuration: const Duration(milliseconds: 200),
        child: Container(
          color: Colors.black26,
          child: Center(
            child: SvgPicture.asset(
              fit: BoxFit.scaleDown,
              _isPlayIcon(widget.videoController!.value.isPlaying),
              color: Colors.white,
              width: 45,
              height: 45,
            ),
          ),
        ),
      );

  String _isPlayIcon(bool isPlaying) {
    if (isPlaying) {
      setState(() {});
      return ImagePaths.pause;
    } else {
      setState(() {});
      return ImagePaths.play;
    }
  }

  Future<Uint8List?> _generateThumbnail() async {
    final uint8list = await VideoThumbnail.thumbnailData(
      video: widget.video!.path,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 128,
      quality: 25,
    );
    return uint8list;
  }
}
