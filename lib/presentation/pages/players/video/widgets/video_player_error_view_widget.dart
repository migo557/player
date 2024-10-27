import 'package:flutter/material.dart';
import 'package:open_player/logic/video_player_bloc/video_player_bloc.dart';

class VideoPlayerErrorViewWidget extends StatelessWidget {
  const VideoPlayerErrorViewWidget({
    super.key,
    required this.state,
  });

  final VideoPlayerErrorState state;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(state.message),
      ),
    );
  }
}
