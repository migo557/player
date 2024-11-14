import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_player/logic/Control_visibility/controls_visibility_cubit.dart';
import 'package:open_player/logic/video_playback/video_playback_bloc.dart';
import 'package:open_player/logic/video_player_bloc/video_player_bloc.dart';
import 'package:open_player/presentation/common/widgets/custom_brightness_box_widget.dart';
import 'package:open_player/presentation/common/widgets/custom_brightness_shader_mask.dart';
import 'package:open_player/presentation/pages/players/video/widgets/video_player_bottom_widget.dart';
import 'package:open_player/presentation/pages/players/video/widgets/video_player_brightness_controller_widget.dart';
import 'package:open_player/presentation/pages/players/video/widgets/video_player_resume_button_widget.dart';
import 'package:open_player/presentation/pages/players/video/widgets/video_player_top_bar_widget.dart';
import 'package:open_player/presentation/pages/players/video/widgets/video_player_volume_controller_widget.dart';
import 'package:open_player/presentation/pages/players/video/widgets/video_view_widget.dart';

class VideoContentWidget extends StatefulWidget {
  const VideoContentWidget({
    super.key,
    required this.videoPlayerReadyState,
  });

  final VideoPlayerReadyState videoPlayerReadyState;

  @override
  State<VideoContentWidget> createState() => _VideoContentWidgetState();
}

class _VideoContentWidgetState extends State<VideoContentWidget> {
  @override
  void initState() {
    super.initState();
    context.read<VideoPlaybackHiveBloc>().add(InitializeVideoPlaybackEvent(
        path: widget.videoPlayerReadyState.playingVideoPath));
  }

  @override
  void deactivate() {
    context.read<VideoPlaybackHiveBloc>().add(UpdateVideoPlaybackEvent(
        widget
            .videoPlayerReadyState.vlcPlayerController.value.position.inSeconds,
        path: widget.videoPlayerReadyState.playingVideoPath));
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ControlsVisibilityCubit, ControlsVisibilityState>(
      builder: (context, cState) {
        return Stack(
          children: [
            //-------Volume Controller ---------//
               VideoPlayerVolumeControllerWidget(),

            //--------- Brightness Controller------//
            const VideoPlayerBrightnessControllerWidget(),

            //--------- Video Content ---------//
            Center(
              child: CustomBrightnessShaderMask(
                child: VideoViewWidget(state: widget.videoPlayerReadyState),
              ),
            ),

            //------------ Video Top Bar --------------//
            VideoPlayerTopBarWidget(
              state: widget.videoPlayerReadyState,
              cState: cState,
            ),

            //---------- VideoPlayer Bottom Bar Widget //----
            if (cState.showVideoControls && !cState.lockScreenTapping)
              VideoPlayerBottomWidget(state: widget.videoPlayerReadyState),

            //---------- Brightness Box -------//
             const CustomBrightnessBoxWidget(),

            // -------------- Resume where you left Button -----------///
            VideoPlayerResumeButtonWidget(widget: widget),
          ],
        );
      },
    );
  }
}
