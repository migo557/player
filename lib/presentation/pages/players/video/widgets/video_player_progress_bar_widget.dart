import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:open_player/logic/video_player_bloc/video_player_bloc.dart';
import '../../../../../logic/Control_visibility/controls_visibility_cubit.dart';
import '../../../../../utils/formatDuration.dart';

class VideoPlayerProgressBarWidget extends HookWidget {
  const VideoPlayerProgressBarWidget({super.key, required this.state});
  final VideoPlayerReadyState state;

  @override
  Widget build(BuildContext context) {
    ValueNotifier<Duration> position = useState(Duration.zero);
    ValueNotifier<Duration> duration = useState(Duration.zero);
    ValueNotifier<bool> isSeeking = useState(false);
    ValueNotifier<double> seekingPosition = useState(0.0);

    state.vlcPlayerController.addListener(() {
      position.value = state.vlcPlayerController.value.position;
      duration.value = state.vlcPlayerController.value.duration;
    });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SliderTheme(
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
              value: isSeeking.value
                  ? seekingPosition.value
                  : position.value.inSeconds.toDouble(),
              max: duration.value.inSeconds.toDouble(),
              min: 0,
              onChangeEnd: (value) {
                isSeeking.value = false;
                state.vlcPlayerController.seekTo(
                  Duration(seconds: value.toInt()),
                );
              },
              onChanged: (double value) {
                isSeeking.value = true;
                seekingPosition.value = value;

                context
                    .read<ControlsVisibilityCubit>()
                    .toggleVideoControlsVisibilty();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (!isSeeking.value)
                  Text(
                    formatDuration(position.value),
                    style: const TextStyle(color: Colors.white70),
                  ),
                if (isSeeking.value)
                  Text(
                    formatDuration(
                        Duration(seconds: seekingPosition.value.toInt())),
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                Text(
                  formatDuration(duration.value),
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
