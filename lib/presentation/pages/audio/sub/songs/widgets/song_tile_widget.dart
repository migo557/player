import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:open_player/base/assets/fonts/app_fonts.dart';
import 'package:open_player/base/assets/images/app-images.dart';
import 'package:open_player/logic/audio_bloc/audios_bloc.dart';
import 'package:open_player/logic/audio_player_bloc/audio_player_bloc.dart';
import 'package:open_player/presentation/pages/audio/sub/songs/widgets/song_tile_more_button_widget.dart';
import 'package:open_player/presentation/pages/players/audio/ui/audio_player.dart';
import 'package:open_player/utils/menu/app_menu.dart';

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
              int? currentIndex = snapshot.data?.currentIndex;
              bool? isSelected = currentIndex != null
                  ? playerState.audios[currentIndex].path == audio.path
                  : null;
              return _SongTile(
                index: index,
                state: state,
                songTitle: audio.title,
                onTap: () {
                  if (isSelected != null && !isSelected) {
                    context.read<AudioPlayerBloc>().add(
                          AudioPlayerInitializeEvent(
                              initialMediaIndex: index, audioList: state.songs),
                        );
                  }

                  ///!-----Show Player Screen ----///
                  showModalBottomSheet(
                    showDragHandle: false,
                    isScrollControlled: true,
                    context: context,
                    builder: (context) => const AudioPlayerPage(),
                  );
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
  const _SongTile({
    required this.index,
    required this.state,
    required this.songTitle,
    required this.color,
    required this.onTap,
  });

  final int index;
  final AudiosSuccess state;
  final String songTitle;
  final Function()? onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
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
              //------ Profile Image -----//
              Card(
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      image: AssetImage(
                        AppImages.defaultProfile,
                      ),
                      fit: BoxFit.cover,
                    ),
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
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500),
                    ),

                    //----Artist
                    Text(
                      "Artists $index",
                      overflow: TextOverflow.clip,
                      style: const TextStyle(
                          fontSize: 11,
                          fontFamily: AppFonts.poppins,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),

              // const Spacer(),

              //-------- More Button
              SongTileMoreButtonWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
