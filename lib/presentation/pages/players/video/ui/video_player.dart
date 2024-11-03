// import 'package:floating/floating.dart';
import 'package:flutter/material.dart';

/// Widget that displays the video player screen
class VideoPlayerPage extends StatefulWidget {
  // final int videoIndex;
  // final List<VideoModel> playlist;

  const VideoPlayerPage({
    super.key,
    // required this.videoIndex,
    // required this.playlist,
  });

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  void _initializeVideo() {}

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Text("VideoPlayer"),
        ),
      ),
    );
  }
}
