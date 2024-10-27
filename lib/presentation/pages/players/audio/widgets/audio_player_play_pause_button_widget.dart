import 'package:color_log/color_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:open_player/logic/audio_player_bloc/audio_player_bloc.dart';
import 'package:open_player/presentation/common/nothing_widget.dart';

class AudioPlayerPlayPauseButtonWidget extends StatelessWidget {
  const AudioPlayerPlayPauseButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AudioPlayerBloc, AudioPlayerState,
        AudioPlayerSuccessState?>(
      selector: (state) {
        return state is AudioPlayerSuccessState ? state : null;
      },
      builder: (context, state) {
        if (state != null) {
          return StreamBuilder(
              stream: state.audioPlayerCombinedStream,
              builder: (context, snapshot) {
                  bool isPlay = snapshot.data?.playing??false;
                   return IconButton(
                  onPressed: () {
                    clog.debug("Play Pause Button is pressed");
                    context
                        .read<AudioPlayerBloc>()
                        .add(AudioPlayerPlayPauseToggleEvent());
                  },
                  color: Colors.white,
                  iconSize: 40,
                  icon:   Icon(isPlay
                      ? HugeIcons.strokeRoundedPause
                      : HugeIcons.strokeRoundedPlay),
                );
           
              });
        } else {
          return nothing;
        }
      },
    );
  }
}
