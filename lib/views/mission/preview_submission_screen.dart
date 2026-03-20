import 'dart:io';

import 'package:flutter/material.dart';
import 'package:free_style/utils/common_widgets/loaders/common_loader.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../generated/assets.dart';
import '../../routes/route.dart';
import '../../utils/common_constants.dart';
import '../../utils/common_decorations/common_decorations.dart';
import '../../utils/common_widgets/common_button/common_button.dart';
import '../../utils/common_widgets/common_button/common_gradient_button.dart';
import '../../utils/common_widgets/common_image/common_image.dart';
import '../../utils/common_widgets/common_text/common_text.dart';
import '../../utils/common_widgets/linear_progress_indicator/custom_linear_progress.dart';

class PreviewSubmissionScreen extends StatefulWidget {
  final String videoPath;
  final bool isNetwork;

  const PreviewSubmissionScreen({super.key, required this.videoPath, this.isNetwork = false});

  @override
  State<PreviewSubmissionScreen> createState() => _PreviewSubmissionScreenState();
}

class _PreviewSubmissionScreenState extends State<PreviewSubmissionScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = widget.isNetwork
        ? VideoPlayerController.networkUrl(Uri.parse(widget.videoPath))
        : VideoPlayerController.file(File(widget.videoPath));

    _controller.initialize().then((_) {
      setState(() {});
    });

    _controller.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String format(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$m:$s";
  }

  @override
  Widget build(BuildContext context) {
    final width = size(context).width;

    return Scaffold(
      body: _controller.value.isInitialized
          ? VisibilityDetector(
              key: Key(widget.videoPath),
              onVisibilityChanged: (info) {
                final visiblePercentage = info.visibleFraction * 100;

                if (visiblePercentage > 50) {
                  /// ▶️ PLAY when mostly visible
                  if (!_controller.value.isPlaying) {
                    _controller.play();
                  }
                } else {
                  /// ⏸ PAUSE when not visible
                  if (_controller.value.isPlaying) {
                    _controller.pause();
                  }
                }
              },
              child: SizedBox(
                height: size(context).height,
                width: width,
                child: Stack(
                  children: [
                    /// 🎥 VIDEO BACKGROUND
                    SizedBox.expand(
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          width: _controller.value.size.width,
                          height: _controller.value.size.height,
                          child: VideoPlayer(_controller),
                        ),
                      ),
                    ),

                    /// 🔝 TOP UI
                    Positioned(
                      left: width * numD04,
                      top: width * numD07,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_back, color: Colors.white),
                                onPressed: () => router.pop(),
                              ),
                              CommonText(
                                text: "Preview Submission",
                                fontSize: width * numD045,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                          /*Container(
                            decoration: commonBgColorDecoration(width * numD03, Colors.black38),
                            padding: EdgeInsets.symmetric(
                              horizontal: width * numD03,
                              vertical: width * numD01,
                            ),
                            margin: EdgeInsets.only(left: width * numD03),
                            child: Row(
                              children: [
                                CircleAvatar(radius: width * numD012, backgroundColor: Colors.red),
                                CommonText(
                                  text: " Battle vs Kim Skatter ${CommonSymbol.dotSymbol} 14h 23m Left",
                                  fontSize: width * numD028,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),*/
                        ],
                      ),
                    ),

                    /// ▶️ PLAY BUTTON
                    if (!_controller.value.isPlaying)
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            _controller.play();
                            setState(() {});
                          },
                          child: Container(
                            width: width * numD15,
                            height: width * numD15,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(width),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.grey.shade700,
                                  const Color(0xFF1F1C3A),
                                  CommonColors.themeColor,
                                ],
                              ),
                            ),
                            padding: EdgeInsets.all(width * numD04),
                            child: CommonImage(imagePath: Assets.iconsIcPlay, isNetwork: false)
                          ),
                        ),
                      ),

                    /// ⏬ BOTTOM CONTROLS
                    Positioned(
                      bottom: width * numD04,
                      left: width * numD04,
                      right: width * numD04,
                      child: Column(
                        children: [
                          /// ⏱ TIME
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CommonText(
                                text: format(_controller.value.position),
                                color: Colors.white,
                              ),
                              CommonText(
                                text: format(_controller.value.duration),
                                color: Colors.white,
                              ),
                            ],
                          ),

                          SizedBox(height: width * numD04),

                          /// 📊 PROGRESS
                          commonNormalLinearProgress(
                            context: context,
                            value: _controller.value.duration.inSeconds == 0
                                ? 0
                                : _controller.value.position.inSeconds /
                                      _controller.value.duration.inSeconds,
                            bgColor: Colors.white,
                            valueColor: CommonColors.buttonColor,
                          ),

                          SizedBox(height: width * numD04),


                          /// ℹ️ INFO BOX
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(width * numD03),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.grey.shade700,
                                  const Color(0xFF1F1C3A),
                                  CommonColors.themeColor,
                                ],
                              ),
                            ),
                            padding: EdgeInsets.all(width * numD02),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.info_outline, color: Colors.white),
                                SizedBox(width: width * numD02),
                                Expanded(
                                  child: CommonText(
                                    text:
                                        "Ensure your trick is completely visible without any cuts.",
                                    fontSize: width * numD035,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : const Center(child: CommonLoader()),
    );
  }
}
