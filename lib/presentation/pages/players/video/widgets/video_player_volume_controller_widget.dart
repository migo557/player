// video_player/presentation/pages/video_player_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:open_player/logic/Control_visibility/controls_visibility_cubit.dart';
import 'package:open_player/logic/volume_cubit/volume_cubit.dart';

import '../../../../../logic/video_player_bloc/video_player_bloc.dart';

class VideoPlayerVolumeControllerWidget extends HookWidget {
  const VideoPlayerVolumeControllerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final showSplash = useState(false);
    final mq = MediaQuery.sizeOf(context);
    return Positioned(
      height: mq.height,
      width: mq.width / 2,
      right: 0,
      child: BlocSelector<VideoPlayerBloc, VideoPlayerState,
          VideoPlayerReadyState?>(
        selector: (state) {
          return state is VideoPlayerReadyState ? state : null;
        },
        builder: (context, state) {
          return GestureDetector(
              onDoubleTap: () async {
                if (state is VideoPlayerReadyState) {
                  final currentPosition =
                      await state.vlcPlayerController.getPosition();
                  state.vlcPlayerController.seekTo(
                      Duration(seconds: currentPosition.inSeconds + 10));
                  showSplash.value = true;
                  await Future.delayed(Duration(milliseconds: 500));
                  showSplash.value = false;
                }
              },
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
                decoration: BoxDecoration(
                    color: showSplash.value
                        ? Colors.white.withOpacity(0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(300),
                      bottomLeft: Radius.circular(300),
                    )),
              ));
        },
      ),
    );
  }
}
