import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_player/presentation/common/nothing_widget.dart';

import '../../../../../logic/audio_player_bloc/audio_player_bloc.dart';
import '../../../../../utils/duration/formatDuration.dart';

class AudioPlayerPositionAndDurationWidget extends StatelessWidget {
  const AudioPlayerPositionAndDurationWidget(
      {super.key, this.showPosition = true, this.showDuration = true, this.enablePadding = true});

  final bool showPosition;
  final bool showDuration;
  final bool enablePadding;
  @override
  Widget build(BuildContext context) {
    final Size mq = MediaQuery.sizeOf(context);

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
                Duration position = snapshot.data?.position ?? Duration.zero;
                Duration duration = snapshot.data?.duration ?? Duration.zero;

                return Padding(
                  padding: enablePadding? EdgeInsets.symmetric(
                    horizontal: mq.width * 0.03,
                  ):EdgeInsets.zero,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //---       Position
                      if (showPosition)
                        Text(
                          formatDuration(position),
                          style: const TextStyle(color: Colors.white),
                        ),

                      //--     Duration
                      if (showDuration)
                        Text(
                          formatDuration(duration),
                          style: const TextStyle(color: Colors.white),
                        ),
                    ],
                  ),
                );
              });
        } else {
          return nothing;
        }
      },
    );
  }
}
