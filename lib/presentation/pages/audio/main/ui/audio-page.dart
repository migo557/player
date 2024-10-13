import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_player/base/di/dependency_injection.dart';
import 'package:open_player/presentation/pages/audio/main/widgets/appbar/app_bar_widget.dart';
import 'package:open_player/presentation/pages/audio/main/widgets/tabbar/audio_page_tab_bar_widget.dart';
import 'package:open_player/presentation/pages/audio/sub/albums/ui/albums_page.dart';
import 'package:open_player/presentation/pages/audio/sub/artists/ui/artists_page.dart';
import 'package:open_player/presentation/pages/audio/sub/folders/ui/audio_folders_page.dart';
import 'package:open_player/presentation/pages/audio/sub/playlists/ui/playlists-page.dart';
import 'package:open_player/presentation/pages/audio/sub/songs/ui/songs-page.dart';

import '../../../../../logic/audio_page_tab_bar_cubit/audio_page_tab_bar_cubit.dart';

class AudioPage extends StatelessWidget {
  AudioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocSelector<AudioPageTabBarCubit, AudioPageTabBarState,
          AudioPageTabBarState>(
        selector: (state) {
          return state;
        },
        builder: (context, state) {
          return DefaultTabController(
            length: 4,
            child: CustomScrollView(
              controller: locator.get<ScrollController>(),
              slivers: [
                //-------------------- AppBar -------------------------//
                const AudioPageAppBarWidget(),

                //-------------------- Tab Bar----------------------///
                const AudioPageTabBarWidget(),

                //-------------- Tab Bar View --------------------//
                _tabs[state.tabIndex]
              ],
            ),
          );
        },
      ),
    );
  }

  ///---------- Tab Bar Pages List ---------------///
  final _tabs = [
    const SongsPage(),
    const ArtistsPage(),
    const AlbumsPage(),
    const PlaylistsPage(),
    const AudioFoldersPage(),
  ];
}
