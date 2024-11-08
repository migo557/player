import 'package:color_log/color_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:open_player/logic/audio_player_bloc/audio_player_bloc.dart';
import 'package:open_player/presentation/common/widgets/nothing_widget.dart';

class AudioPlayerSuffleButtonWidget extends StatelessWidget {
  const AudioPlayerSuffleButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
        builder: (context, successState) {
      if (successState is AudioPlayerSuccessState) {
        return StreamBuilder(
            stream: successState.audioPlayerCombinedStream,
            builder: (context, snapshot) {
              bool isShuffle = snapshot.data?.shuffleModeEnabled ?? false;
              return IconButton(
                onPressed: () {
                  clog.debug("Shuffle Button is pressed");
                  context
                      .read<AudioPlayerBloc>()
                      .add(AudioPlayerShuffleEvent());
                },
                color: isShuffle ? Colors.white : Colors.grey,
                iconSize: 25,
                icon: const Icon(HugeIcons.strokeRoundedShuffle),
              );
            });
      }

      return nothing;
    });
  }
}
