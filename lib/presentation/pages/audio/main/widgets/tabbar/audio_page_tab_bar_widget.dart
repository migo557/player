import 'package:flutter/material.dart';

class AudioPageTabBarWidget extends StatelessWidget {
  AudioPageTabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
        final double mqWidth = MediaQuery.sizeOf(context).width;
    final double mqHeight = MediaQuery.sizeOf(context).height;
    return SliverAppBar(
      toolbarHeight: mqHeight*0.05,
      pinned: true,
      actions: [Expanded(child: TabBar(tabs: _tabList))],
    );
  }

  //------------- Tab List ----------------//
  final List<Tab> _tabList = [
    Tab(
      text: "Songs",
      icon: Icon(Icons.library_music_outlined),
    ),
    const Tab(
      text: "Artists",
        icon: Icon(Icons.person),
    ),
    const Tab(
      text: "Albums",
        icon: Icon(Icons.album),
    ),
    const Tab(
      text: "Playlists",
        icon: Icon(Icons.playlist_play_outlined),
    ),
  ];
}
