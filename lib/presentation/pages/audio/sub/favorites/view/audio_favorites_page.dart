import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:open_player/base/db/hive_service.dart';
import 'package:open_player/data/models/audio_model.dart';
import 'package:open_player/data/services/favorite_audio_hive_service/audio_hive_service.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../../../logic/audio_bloc/audios_bloc.dart';
import '../../../../../../logic/theme_cubit/theme_cubit.dart';
import '../../../../../../logic/theme_cubit/theme_state.dart';
import '../../songs/widgets/song_tile_widget.dart';

class AudioFavoritePage extends StatelessWidget {
  const AudioFavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.sizeOf(context);
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return BlocBuilder<AudiosBloc, AudiosState>(
          builder: (context, audioState) {
            if (audioState is AudiosSuccess) {
              if (audioState.songs.isNotEmpty) {
                final fvrKeys = MyHiveBoxes.favoriteAudios.keys;

                //Filter out audios  whose title starts with dot
                List<AudioModel> filteredSongs = audioState.songs
                    .where((audio) =>
                        fvrKeys.contains(FavoritesAudioHiveService.generateKey(
                            audio.path)) &&
                        FavoritesAudioHiveService()
                            .getFavoriteStatus(audio.path))
                    .toList()..sort((a, b) => a.title.compareTo(b.title));


                int songsLength = filteredSongs.length;

                return CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.only(bottom: mq.height * 0.1),
                      sliver: SliverList.builder(
                        addAutomaticKeepAlives: true,
                        itemCount: songsLength,
                        itemBuilder: (context, index) {
                          return index == 0
                              ? Column(
                                  children: [
                                    //---------- [Songs Legth] [Sort Button][Select All Button]
                                    [
                                      "$songsLength songs".text.make(),
                                    ].row().p12(),
                    
                                    //--------- Music Title
                                    SongTileWidget(
                                      audios: filteredSongs,
                                      index: index,
                                      state: audioState,
                                    ),
                                  ],
                                )
                              : SongTileWidget(
                                  audios: filteredSongs,
                                  index: index,
                                  state: audioState,
                                );
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("No Audio found"),
                      IconButton(
                        onPressed: () {
                          context.read<AudiosBloc>().add(AudiosLoadEvent());
                        },
                        icon: const Icon(HugeIcons.strokeRoundedRefresh),
                      ),
                    ],
                  ),
                );
              }
            } else if (audioState is AudiosLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (audioState is AudiosFailure) {
              return Center(
                child: Text(audioState.message),
              );
            } else if (audioState is AudiosInitial) {
              return Center(
                child: Text("Initializing ..."),
              );
            } else {
              return Center(
                child: Text("Something went wrong"),
              );
            }
          },
        );
      },
    );
  }
}
