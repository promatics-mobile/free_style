import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:free_style/utils/common_widgets/loaders/common_loader.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CommonWebVideoPlayer extends StatefulWidget {
  final String videoUrl;

  const CommonWebVideoPlayer({super.key, required this.videoUrl});

  @override
  State<CommonWebVideoPlayer> createState() => _CommonWebVideoPlayerState();
}

class _CommonWebVideoPlayerState extends State<CommonWebVideoPlayer> {
  WebViewController? _webController;
  YoutubePlayerController? videoPlayerController;

  bool get isYoutube =>
      widget.videoUrl.contains("youtube.com") ||
      widget.videoUrl.contains("youtu.be") ||
      widget.videoUrl.contains("shorts");

  @override
  void initState() {
    super.initState();

    if (isYoutube) {
      videoPlayerController = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.videoUrl)!,
        flags: YoutubePlayerFlags(autoPlay: true, mute: false, showLiveFullscreenButton: false),
      );
    } else {
      final html = _buildHtml(widget.videoUrl);
      _webController = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(Colors.black)
        ..loadHtmlString(html);
    }
  }

  String _buildHtml(String url) {
    return '''
    <!DOCTYPE html>
    <html>
    <head>
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <style>
        body {
          margin: 0;
          background-color: black;
          display: flex;
          justify-content: center;
          align-items: center;
          height: 100vh;
        }
        video {
          width: 100%;
          height: 100%;
        }
      </style>
    </head>
    <body>
      ${_getVideoElement(url)}
    </body>
    </html>
    ''';
  }

  String _getVideoElement(String url) {
    /// ✅ MP4
    if (url.toLowerCase().endsWith(".mp4")) {
      return '''
      <video controls autoplay playsinline>
        <source src="$url" type="video/mp4">
      </video>
    ''';
    }

    /// ✅ fallback iframe
    return '''
    <iframe 
      src="$url"
      frameborder="0"
      allow="autoplay"
      allowfullscreen>
    </iframe>
    ''';
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
    videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
    videoPlayerController!.pause();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    /// ✅ YouTube Player
    if (isYoutube && videoPlayerController != null) {
      return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: videoPlayerController!,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.yellow,
          topActions: <Widget>[
            const SizedBox(width: 8.0),
            IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.yellow),
              onPressed: () {
                SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
                Navigator.pop(context);
              },
            ),
          ],
          onReady: () {},
          onEnded: (data) {
            SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
            SystemChrome.setEnabledSystemUIMode(
              SystemUiMode.manual,
              overlays: [SystemUiOverlay.top],
            );
            videoPlayerController!.reset();
          },
        ),
        builder: (context, player) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.orange),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Center(child: player),
        ),
      );
    }

    /// ✅ WebView Player
    if (_webController != null) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: WebViewWidget(controller: _webController!),
      );
    }

    return const Center(child: CommonLoader());
  }
}
