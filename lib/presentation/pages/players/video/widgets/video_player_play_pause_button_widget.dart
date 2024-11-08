// video_player/presentation/pages/video_player_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:open_player/logic/video_player_bloc/video_player_bloc.dart';

import '../../../../../logic/Control_visibility/controls_visibility_cubit.dart';

class VideoPlayerPlayPauseButtonWidget extends HookWidget {
  const VideoPlayerPlayPauseButtonWidget({
    super.key,
    required this.state,
  });
  final VideoPlayerReadyState state;
  @override
  Widget build(BuildContext context) {
    ValueNotifier isPlaying = useState(false);

    state.vlcPlayerController.addListener(() {
      isPlaying.value = state.vlcPlayerController.value.isPlaying;
    });

    return GestureDetector(
      onTap: () {
        if (isPlaying.value) {
          state.vlcPlayerController.pause();
        } else {
          state.vlcPlayerController.play();
        }
        context.read<ControlsVisibilityCubit>().toggleVideoControlsVisibilty();
      },
      child: Container(
        width: 55,
        height: 55,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        alignment: Alignment.center,
        child: Icon(
          isPlaying.value ? Icons.pause : Icons.play_arrow,
          color: Colors.black,
          size: 30,
        ),
      ),
    );
  }
}
