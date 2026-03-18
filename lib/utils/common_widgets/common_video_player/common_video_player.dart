import 'dart:async';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

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
      return const Center(child: CircularProgressIndicator());
    }

    return GestureDetector(
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
          AnimatedOpacity(
            opacity: _showControls ? 1 : 0,
            duration: const Duration(milliseconds: 300),
            child: Container(
              color: Colors.black38,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  /// ⏪ Back
                  Positioned(
                    left: 20,
                    child: IconButton(
                      icon: const Icon(Icons.replay_10,
                          color: Colors.white, size: 32),
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
                      color: Colors.white,
                      size: 70,
                    ),
                  ),

                  /// ⏩ Forward
                  Positioned(
                    right: 20,
                    child: IconButton(
                      icon: const Icon(Icons.forward_10,
                          color: Colors.white, size: 32),
                      onPressed: _seekForward,
                    ),
                  ),

                  /// ⏳ Bottom Progress + Time
                  Positioned(
                    bottom: 10,
                    left: 10,
                    right: 10,
                    child: Column(
                      children: [
                        VideoProgressIndicator(
                          _videoController,
                          allowScrubbing: true,
                          colors: const VideoProgressColors(
                            playedColor: Colors.red,
                            bufferedColor: Colors.white54,
                            backgroundColor: Colors.white30,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _formatDuration(
                                  _videoController.value.position),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12),
                            ),
                            Text(
                              _formatDuration(
                                  _videoController.value.duration),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12),
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
        ],
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