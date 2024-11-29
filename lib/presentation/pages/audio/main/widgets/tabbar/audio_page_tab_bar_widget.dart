import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../../../../../logic/audio_player_bloc/audio_player_bloc.dart';

class AudioPageTabBarWidget extends StatelessWidget {
  const AudioPageTabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocSelector<AudioPlayerBloc, AudioPlayerState,
        AudioPlayerSuccessState?>(
      selector: (state) {
        return state is AudioPlayerSuccessState ? state : null;
      },
      builder: (context, state) {
        return SliverAppBar(
          toolbarHeight: 50,
          automaticallyImplyLeading: false,
          pinned: true,
          primary: state != null ? false : true,
          actions: [
            Expanded(
              child: TabBar(
                onTap: (value) {},
                tabs: [
                  Tab(
                    text: "Songs",
                    icon: const Icon(HugeIcons.strokeRoundedMusicNoteSquare02),
                  ),
            
                  Tab(
                    text: "Artists",
                    icon: const Icon(HugeIcons.strokeRoundedMusicNoteSquare01),
                  ),
                  Tab(
                    text: "Albums",
                    icon: const Icon(Icons.album),
                  ),
                  Tab(
                    text: "Playlists",
                    icon: const Icon(HugeIcons.strokeRoundedPlayList),
                  ),

                  Tab(
                    text: "Folders",
                    icon: const Icon(HugeIcons.strokeRoundedFolder01),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
