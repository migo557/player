import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:open_player/logic/video_player_bloc/video_player_bloc.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../../../logic/Control_visibility/controls_visibility_cubit.dart';
import '../../../../../utils/formater.dart';

class VideoPlayerProgressBarWidget extends HookWidget {
  const VideoPlayerProgressBarWidget({super.key, required this.state});
  final VideoPlayerReadyState state;

  @override
  Widget build(BuildContext context) {
    ValueNotifier<Duration> position = useState(Duration.zero);
    ValueNotifier<Duration> duration = useState(Duration.zero);
    ValueNotifier<bool> isSeeking = useState(false);

    state.vlcPlayerController.addListener(() {
      position.value = state.vlcPlayerController.value.position;
      duration.value = state.vlcPlayerController.value.duration;
    });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: [
        [
          //---------- Positions
          Formatter.formatDuration(position.value)
              .text
              .white
              .shadowBlur(1)
              .make(),

          //------------- Slider ----------------//
          Expanded(
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 2,
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 15),
                activeTrackColor: Colors.white,
                inactiveTrackColor: Colors.white24,
                thumbColor: Colors.white,
                overlayColor: Colors.white24,
              ),
              child: Slider(
                value: position.value.inSeconds.toDouble(),
                max: duration.value.inSeconds.toDouble(),
                min: 0,
                onChangeEnd: (value) {
                  isSeeking.value = false;
                },
                onChanged: (double value) {
                  isSeeking.value = true;
                  state.vlcPlayerController.seekTo(
                    Duration(seconds: value.toInt()),
                  );
                  context
                      .read<ControlsVisibilityCubit>()
                      .toggleVideoControlsVisibilty();
                },
              ),
            ),
          ),

          //--------- Total Video Duration
            Formatter.formatDuration(duration.value)
                .text
                .white
                .shadowBlur(1)
                .make(),
        ].row(),
      ].column(
        axisSize: MainAxisSize.min,
      ),
    );
  }
}
