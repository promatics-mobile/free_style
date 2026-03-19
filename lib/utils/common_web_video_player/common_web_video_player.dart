import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CommonWebVideoPlayer extends StatefulWidget {
  final String videoUrl;

  const CommonWebVideoPlayer({super.key, required this.videoUrl});

  @override
  State<CommonWebVideoPlayer> createState() => _CommonWebVideoPlayerState();
}

class _CommonWebVideoPlayerState extends State<CommonWebVideoPlayer> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    final html = _buildHtml(widget.videoUrl);

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.black)
      ..loadHtmlString(html);
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
        iframe {
          width: 100%;
          height: 100%;
          border: none;
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
    /// ✅ YouTube
    if (url.contains("youtube.com") || url.contains("youtu.be")) {
      final videoId = Uri.parse(url).queryParameters['v'] ??
          Uri.parse(url).pathSegments.last;

      return '''
      <iframe 
        src="https://www.youtube.com/embed/$videoId?autoplay=1&playsinline=1"
        frameborder="0"
        allow="autoplay; encrypted-media"
        allowfullscreen>
      </iframe>
    ''';
    }

    /// ✅ Direct MP4 ONLY
    if (url.toLowerCase().endsWith(".mp4")) {
      return '''
      <video controls autoplay playsinline>
        <source src="$url" type="video/mp4">
      </video>
    ''';
    }

    /// ❌ Fallback (IMPORTANT)
    return '''
    <iframe 
      src="$url"
      frameborder="0"
      allowfullscreen>
    </iframe>
  ''';
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: WebViewWidget(controller: _controller),
    );
  }
}