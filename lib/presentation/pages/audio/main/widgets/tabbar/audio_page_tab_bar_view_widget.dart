import 'package:flutter/material.dart';
import 'package:open_player/presentation/pages/audio/sub/albums/ui/albums-page.dart';
import 'package:open_player/presentation/pages/audio/sub/artists/ui/artists-page.dart';
import 'package:open_player/presentation/pages/audio/sub/playlists/ui/playlists-page.dart';
import 'package:open_player/presentation/pages/audio/sub/songs/ui/songs-page.dart';

class AudioPageTabBarViewWidget extends StatelessWidget {
   AudioPageTabBarViewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double mqWidth = MediaQuery.sizeOf(context).width;
    final double mqHeight = MediaQuery.sizeOf(context).height;
    return SliverToBoxAdapter(
      child: SizedBox(
        height: mqHeight * 0.8,
        width: mqWidth,
        child: TabBarView(children: _pages),
      ),
    );
  }

  //------------- Pages List ------------//
  final _pages = [
    const SongsPage(),
    const ArtistsPage(),
    const AlbumsPage(),
    const PlaylistsPage(),
  ];
}
