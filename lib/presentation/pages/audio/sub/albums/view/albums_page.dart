import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_player/data/models/album_model.dart';
import 'package:open_player/presentation/pages/audio/sub/albums/widgets/album_card.dart';
import '../../../../../../data/models/audio_model.dart';
import '../../../../../../logic/audio_bloc/audios_bloc.dart';

class AlbumsPage extends StatelessWidget {
  const AlbumsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudiosBloc, AudiosState>(
      builder: (context, state) {
        if (state is AudiosLoading) {
          return const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is AudiosSuccess) {
          final albums = _getAlbumsFromAudios(state.songs);

          if (albums.isEmpty) {
            return const SliverToBoxAdapter(
              child: Center(
                child: Text('No albums found'),
              ),
            );
          }

          return SliverPadding(
            padding:
                const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 100),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final album = albums[index];
                  return AlbumCard(album: album, state: state);
                },
                childCount: albums.length,
              ),
            ),
          );
        }

        return const SliverToBoxAdapter(
          child: Center(
            child: Text('Something went wrong'),
          ),
        );
      },
    );
  }

  //------------- Methods -------//

  List<AlbumModel> _getAlbumsFromAudios(List<AudioModel> audios) {
    // Create a map to group songs by album
    final albumMap = <String, List<AudioModel>>{};

    for (var audio in audios) {
      if (!albumMap.containsKey(audio.album)) {
        albumMap[audio.album] = [];
      }
      albumMap[audio.album]!.add(audio);
    }

    // Convert the map to list of Album objects
    return albumMap.entries.map((entry) {
      final songs = entry.value;
      // Use the first song's data for album details
      final firstSong = songs.first;

      return AlbumModel(
        name: entry.key,
        artist: firstSong.artists,
        songCount: songs.length,
        songs: songs,
        thumbnail: firstSong.thumbnail,
        year: firstSong.year,
        quality: firstSong.quality,
      );
    }).toList()
      ..sort((a, b) => a.name.compareTo(b.name)); // Sort alphabetically
  }
}
