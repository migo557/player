import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_player/logic/audio_player_bloc/audio_player_bloc.dart';
import 'package:open_player/logic/volume_cubit/volume_cubit.dart';

class AudioPlayerGestureDetectorsBoxes extends StatelessWidget {
  const AudioPlayerGestureDetectorsBoxes({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size mq = MediaQuery.sizeOf(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ///------------------------ Left Box
        GestureDetector(
          //---[Backward Music]
          onDoubleTap: () {
            context.read<AudioPlayerBloc>().add(AudioPlayerBackwardEvent());
          },
          // [For Volume] ,
          onVerticalDragUpdate: (details) {
            context
                .read<VolumeCubit>()
                .changeAudioPlayerVolume(details: details);
            context.read<VolumeCubit>().volumeBoxVisibilityToggle();
          },

          child: Container(
            width: mq.width / 2 / 2,
            decoration: const BoxDecoration(color: Colors.transparent),
          ),
        ),

        //--------------------------------    Center  Box
        GestureDetector(
          //----- [Play, Pause Audio]
          onDoubleTap: () {
            context
                .read<AudioPlayerBloc>()
                .add(AudioPlayerPlayPauseToggleEvent());
          },
          child: Container(
            width: mq.width / 2,
            decoration: const BoxDecoration(color: Colors.transparent),
          ),
        ),

        // ----------------- Right Side ,
        GestureDetector(
          //--------[Forward Music]
          onDoubleTap: () {
            context.read<AudioPlayerBloc>().add(AudioPlayerForwardEvent());
          },

          //------- [Volume Changing]
          onVerticalDragUpdate: (details) {
            context
                .read<VolumeCubit>()
                .changeAudioPlayerVolume(details: details);
            context.read<VolumeCubit>().volumeBoxVisibilityToggle();
          },
          child: Container(
            width: mq.width / 2 / 2,
            decoration: const BoxDecoration(color: Colors.transparent),
          ),
        ),
      ],
    );
  }
}
