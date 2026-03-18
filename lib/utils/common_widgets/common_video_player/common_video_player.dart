import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CommonVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final bool isAsset;

  const CommonVideoPlayer({super.key, required this.videoUrl, this.isAsset = false});

  @override
  State<CommonVideoPlayer> createState() => _CommonVideoPlayerState();
}

class _CommonVideoPlayerState extends State<CommonVideoPlayer> {
  late VideoPlayerController _videoController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _videoController = widget.isAsset
        ? VideoPlayerController.asset(widget.videoUrl)
        : VideoPlayerController.network(widget.videoUrl);
    _videoController.initialize().then((_) {
      setState(() {
        _chewieController = ChewieController(
          videoPlayerController: _videoController,
          autoPlay: true,
          looping: false,
          showControls: false,
        );
      });
    });
  }

  @override
  void dispose() {
    _videoController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    if (_chewieController == null || !_videoController.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        AspectRatio(
          aspectRatio: _videoController.value.aspectRatio,
          child: Chewie(controller: _chewieController!),
        ),

        Positioned(
          left: 20,
          child: IconButton(
            icon: const Icon(Icons.replay_10, color: Colors.white, size: 30),
            onPressed: () {
              final position = _videoController.value.position;
              _videoController.seekTo(position - const Duration(seconds: 10));
            },
          ),
        ),

        GestureDetector(
          onTap: () {
            setState(() {
              _videoController.value.isPlaying ? _videoController.pause() : _videoController.play();
            });
          },
          child: Icon(
            _videoController.value.isPlaying ? Icons.pause_circle : Icons.play_circle,
            color: Colors.white,
            size: 60,
          ),
        ),

        Positioned(
          right: 20,
          child: IconButton(
            icon: const Icon(Icons.forward_10, color: Colors.white, size: 30),
            onPressed: () {
              final position = _videoController.value.position;
              _videoController.seekTo(position + const Duration(seconds: 10));
            },
          ),
        ),
      ],
    );
  }

  VideoPlayerController get controller => _videoController;

  ChewieController? get chewie => _chewieController;
}
