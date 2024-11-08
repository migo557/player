// video_player/presentation/pages/video_player_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_player/logic/video_player_bloc/video_player_bloc.dart';
import 'package:open_player/presentation/pages/players/video/widgets/video_player_icon_button_widget.dart';

import '../../../../../logic/Control_visibility/controls_visibility_cubit.dart';

class VideoPlayerReplayButtonWidget extends StatelessWidget {
  const VideoPlayerReplayButtonWidget({
    super.key,
    required this.state,
  });

  final VideoPlayerReadyState state;

  @override
  Widget build(BuildContext context) {
    return VideoPlayerIconButtonWidget(
      icon: Icons.replay_10,
      onTap: () {
        Duration position =
            state.vlcPlayerController.value.position;
         state.vlcPlayerController.seekTo(
          Duration(seconds: position.inSeconds - 10),
        );

        context.read<ControlsVisibilityCubit>().toggleVideoControlsVisibilty();
      },
    );
  }
}
