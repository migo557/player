import 'package:flutter/material.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:open_player/logic/video_player_bloc/video_player_bloc.dart';

class VideoViewWidget extends StatelessWidget {
  const VideoViewWidget({
    super.key,
    required this.state,
  });
  final VideoPlayerReadyState state;
  @override
  Widget build(BuildContext context) {
    
    return    Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 2),
      child: Video(
        controller: state.controller,
        controls: MaterialVideoControls,
        subtitleViewConfiguration: SubtitleViewConfiguration(
          textScaleFactor: 1,
          visible: state.settings.showSubtitles,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
            backgroundColor: Colors.black54,
          ),
          padding: const EdgeInsets.only(bottom: 50),
        ),
      ),
    );
  }
}
