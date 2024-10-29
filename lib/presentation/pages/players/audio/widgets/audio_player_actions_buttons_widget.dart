import 'package:color_log/color_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:just_audio/just_audio.dart';
import 'package:open_player/logic/audio_player_bloc/audio_player_bloc.dart';
import 'package:open_player/presentation/pages/players/audio/widgets/audio_player_play_pause_button_widget.dart';

import '../../../../common/nothing_widget.dart';

class AudioPlayerActionsButtonsWidget extends StatelessWidget {
  const AudioPlayerActionsButtonsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size mq = MediaQuery.sizeOf(context);
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: mq.width * 0.03, vertical: mq.height * 0.01),
      child: BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
        builder: (context, successState) {
          if (successState is AudioPlayerSuccessState) {
            bool hasNext = successState.audioPlayer.hasNext;
            bool hasPrevious = successState.audioPlayer.hasPrevious;

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StreamBuilder(
                    stream: successState.audioPlayerCombinedStream,
                    builder: (context, snapshot) {
                      bool isShuffle =
                          snapshot.data?.shuffleModeEnabled ?? false;
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
                    }),
                AudioPlayerPreviousButtonWidget(),
                 AudioPlayerPlayPauseButtonWidget(),
                AudioPlayerNextButtonWidget(),
                StreamBuilder(
                    stream: successState.audioPlayerCombinedStream,
                    builder: (context, snapshot) {
                      LoopMode loopMode =
                          snapshot.data?.loopMode ?? LoopMode.all;
                      return IconButton(
                        onPressed: () {
                          clog.debug(" Repeat Button is pressed");
                          context
                              .read<AudioPlayerBloc>()
                              .add(AudioPlayerRepeatToggleEvent());
                        },
                        color: Colors.white,
                        iconSize: 25,
                        icon: Icon(
                          loopMode == LoopMode.all
                              ? HugeIcons.strokeRoundedRepeat
                              : loopMode == LoopMode.one
                                  ? HugeIcons.strokeRoundedRepeatOne02
                                  : HugeIcons.strokeRoundedRepeatOff,
                        ),
                      );
                    }),
              ],
            );
          } else {
            return nothing;
          }
        },
      ),
    );
  }
}

class AudioPlayerNextButtonWidget extends StatelessWidget {
   AudioPlayerNextButtonWidget({
    super.key,
    this.iconSize
  });

double? iconSize;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        clog.debug("Next Button is pressed");
        context.read<AudioPlayerBloc>().add(AudioPlayerNextEvent());
      },
      color:  Colors.white ,
      iconSize:iconSize?? 25,
      icon: const Icon(HugeIcons.strokeRoundedNext),
    );
  }
}

class AudioPlayerPreviousButtonWidget extends StatelessWidget {
  AudioPlayerPreviousButtonWidget({
    super.key, this.iconSize});

  double? iconSize;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        clog.debug("Previous Button is pressed");
        context
            .read<AudioPlayerBloc>()
            .add(AudioPlayerPreviousEvent());
      },
      color: Colors.white ,
      iconSize:iconSize?? 25,
      icon: const Icon(HugeIcons.strokeRoundedPrevious),
    );
  }
}
