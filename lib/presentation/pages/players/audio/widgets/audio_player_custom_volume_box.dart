import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:open_player/logic/audio_player_bloc/audio_player_bloc.dart';
import 'package:open_player/logic/volume_cubit/volume_cubit.dart';
import 'package:open_player/presentation/common/nothing_widget.dart';

class AudioPlayerCustomVolumeBoxWidget extends StatelessWidget {
   AudioPlayerCustomVolumeBoxWidget({super.key, this.boxHeight, this.boxWidth});

  double? boxWidth;
  double? boxHeight;
  @override
  Widget build(BuildContext context) {
    final Size mq = MediaQuery.sizeOf(context);
    return BlocBuilder<VolumeCubit, VolumeState>(
      builder: (context, vState) {
        return Align(
          alignment: Alignment.center,
          child: Visibility(
            visible: vState.showVolumeBar,
            child: Card(
              child: SizedBox(
                height: boxHeight?? mq.width * 0.2,
                width:boxWidth?? mq.width * 0.2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
                    builder: (context, audioState) {
                      if (audioState is AudioPlayerSuccessState) {
                        return StreamBuilder<double>(
                            stream: audioState.audioPlayer.volumeStream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                double volume = snapshot.data ?? audioState.audioPlayer.volume;
                                bool maxVolume = volume == 1.0;
                                bool mute = volume == 0;

                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      maxVolume
                                          ? "100"
                                          : mute
                                              ? ""
                                              : volume
                                                  .toString()
                                                  .substring(2, 4),
                                    ),
                                    Icon(volume >= 0.7
                                        ? HugeIcons.strokeRoundedVolumeHigh
                                        : mute
                                            ? HugeIcons
                                                .strokeRoundedVolumeMute01
                                            : HugeIcons.strokeRoundedVolumeLow),
                                  ],
                                );
                              }
                              return nothing;
                            });
                      }
                      return nothing;
                    },
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
