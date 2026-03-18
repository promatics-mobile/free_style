import 'dart:async';
import 'dart:ui';
import 'package:camera/camera.dart';

class VideoRecorderController {
  CameraController? cameraController;
  List<CameraDescription>? cameras;

  bool isRecording = false;
  double progress = 0.0;

  Timer? _timer;
  int maxDuration = 15; // seconds
  int currentDuration = 0;

  Future<void> init() async {
    cameras = await availableCameras();
    cameraController = CameraController(
      cameras![0],
      ResolutionPreset.high,
    );
    await cameraController!.initialize();
  }

  Future<void> startRecording(VoidCallback onUpdate) async {
    if (cameraController == null) return;

    await cameraController!.startVideoRecording();
    isRecording = true;
    currentDuration = 0;
    progress = 0;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      currentDuration++;
      progress = currentDuration / maxDuration;

      onUpdate();

      if (currentDuration >= maxDuration) {
        stopRecording();
      }
    });
  }

  Future<XFile?> stopRecording() async {
    if (!isRecording) return null;

    _timer?.cancel();
    isRecording = false;

    final file = await cameraController!.stopVideoRecording();
    return file;
  }

  Future<void> switchCamera() async {
    if (cameras == null || cameras!.length < 2) return;

    final currentLens = cameraController!.description.lensDirection;

    final newCamera = cameras!.firstWhere(
          (camera) => camera.lensDirection != currentLens,
    );

    cameraController = CameraController(
      newCamera,
      ResolutionPreset.high,
    );

    await cameraController!.initialize();
  }

  void dispose() {
    _timer?.cancel();
    cameraController?.dispose();
  }
}