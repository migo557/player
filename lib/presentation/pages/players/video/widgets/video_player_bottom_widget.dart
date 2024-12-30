// video_player/presentation/pages/video_player_page.dart


import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:open_player/logic/video_player_bloc/video_player_bloc.dart';
import 'package:open_player/presentation/pages/players/video/widgets/video_player_forward_button_widget.dart';
import 'package:open_player/presentation/pages/players/video/widgets/video_player_play_pause_button_widget.dart';
import 'package:open_player/presentation/pages/players/video/widgets/video_player_progress_bar_widget.dart';
import 'package:open_player/presentation/pages/players/video/widgets/video_player_replay_button_widget.dart';
import 'package:open_player/presentation/pages/players/video/widgets/video_player_speed_button_widget.dart';
import 'package:open_player/presentation/pages/players/video/widgets/video_player_subtitles_selector_widget.dart';


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
      height: 130,
      child: FadeInUp(
        child: Container(
          decoration: _decoration(
            
          ),
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
          Colors.black12.withValues(alpha: 0.6),
          Colors.black12.withValues(alpha: 0.5),
          Colors.black12.withValues(alpha: 0.07),
   
        ],
      ),
    );
  }
}
