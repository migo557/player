import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:open_player/base/assets/images/app_images.dart';
import 'package:open_player/base/router/router.dart';
import 'package:open_player/data/models/audio_playlist_model.dart';
import 'package:open_player/logic/audio_playlist_bloc/audio_playlist_bloc.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../../../utils/app_menu.dart';

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
                  indent: 80,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class PlaylistTile extends StatelessWidget {
  final String title;
  final String trackCount;
  final String imageAsset;
  final AudioPlaylistModel playlist;
  const PlaylistTile(
      {super.key,
      required this.title,
      required this.trackCount,
      required this.imageAsset,
      required this.playlist});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.push(AppRoutes.playlistPreviewRoute, extra: playlist);
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage(imageAsset),
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        trackCount,
        style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
      ),
      trailing: GestureDetector(
        onTapDown: (details) {
          Offset position = details.globalPosition;
          AppMenuHelper.showPopMenuAtPosition(
              context: context,
              position: position,
              items: [
                _deletePlaylist(context, playlist),
              ]);
        },
        child: Icon(HugeIcons.strokeRoundedMoreVertical,
            color: Colors.grey.shade500),
      ),
    );
  }

  //----------------------------------------------------//
  ///-----------------  Widgets  --------------------///
  ///-------------------------------------------------///

  ///--------------- Delete a Playlist
  PopupMenuItem<dynamic> _deletePlaylist(
      BuildContext context, AudioPlaylistModel playlist) {
    return PopupMenuItem(
      onTap: () {
        context.read<AudioPlaylistBloc>().add(DeletePlaylistEvent(playlist));
      },
      child: ListTile(
        title: Text("Delete"),
        trailing: Icon(Icons.delete),
      ),
    );
  }
}

class PlaylistFloatingButton extends HookWidget {
  const PlaylistFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<String> playlistName = useState("");
    return FloatingActionButton(
      onPressed: () {
        showCreateAudioPlaylistDialog(context, playlistName);
      },
      child: Icon(
        HugeIcons.strokeRoundedPlayListAdd,
      ),
    ).pOnly(bottom: 100, right: 10);
  }
}

Future<Object?> showCreateAudioPlaylistDialog(
    BuildContext context, ValueNotifier<String> playlistName) {
  return showGeneralDialog(
    context: context,
    pageBuilder: (context, animation, secondaryAnimation) => Dialog(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            "Create Playlist".text.xl2.bold.make(),
            Gap(15),
            TextField(
              onChanged: (v) {
                playlistName.value = v.trim();
              },
              decoration: InputDecoration(
                  suffixIcon: Icon(HugeIcons.strokeRoundedPlayList),
                  hintText: "Your playlist name"),
            ),
            Gap(10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: Text("Cancel"),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<AudioPlaylistBloc>().add(CreatePlaylistEvent(
                          AudioPlaylistModel(
                              name: playlistName.value,
                              created: DateTime.now(),
                              modified: DateTime.now(),
                              audios: [])));
                      context.pop();
                    },
                    child: Text("Create"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}
