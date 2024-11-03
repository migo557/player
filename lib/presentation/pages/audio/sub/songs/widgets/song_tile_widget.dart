import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:open_player/base/assets/fonts/app_fonts.dart';
import 'package:open_player/base/assets/images/app-images.dart';
import 'package:open_player/logic/audio_bloc/audios_bloc.dart';
import 'package:open_player/logic/audio_player_bloc/audio_player_bloc.dart';
import 'package:open_player/presentation/pages/audio/sub/songs/widgets/song_tile_more_button_widget.dart';
import 'package:open_player/presentation/pages/players/audio/ui/audio_player.dart';
import 'package:open_player/presentation/pages/players/audio/widgets/audio_player_play_pause_button_widget.dart';

import '../../../../../../data/models/audio_model.dart';

class SongTileWidget extends StatelessWidget {
  const SongTileWidget({
    super.key,
    required this.index,
    required this.state,
    required this.audio,
  });
  final int index;
  final AudioModel audio;
  final AudiosSuccess state;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AudioPlayerBloc, AudioPlayerState,
        AudioPlayerSuccessState?>(
      selector: (state) {
        return state is AudioPlayerSuccessState ? state : null;
      },
      builder: (context, playerState) {
        if (playerState == null) {
          return _SongTile(
            index: index,
            state: state,
            songTitle: audio.title,
            onTap: () {
              context.read<AudioPlayerBloc>().add(AudioPlayerInitializeEvent(
                  initialMediaIndex: index, audioList: state.songs));

              ///!-----Show Player Screen ----///
              showModalBottomSheet(
                showDragHandle: false,
                isScrollControlled: true,
                context: context,
                builder: (context) => const AudioPlayerPage(),
              );
            },
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          );
        }

        return StreamBuilder(
            stream: playerState.audioPlayerCombinedStream,
            builder: (context, snapshot) {
              int? currentIndex = snapshot.data?.currentIndex ??
                  playerState.audioPlayer.currentIndex;
              bool? isSelected = currentIndex != null
                  ? playerState.audios[currentIndex].path == audio.path
                  : null;
              return _SongTile(
                index: index,
                state: state,
                songTitle: audio.title,
                isSelected: isSelected,
                onTap: () {
                  if (isSelected != null && !isSelected) {
                    context.read<AudioPlayerBloc>().add(
                          AudioPlayerInitializeEvent(
                              initialMediaIndex: index, audioList: state.songs),
                        );
                  }
                  if (isSelected != null && isSelected) {
                    ///!-----Show Player Screen ----///
                    showModalBottomSheet(
                      showDragHandle: false,
                      isScrollControlled: true,
                      context: context,
                      builder: (context) => const AudioPlayerPage(),
                    );
                  }
                },
                color: isSelected != null
                    ? isSelected
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).colorScheme.onPrimaryContainer
                    : Theme.of(context).colorScheme.onPrimaryContainer,
              );
            });
      },
    );
  }
}

class _SongTile extends StatelessWidget {
  const _SongTile(
      {required this.index,
      required this.state,
      required this.songTitle,
      required this.color,
      required this.onTap,
      this.isSelected});

  final int index;
  final AudiosSuccess state;
  final String songTitle;
  final Function()? onTap;

  final Color color;
  final bool? isSelected;

  @override
  Widget build(BuildContext context) {
    final bool isPlaying = isSelected != null
        ? isSelected!
            ? true
            : false
        : false;
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              //------ Thumbnail Image -----//
              Card(
                margin: isPlaying ? EdgeInsets.zero : null,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  width: isPlaying ? 75 : 70,
                  height: isPlaying ? 75 : 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      //--------- Thumbnail
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          AppImages.defaultProfile,
                        ),
                      ),

                      //------ Play Button Icon
                      //-------- Playbuttons Icon
                      if (isPlaying)
                        Center(
                          child: AudioPlayerPlayPauseButtonWidget(
                            iconSize: 25,
                          ),
                        )
                    ],
                  ),
                ),
              ),
              const Gap(10),

              ///------------ Title & Artists -----------///
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //---Title

                    Text(
                      songTitle,
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                          color: isPlaying ? Colors.white : null,
                          fontSize: 15,
                          fontWeight:
                              isPlaying ? FontWeight.bold : FontWeight.w500),
                    ),

                    //----Artist
                    Text(
                      "Artists $index",
                      overflow: TextOverflow.clip,
                      style: const TextStyle(
                          fontSize: 11,
                          fontFamily: AppFonts.poppins,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),

              //-------- More Button
              const SongTileMoreButtonWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
