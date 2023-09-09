import 'package:flutter/material.dart';
import 'package:video_viewer/video_viewer.dart';

class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  final VideoViewerController controller = VideoViewerController();

  @override
  Widget build(BuildContext context) {
    return VideoViewer(
      controller: controller,
      source: {
        "SubRip Text": VideoSource(
          video: VideoPlayerController.network(
              "https://www.speechpad.com/proxy/get/marketing/samples/standard-captions-example.mp4"),
          subtitle: {
            "English": VideoViewerSubtitle.network(
              "https://felipemurguia.com/assets/txt/WEBVTT_English.txt",
              type: SubtitleType.webvtt,
            ),
          },
        )
      },
    );
  }
}
