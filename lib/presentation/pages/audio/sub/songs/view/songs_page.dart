import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:open_player/presentation/pages/audio/sub/songs/widgets/song_tile_widget.dart';
import 'package:open_player/presentation/pages/audio/sub/songs/widgets/songs_top_bar_buttons_widget.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../../../../logic/audio_bloc/audios_bloc.dart';
import '../../../../../../logic/theme_cubit/theme_cubit.dart';
import '../../../../../../logic/theme_cubit/theme_state.dart';

class SongsPage extends StatelessWidget {
  const SongsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.sizeOf(context);
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return BlocBuilder<AudiosBloc, AudiosState>(
          builder: (context, audioState) {
            if (audioState is AudiosSuccess) {
              if (audioState.songs.isNotEmpty) {
                //Filter out audios  whose title starts with dot  & Sorting the filtered List ---------------//
                final filteredSongs = audioState.songs
                    .where((audio) => !audio.title.startsWith('.'))
                    .toList()
                  ..sort((a, b) => a.title.compareTo(b.title));

                int songsLength = filteredSongs.length;

                return SliverPadding(
                  padding: EdgeInsets.only(bottom: mq.height * 0.1),
                  sliver: SliverList.builder(
                    addAutomaticKeepAlives: true,
                    itemCount: songsLength,
                    itemBuilder: (context, index) {
                      return index == 0
                          ? [
                              //---------- [Songs Legth] [Sort Button][Select All Button]
                              SongsTopBarButtonsWidget(
                                  songsLength: songsLength),
                              //--------- Music Title
                              SongTileWidget(
                                audios: filteredSongs,
                                index: index,
                                state: audioState,
                              ),
                            ].column()
                          : SongTileWidget(
                              audios: filteredSongs,
                              index: index,
                              state: audioState,
                            );
                    },
                  ),
                );
              } else {
                return SliverToBoxAdapter(
                  child: [
                    "No Audios found".text.make(),
                    IconButton(
                      onPressed: () {
                        context.read<AudiosBloc>().add(AudiosLoadEvent());
                      },
                      icon: const Icon(HugeIcons.strokeRoundedRefresh),
                    ),
                  ].column().centered(),
                );
              }
            } else if (audioState is AudiosLoading) {
              return const SliverToBoxAdapter(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (audioState is AudiosFailure) {
              return SliverToBoxAdapter(
                child: Center(
                  child: Text(audioState.message),
                ),
              );
            } else if (audioState is AudiosInitial) {
              return SliverToBoxAdapter(
                  child: "Initializing ...".text.makeCentered());
            } else {
              return SliverToBoxAdapter(
                child: "Something went wrong".text.makeCentered(),
              );
            }
          },
        );
      },
    );
  }
}
