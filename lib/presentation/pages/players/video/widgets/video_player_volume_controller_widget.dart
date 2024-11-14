// video_player/presentation/pages/video_player_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_player/logic/Control_visibility/controls_visibility_cubit.dart';
import 'package:open_player/logic/volume_cubit/volume_cubit.dart';

class VideoPlayerVolumeControllerWidget extends StatelessWidget {
  const VideoPlayerVolumeControllerWidget({super.key, });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.sizeOf(context);
    return Positioned(
      height: mq.height,
      width: mq.width / 2,
      right: 0,
      child: GestureDetector(
          onTap: () {
            context
                .read<ControlsVisibilityCubit>()
                .toggleVideoControlsVisibilty();
          },
       
          onVerticalDragUpdate: (details) {
            context.read<VolumeCubit>().changeSystemVolume(
                  details: details,
                );
          },
          child: Container(
            color: Colors.transparent,
          )),
    );
  }
}
