import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_player/base/assets/images/app_images.dart';
import 'package:open_player/logic/audio_playlist_bloc/audio_playlist_bloc.dart';
import 'package:open_player/presentation/pages/audio/sub/playlists/widgets/playlist_floating_button.dart';
import 'package:open_player/presentation/pages/audio/sub/playlists/widgets/playlist_tile.dart';

class PlaylistsPage extends StatelessWidget {
  const PlaylistsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const PlaylistFloatingButton(),
      body: BlocBuilder<AudioPlaylistBloc, AudioPlaylistState>(
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              SliverPadding(padding: EdgeInsets.only(top: 12)),
              // Playlist Items
              SliverList.separated(
                itemCount: state.playlists.length,
                itemBuilder: (context, index) => PlaylistTile(
                  title: state.playlists[index].name,
                  trackCount: "${state.playlists[index].audios.length} tracks",
                  imageAsset: AppImages.defaultProfile,
                  playlist: state.playlists[index],
                ),
                separatorBuilder: (context, index) => const Divider(
                  height: 1,
                  color: Colors.grey,
                  indent: 100,
                ),
              ),

              SliverPadding(padding: EdgeInsets.only(bottom: 10)),
            ],
          );
        },
      ),
    );
  }
}
