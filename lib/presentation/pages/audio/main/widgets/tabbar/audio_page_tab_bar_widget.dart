import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../../../../../logic/audio_player_bloc/audio_player_bloc.dart';

class AudioPageTabBarWidget extends StatelessWidget {
  const AudioPageTabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final double mqHeight = MediaQuery.sizeOf(context).height;

    return BlocSelector<AudioPlayerBloc, AudioPlayerState,
        AudioPlayerSuccessState?>(
      selector: (state) {
        return state is AudioPlayerSuccessState ? state : null;
      },
      builder: (context, state) {
        return SliverAppBar(
          toolbarHeight: mqHeight * 0.067,
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
                    text: "Favorites",
                    icon: const Icon(HugeIcons.strokeRoundedFavouriteCircle),
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
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
