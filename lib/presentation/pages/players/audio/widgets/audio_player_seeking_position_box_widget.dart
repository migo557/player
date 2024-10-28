import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:open_player/logic/audio_player_bloc/audio_player_bloc.dart';
import 'package:open_player/presentation/common/nothing_widget.dart';
import 'package:open_player/utils/duration/formatDuration.dart';

class AudioPlayerSeekingPositionBoxWidget extends StatelessWidget {
  const AudioPlayerSeekingPositionBoxWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size mq = MediaQuery.sizeOf(context);
    return BlocSelector<AudioPlayerBloc, AudioPlayerState,
        AudioPlayerSuccessState?>(
      selector: (state) {
        return state is AudioPlayerSuccessState ? state : null;
      },
      builder: (context, state) {
        if (state == null) return nothing;

        return Visibility(
          visible: state.isSeeking,
          child: Center(
            child: Card(
              child: SizedBox(
                height: mq.width * 0.2,
                width: mq.width * 0.2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          formatDuration(
                              Duration(seconds: state.seekingPosition.toInt())),
                          style: const TextStyle(fontSize: 18),
                        ),
                        const Icon(HugeIcons.strokeRoundedScrollHorizontal)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
