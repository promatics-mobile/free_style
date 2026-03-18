import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class VideoRecorderWidget extends StatefulWidget {
  final Function(String path)? onVideoRecorded;
  final int maxDurationSecond;

  const VideoRecorderWidget({
    super.key,
    this.onVideoRecorded,
    required this.maxDurationSecond,
  });

  @override
  State<VideoRecorderWidget> createState() => _VideoRecorderWidgetState();
}

class _VideoRecorderWidgetState extends State<VideoRecorderWidget> {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;

  bool isRecording = false;

  Timer? _timer;

  int currentDuration = 0;
  double progress = 0;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    _cameras = await availableCameras();

    _cameraController = CameraController(
      _cameras![0],
      ResolutionPreset.high,
    );

    await _cameraController!.initialize();
    if (mounted) setState(() {});
  }

  Future<void> _startRecording() async {
    if (_cameraController == null) return;

    await _cameraController!.startVideoRecording();

    isRecording = true;
    currentDuration = 0;
    progress = 0;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      currentDuration++;
      progress = currentDuration / widget.maxDurationSecond;

      if (mounted) setState(() {});

      if (currentDuration >= widget.maxDurationSecond) {
        final file = await _stopRecording();
        if (file != null) {
          widget.onVideoRecorded?.call(file.path);
        }
      }
    });

    setState(() {});
  }

  Future<XFile?> _stopRecording() async {
    if (!isRecording || _cameraController == null) return null;

    _timer?.cancel();
    isRecording = false;

    final file = await _cameraController!.stopVideoRecording();

    if (mounted) setState(() {});
    return file;
  }

  Future<void> _switchCamera() async {
    if (_cameras == null || _cameras!.length < 2) return;

    final currentLens = _cameraController!.description.lensDirection;

    final newCamera = _cameras!.firstWhere(
          (camera) => camera.lensDirection != currentLens,
    );

    _cameraController = CameraController(
      newCamera,
      ResolutionPreset.high,
    );

    await _cameraController!.initialize();
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _timer?.cancel();
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_cameraController == null ||
        !_cameraController!.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Stack(
      children: [
        /// 📷 Camera Preview
        CameraPreview(_cameraController!),

        /// 🔴 Progress Bar
        Positioned(
          top: 40,
          left: 20,
          right: 20,
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 6,
            backgroundColor: Colors.white30,
            valueColor:
            const AlwaysStoppedAnimation<Color>(Colors.red),
          ),
        ),

        /// 🎮 Controls
        Positioned(
          bottom: 40,
          left: 20,
          right: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// 🔄 Switch Camera
              IconButton(
                icon: const Icon(Icons.cameraswitch,
                    color: Colors.white, size: 30),
                onPressed: _switchCamera,
              ),

              /// 🔴 Record Button
              GestureDetector(
                onTap: () async {
                  if (isRecording) {
                    final file = await _stopRecording();

                    if (file != null) {
                      widget.onVideoRecorded?.call(file.path);
                    }
                  } else {
                    await _startRecording();
                  }
                },
                child: CircleAvatar(
                  radius: 32,
                  backgroundColor:
                  isRecording ? Colors.red : Colors.white,
                  child: isRecording
                      ? const Icon(Icons.stop, color: Colors.white)
                      : const Icon(Icons.fiber_manual_record,
                      color: Colors.red),
                ),
              ),

              /// ⏱ Timer
              Text(
                "$currentDuration s",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}