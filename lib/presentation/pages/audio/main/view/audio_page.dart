import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_player/presentation/common/widgets/miniplayer/mini_audio_player_widget.dart';
import 'package:open_player/presentation/pages/audio/sub/albums/view/albums_page.dart';
import 'package:open_player/presentation/pages/audio/sub/artists/view/artists_page.dart';
import 'package:open_player/presentation/pages/audio/sub/playlists/view/playlists-page.dart';
import 'package:open_player/presentation/pages/audio/sub/songs/view/songs_page.dart';
import '../../../../../logic/audio_bloc/audios_bloc.dart';
import '../../sub/favorites/view/audio_favorites_page.dart';
import '../widgets/appbar/audio_page_app_bar_widget.dart';
import '../widgets/tabbar/audio_page_tab_bar_widget.dart';

class AudioPage extends StatelessWidget {
  const AudioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const MiniAudioPlayerWidget(),
          Expanded(
            child: DefaultTabController(
              length: 5,
              child: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    // Your existing SliverAppBar
                    const AudioPageAppBarWidget(),

                    // Your existing SliverTabBar
                    const AudioPageTabBarWidget(),
                  ];
                },
                body: TabBarView(
                  physics: NeverScrollableScrollPhysics(), // Prevent swiping
                  children: [
                    SongsPage(),
                    AudioFavoritePage(),
                    ArtistsPage(),
                    AlbumsPage(),
                    PlaylistsPage(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
