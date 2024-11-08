// video_player/presentation/pages/video_player_page.dart

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:open_player/logic/video_player_bloc/video_player_bloc.dart';
import 'package:open_player/presentation/pages/players/video/widgets/video_player_forward_button_widget.dart';
import 'package:open_player/presentation/pages/players/video/widgets/video_player_icon_button_widget.dart';
import 'package:open_player/presentation/pages/players/video/widgets/video_player_play_pause_button_widget.dart';
import 'package:open_player/presentation/pages/players/video/widgets/video_player_progress_bar_widget.dart';
import 'package:open_player/presentation/pages/players/video/widgets/video_player_replay_button_widget.dart';
import 'package:open_player/presentation/pages/players/video/widgets/video_player_speed_button_widget.dart';

import '../../../../../logic/Control_visibility/controls_visibility_cubit.dart';

class VideoPlayerBottomWidget extends StatelessWidget {
  const VideoPlayerBottomWidget({
    super.key,
    required this.state,
  });

  final VideoPlayerReadyState state;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.sizeOf(context);
    return Positioned(
      bottom: 0,
      width: mq.width,
      height: 150,
      child: FadeInUp(
        child: Column(
          children: [
            //---------- SeekBar & PositionDuration Text ------//
            VideoPlayerProgressBarWidget(
              state: state,
            ),
            Gap(10),
            //----------- Player Buttons -------------///
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                VideoPlayerIconButtonWidget(
                    icon: Icons.cast,
                    onTap: () {
                      context
                          .read<ControlsVisibilityCubit>()
                          .toggleVideoControlsVisibilty();
                    }),
                VideoPlayerReplayButtonWidget(state: state),
                //--- PlayPause Button
                VideoPlayerPlayPauseButtonWidget(
                  state: state,
                ),
                VideoPlayerForwardButtonWidget(state: state),
                VideoPlayerSpeedButtonWidget(
                  state: state,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
