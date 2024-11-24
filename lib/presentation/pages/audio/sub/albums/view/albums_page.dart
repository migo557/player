import 'package:audio_metadata_reader/audio_metadata_reader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../data/models/audio_model.dart';
import '../../../../../../logic/audio_bloc/audios_bloc.dart';
import '../../../../../common/widgets/quality_badge/quality_badge_widget.dart';

class AlbumModel {
  final String name;
  final String artist;
  final int songCount;
  final List<AudioModel> songs;
  final List<Picture> thumbnail;
  final DateTime? year;
  final Quality quality;

  AlbumModel({
    required this.name,
    required this.artist,
    required this.songCount,
    required this.songs,
    required this.thumbnail,
    required this.year,
    required this.quality,
  });
}

class AlbumsPage extends StatelessWidget {
  const AlbumsPage({super.key});

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
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                  return AlbumCard(album: album);
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
}

class AlbumCard extends StatelessWidget {
  final AlbumModel album;

  const AlbumCard({
    super.key,
    required this.album,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () {
          // Navigate to album details with songs
          // You can implement navigation here
        },
        borderRadius: BorderRadius.circular(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Album Cover
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(15)),
                child: album.thumbnail.isNotEmpty
                    ? Image.memory(
                        album.thumbnail.first.bytes,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        child: Icon(
                          Icons.album,
                          size: 64,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
              ),
            ),
            // Album Info
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          album.name,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          album.artist,
                          style: TextStyle(fontSize: 9),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${album.songCount} songs',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        QualityBadge(quality: album.quality),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
