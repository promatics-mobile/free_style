import 'package:flutter/material.dart';

class VideoProgressBar extends StatelessWidget {
  final double progress;

  const VideoProgressBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: progress,
      minHeight: 6,
      backgroundColor: Colors.white30,
      valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
    );
  }
}