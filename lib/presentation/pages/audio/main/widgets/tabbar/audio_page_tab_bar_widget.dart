import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:open_player/logic/audio_page_tab_bar_cubit/audio_page_tab_bar_cubit.dart';

class AudioPageTabBarWidget extends StatelessWidget {
  const AudioPageTabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final double mqHeight = MediaQuery.sizeOf(context).height;
    return SliverAppBar(
      toolbarHeight: mqHeight * 0.062,
      pinned: true,
      actions: [
        Expanded(
            child: TabBar(
                onTap: (value) {
                  context
                      .read<AudioPageTabBarCubit>()
                      .changeIndex(tabIndex: value);
                },
                tabs:  const [
              Tab(
                
                text: "Songs",
                icon: Icon(HugeIcons.strokeRoundedMusicNoteSquare02),
              ),
              Tab(
                text: "Artists",
                icon: Icon(HugeIcons.strokeRoundedMusicNoteSquare01),
              ),
              Tab(
                text: "Albums",
                icon: Icon(Icons.album),
              ),
              Tab(
                text: "Playlists",
                icon: Icon(HugeIcons.strokeRoundedPlayList),
              ),

              Tab(
                text: "Folders",
                icon: Icon(HugeIcons.strokeRoundedFolder01),
              ),
            ]))
      ],
    );
  }
}
