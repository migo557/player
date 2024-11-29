import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:open_player/data/models/audio_model.dart';
import 'package:open_player/presentation/pages/audio/sub/songs/widgets/song_tile_widget.dart';
import 'package:open_player/presentation/pages/audio/sub/songs/widgets/songs_top_bar_buttons_widget.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../../../../base/db/hive_service.dart';
import '../../../../../../data/services/favorite_audio_hive_service/audio_hive_service.dart';
import '../../../../../../logic/audio_bloc/audios_bloc.dart';
import '../../../../../../logic/theme_cubit/theme_cubit.dart';
import '../../../../../../logic/theme_cubit/theme_state.dart';

class SongsPage extends HookWidget {
  const SongsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedFilter = useState(SongsFiltered.name);
    final mq = MediaQuery.sizeOf(context);

    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return BlocBuilder<AudiosBloc, AudiosState>(
          builder: (context, audioState) {
            if (audioState is AudiosSuccess) {
              if (audioState.songs.isNotEmpty) {
                final fvrKeys = MyHiveBoxes.favoriteAudios.keys;

                final songsByName = audioState.songs
                    .where((audio) => !audio.title.startsWith('.'))
                    .toList()
                  ..sort((a, b) => a.title.compareTo(b.title));

                List<AudioModel> favoriteSongs = audioState.songs
                    .where((audio) =>
                        fvrKeys.contains(FavoritesAudioHiveService.generateKey(
                            audio.path)) &&
                        FavoritesAudioHiveService()
                            .getFavoriteStatus(audio.path))
                    .toList()
                  ..sort((a, b) => a.title.compareTo(b.title));

                final recentlyAdded = audioState.songs
                    .where((audio) => !audio.title.startsWith('.'))
                    .toList()
                  ..sort((a, b) => a.lastModified.compareTo(b.lastModified));

                final hiddenSongs = audioState.songs
                    .where((audio) => audio.title.startsWith('.'))
                    .toList()
                  ..sort((a, b) => a.size.compareTo(b.size));

                final filteredSongs = _returnSongs(favoriteSongs, recentlyAdded,
                    songsByName, hiddenSongs, selectedFilter);

                int songsLength = filteredSongs.length;

                // if (songsByName.isNotEmpty) {
                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<AudiosBloc>().add(AudiosLoadEvent());
                  },
                  child: CustomScrollView(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    slivers: [
                      // Songs Length, Sort Chips
                      SliverToBoxAdapter(
                        child: SongsTopBarButtonsWidget(
                          songsLength: songsLength,
                          selectedFilter: selectedFilter,
                        ),
                      ),

                      SliverPadding(
                        padding: EdgeInsets.only(bottom: mq.height * 0.1),
                        sliver: SliverList.builder(
                          addAutomaticKeepAlives: true,
                          itemCount: songsLength,
                          itemBuilder: (context, index) {
                            return SongTileWidget(
                              audios: filteredSongs,
                              index: index,
                              state: audioState,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: [
                    "No Audios found".text.make(),
                    IconButton(
                      onPressed: () {
                        context.read<AudiosBloc>().add(AudiosLoadEvent());
                      },
                      icon: const Icon(HugeIcons.strokeRoundedRefresh),
                    ),
                  ].column(),
                );
              }
            } else if (audioState is AudiosLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (audioState is AudiosFailure) {
              return Center(
                child: Text(audioState.message),
              );
            } else if (audioState is AudiosInitial) {
              return "Initializing ...".text.makeCentered();
            } else {
              return "Something went wrong".text.makeCentered();
            }
          },
        );
      },
    );
  }

  List<AudioModel> _returnSongs(
      List<AudioModel> favorites,
      List<AudioModel> recents,
      List<AudioModel> name,
      List<AudioModel> hidden,
      ValueNotifier<SongsFiltered> selectedFilter) {
    if (selectedFilter.value == SongsFiltered.name) {
      return name;
    } else if (selectedFilter.value == SongsFiltered.favorites) {
      return favorites;
    } else if (selectedFilter.value == SongsFiltered.recents) {
      return recents.reversed.toList();
    } else {
      return hidden;
    }
  }
}
