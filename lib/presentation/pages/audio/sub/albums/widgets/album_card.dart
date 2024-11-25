import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:open_player/base/router/router.dart';
import 'package:open_player/data/models/album_model.dart';
import 'package:open_player/logic/audio_bloc/audios_bloc.dart';
import 'package:open_player/presentation/common/widgets/quality_badge/quality_badge_widget.dart';
import 'package:open_player/presentation/pages/audio/sub/albums/view/albums_page.dart';

class AlbumCard extends StatelessWidget {
  final AlbumModel album;

  const AlbumCard({
    super.key,
    required this.album,
    required this.state
  });

  final AudiosSuccess state;

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
          context.push(AppRoutes.albumPreviewRoute,extra: [album, state]);
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
