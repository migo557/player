import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_player/logic/Control_visibility/controls_visibility_cubit.dart';
import 'package:open_player/logic/video_player_bloc/video_player_bloc.dart';
import 'package:open_player/presentation/common/widgets/custom_brightness_box_widget.dart';
import 'package:open_player/presentation/common/widgets/custom_brightness_shader_mask.dart';
import 'package:open_player/presentation/pages/players/video/widgets/video_player_bottom_widget.dart';
import 'package:open_player/presentation/pages/players/video/widgets/video_player_brightness_controller_widget.dart';
import 'package:open_player/presentation/pages/players/video/widgets/video_player_top_bar_widget.dart';
import 'package:open_player/presentation/pages/players/video/widgets/video_player_volume_controller_widget.dart';
import 'package:open_player/presentation/pages/players/video/widgets/video_view_widget.dart';

class VideoContentWidget extends StatelessWidget {
  const VideoContentWidget({
    super.key,
    required this.videoPlayerReadyState,
  });

  final VideoPlayerReadyState videoPlayerReadyState;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ControlsVisibilityCubit, ControlsVisibilityState>(
      builder: (context, cState) {
        return Stack(
          children: [
            //-------Volume Controller ---------//
            const VideoPlayerVolumeControllerWidget(),

            //--------- Brightness Controller------//
            const VideoPlayerBrightnessControllerWidget(),

            //--------- Video Content ---------//
            Center(
              child: CustomBrightnessShaderMask(
                child: VideoViewWidget(state: videoPlayerReadyState),
              ),
            ),

            //------------ Video Top Bar --------------//
            // if (cState.showVideoControls) 
            const VideoPlayerTopBarWidget(),

            //---------- VideoPlayer Bottom Bar Widget //----
            // if (cState.showVideoControls)
              VideoPlayerBottomWidget(state: videoPlayerReadyState),

            //---------- Brightness Box -------//
            const CustomBrightnessBoxWidget(),
          ],
        );
      },
    );
  }
}
