import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_player/logic/audio_page_tab_bar_cubit/audio_page_tab_bar_cubit.dart';

class AudioPageTabBarWidget extends StatelessWidget {
  const AudioPageTabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final double mqWidth = MediaQuery.sizeOf(context).width;
    final double mqHeight = MediaQuery.sizeOf(context).height;
    return SliverAppBar(
      toolbarHeight: mqHeight * 0.05,
      pinned: true,
      actions: [
        Expanded(
            child: TabBar(
                onTap: (value) {
                  context
                      .read<AudioPageTabBarCubit>()
                      .changeIndex(tabIndex: value);
                },
                tabs: const [
              Tab(
                text: "Songs",
                icon: Icon(Icons.library_music_outlined),
              ),
              Tab(
                text: "Artists",
                icon: Icon(Icons.library_music_outlined),
              ),
              Tab(
                text: "Albums",
                icon: Icon(Icons.album),
              ),
              Tab(
                text: "Playlists",
                icon: Icon(Icons.playlist_play_outlined),
              ),
            ]))
      ],
    );
  }
}
