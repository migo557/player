// video_player/presentation/pages/video_player_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_player/logic/brightness_cubit/brightness_cubit.dart';

import '../../../../../logic/Control_visibility/controls_visibility_cubit.dart';

class VideoPlayerBrightnessControllerWidget extends StatelessWidget {
  const VideoPlayerBrightnessControllerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.sizeOf(context);
    return Positioned(
      height: mq.height ,
      width: mq.width / 2,
      left: 0,
      child: GestureDetector(
        onTap: (){
               context
              .read<ControlsVisibilityCubit>()
              .toggleVideoControlsVisibilty();
        },
        onVerticalDragUpdate: (details) {
          context.read<BrightnessCubit>().changeVideoPlayerBrightness(
                details,
              );
          context.read<BrightnessCubit>().brightnessBoxVisibilityToggle();
        },
        child: Container(
          color: Colors.transparent,

        ),
      ),
    );
  }
}
