// video_player/presentation/pages/video_player_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:open_player/logic/video_player_bloc/video_player_bloc.dart';

class VideoViewWidget extends StatelessWidget {
  const VideoViewWidget({
    super.key,
    required this.state,
  });

  final VideoPlayerReadyState state;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: VlcPlayer(
          controller: state.vlcPlayerController, aspectRatio: 16 / 9),
    );
  }
}
