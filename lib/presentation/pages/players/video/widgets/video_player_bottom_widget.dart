// video_player/presentation/pages/video_player_page.dart

import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:gap/gap.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:open_player/logic/video_player_bloc/video_player_bloc.dart';
import 'package:open_player/presentation/pages/players/video/widgets/video_player_forward_button_widget.dart';
import 'package:open_player/presentation/pages/players/video/widgets/video_player_icon_button_widget.dart';
import 'package:open_player/presentation/pages/players/video/widgets/video_player_play_pause_button_widget.dart';
import 'package:open_player/presentation/pages/players/video/widgets/video_player_progress_bar_widget.dart';
import 'package:open_player/presentation/pages/players/video/widgets/video_player_replay_button_widget.dart';
import 'package:open_player/presentation/pages/players/video/widgets/video_player_speed_button_widget.dart';
import 'package:open_player/presentation/pages/players/video/widgets/video_player_subtitles_button_widget.dart';
import 'package:velocity_x/velocity_x.dart';

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
        child: Container(
          decoration: _decoration(),
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
                  //----- Subtitles Button
                  IconButton(
                    color: Colors.white,
                    icon: Icon(Icons.subtitles),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) =>
                            VideoPlayerSubtitlesSelector(state: state),
                      );
                    },
                  ),
                  //---- Previous/Replay Button
                  VideoPlayerReplayButtonWidget(state: state),
                  //--- PlayPause Button
                  VideoPlayerPlayPauseButtonWidget(
                    state: state,
                  ),

                  //----- Forward Button
                  VideoPlayerForwardButtonWidget(state: state),
                  //--- Speed Button
                  VideoPlayerSpeedButtonWidget(
                    state: state,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  //-------- Decoration ----------//
  BoxDecoration _decoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [
          Colors.black12.withOpacity(0.6),
          Colors.black12.withOpacity(0.5),
          Colors.black12.withOpacity(0.07),
        ],
      ),
    );
  }
}
