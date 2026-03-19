import 'dart:async';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:free_style/utils/common_constants.dart';
import 'package:free_style/utils/common_widgets/common_text/common_text.dart';
import 'package:free_style/utils/common_widgets/loaders/common_loader.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class CommonVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final bool isAsset;

  const CommonVideoPlayer({
    super.key,
    required this.videoUrl,
    this.isAsset = false,
  });

  @override
  State<CommonVideoPlayer> createState() => _CommonVideoPlayerState();
}

class _CommonVideoPlayerState extends State<CommonVideoPlayer> {
  late VideoPlayerController _videoController;
  ChewieController? _chewieController;

  bool _showControls = true;
  Timer? _hideTimer;

  @override
  void initState() {
    super.initState();

    _videoController = widget.isAsset
        ? VideoPlayerController.asset(widget.videoUrl)
        : VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));

    _videoController.initialize().then((_) {
      setState(() {
        _chewieController = ChewieController(
          videoPlayerController: _videoController,
          autoPlay: true,
          looping: false,
          showControls: false,
        );
      });

      _startHideTimer();
    });
  }

  /// ⏱ Auto-hide controls
  void _startHideTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() => _showControls = false);
      }
    });
  }

  void _toggleControls() {
    setState(() => _showControls = !_showControls);

    if (_showControls) {
      _startHideTimer();
    } else {
      _hideTimer?.cancel();
    }
  }

  /// ⏪ Seek Back
  void _seekBackward() {
    final position = _videoController.value.position;
    _videoController.seekTo(position - const Duration(seconds: 10));
  }

  /// ⏩ Seek Forward
  void _seekForward() {
    final position = _videoController.value.position;
    _videoController.seekTo(position + const Duration(seconds: 10));
  }

  /// ▶️ Play / Pause
  void _togglePlay() {
    setState(() {
      _videoController.value.isPlaying
          ? _videoController.pause()
          : _videoController.play();
    });

    _startHideTimer();
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    _videoController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_chewieController == null ||
        !_videoController.value.isInitialized) {
      return const Center(child: CommonLoader());
    }

    return VisibilityDetector(
      key: Key(widget.videoUrl),
      onVisibilityChanged: (info) {
        final visiblePercentage = info.visibleFraction * 100;

        if (visiblePercentage > 50) {
          /// ▶️ PLAY when mostly visible
          if (!_videoController.value.isPlaying) {
            _videoController.play();
          }
        } else {
          /// ⏸ PAUSE when not visible
          if (_videoController.value.isPlaying) {
            _videoController.pause();
          }
        }
      },
      child: GestureDetector(
        onTap: _toggleControls,
        child: Stack(
          alignment: Alignment.center,
          children: [
            /// 🎥 Video
            AspectRatio(
              aspectRatio: _videoController.value.aspectRatio,
              child: Chewie(controller: _chewieController!),
            ),

            /// 🎮 Controls Overlay
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              top: 0,
              child: AnimatedOpacity(
                opacity: _showControls ? 1 : 0,
                duration: const Duration(milliseconds: 300),
                child: Container(
                  color: Colors.black38,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      /// ⏪ Back
                      Positioned(
                        left: size(context).width * numD04,
                        child: IconButton(
                          icon: Icon(Icons.replay_10,
                              color: CommonColors.secondaryColor,
                              size: size(context).width * numD1),
                          onPressed: _seekBackward,
                        ),
                      ),

                      /// ▶️ Play / Pause
                      GestureDetector(
                        onTap: _togglePlay,
                        child: Icon(
                          _videoController.value.isPlaying
                              ? Icons.pause_circle
                              : Icons.play_circle,
                          color: CommonColors.secondaryColor,
                          size: size(context).width * numD18,
                        ),
                      ),

                      /// ⏩ Forward
                      Positioned(
                        right: size(context).width * numD04,
                        child: IconButton(
                          icon: Icon(Icons.forward_10,
                              color: CommonColors.secondaryColor,
                              size: size(context).width * numD1),
                          onPressed: _seekForward,
                        ),
                      ),

                      /// ⏳ Bottom Progress + Time
                      Positioned(
                        bottom: size(context).width * numD04,
                        left: size(context).width * numD04,
                        right: size(context).width * numD04,
                        child: Column(
                          children: [
                            VideoProgressIndicator(
                              _videoController,
                              allowScrubbing: true,
                              colors:  VideoProgressColors(
                                playedColor: CommonColors.secondaryColor,
                                bufferedColor: Colors.white54,
                                backgroundColor: Colors.white30,
                              ),
                            ),
                            SizedBox(height: size(context).width * numD02),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                CommonText(
                                  text: _formatDuration(
                                      _videoController.value.position),
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: size(context).width * numD03,
                                ),

                                CommonText(
                                  text: _formatDuration(
                                      _videoController.value.duration),
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: size(context).width * numD03,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ⏱ Format Duration
  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  VideoPlayerController get controller => _videoController;

  ChewieController? get chewie => _chewieController;
}