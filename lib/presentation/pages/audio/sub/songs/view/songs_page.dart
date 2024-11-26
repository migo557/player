import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:open_player/presentation/pages/audio/sub/songs/widgets/song_tile_widget.dart';
import 'package:open_player/presentation/pages/audio/sub/songs/widgets/songs_top_bar_buttons_widget.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../../../../logic/audio_bloc/audios_bloc.dart';
import '../../../../../../logic/theme_cubit/theme_cubit.dart';
import '../../../../../../logic/theme_cubit/theme_state.dart';

class SongsPage extends HookWidget {
  const SongsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sortValue = useState("name");
    final mq = MediaQuery.sizeOf(context);

    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return BlocBuilder<AudiosBloc, AudiosState>(
          builder: (context, audioState) {
            if (audioState is AudiosSuccess) {
              if (audioState.songs.isNotEmpty) {
                // Filter out audios whose title starts with dot & Sort the filtered List
                final filteredSongs = audioState.songs
                    .where((audio) => !audio.title.startsWith('.'))
                    .toList()
                  ..sort((a, b) => sortValue.value == "name"
                      ? a.title.compareTo(b.title)
                      : sortValue.value == "size"
                          ? a.size.compareTo(b.size)
                          : sortValue.value == "type"
                              ? a.ext.compareTo(b.ext)
                              : a.path.compareTo(b.path));

                int songsLength = filteredSongs.length;

                return CustomScrollView(
                  physics: BouncingScrollPhysics(),
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.only(bottom: mq.height * 0.1),
                      sliver: SliverList.builder(
                        addAutomaticKeepAlives: true,
                        itemCount: songsLength,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return [
                              // Songs Length, Sort Button, Select All Button
                              SongsTopBarButtonsWidget(
                                  defaultVal: sortValue.value,
                                  valFunc: (val) {
                                    sortValue.value = val;
                                  },
                                  songsLength: songsLength),
                              // Music Title (first song)
                              SongTileWidget(
                                audios: filteredSongs,
                                index: index,
                                state: audioState,
                              ),
                            ].column();
                          }
                          return SongTileWidget(
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
}
