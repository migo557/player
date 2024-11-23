// video_player/presentation/pages/video_player_page.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:open_player/data/services/favorites_video_hive_service/favorites_video_hive_service.dart';

class VideoPlayerHMoreButtonWidget extends StatelessWidget {
  const VideoPlayerHMoreButtonWidget({super.key, required this.filePath});

  final String filePath;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.more_horiz, color: Colors.white),
      onPressed: () async {
      final isFavorite =  FavoritesVideoHiveService().getFavoriteStatus(filePath);
          if  (isFavorite) {
            showCupertinoModalPopup(
              context: context,
              builder: (context) => Card(
                child: SizedBox(
                    height: 100,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ListTile(
                            onTap: () {
                              FavoritesVideoHiveService()
                                  .toggleFavorite(filePath);
                              context.pop();
                            },
                            title: Text(isFavorite
                                ? "Remove from favorites"
                                : "Add to favorite"),
                            trailing: Icon(isFavorite
                                ? Icons.favorite
                                : Icons.favorite_outline),
                          )
                        ],
                      ),
                    )),
              ),
            );
          }
      },
    );
  }
}
