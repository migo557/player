import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_player/presentation/common/nothing_widget.dart';

import '../../../../../logic/audio_player_bloc/audio_player_bloc.dart';

class AudioPlayerSeekBarWidget extends StatelessWidget {
  const AudioPlayerSeekBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AudioPlayerBloc, AudioPlayerState,
        AudioPlayerSuccessState?>(
      selector: (state) {
        return state is AudioPlayerSuccessState ? state : null;
      },
      builder: (context, successState) {
        if (successState != null) {
          return StreamBuilder(
              stream: successState.audioPlayerCombinedStream,
              builder: (context, snapshot) {
                Duration position = snapshot.data?.position ??
                    successState.audioPlayer.position;
                Duration duration = snapshot.data?.duration ??
                    successState.audioPlayer.duration ??
                    Duration.zero;

                return Slider(
                  onChangeEnd: (p) {
                    context
                        .read<AudioPlayerBloc>()
                        .add(AudioPlayerSeekEvent(position: p));
                    context.read<AudioPlayerBloc>().add(
                          AudioPlayerIsSeekingToggleEvent(
                              position: p,
                              isSeeking: false,
                              state: successState),
                        );
                  },
                  min: 0,
                  max: duration.inSeconds.toDouble(),
                  value: successState.isSeeking
                      ? successState.seekingPosition
                      : position.inSeconds.toDouble(),
                  onChanged: (p) {
                    context.read<AudioPlayerBloc>().add(
                          AudioPlayerIsSeekingToggleEvent(
                              position: p,
                              isSeeking: true,
                              state: successState),
                        );
                  },
                );
              });
        } else {
          return nothing;
        }
      },
    );
  }
}
