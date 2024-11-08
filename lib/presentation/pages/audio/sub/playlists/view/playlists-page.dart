import 'package:flutter/material.dart';

class PlaylistsPage extends StatelessWidget {
  const PlaylistsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
        child: Center(
      child: Text("Playlists"),
    ));
  }
}
