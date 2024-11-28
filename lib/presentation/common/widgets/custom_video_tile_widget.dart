import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_player/base/assets/fonts/styles.dart';
import 'package:open_player/base/router/router.dart';
import 'package:open_player/data/models/video_model.dart';
import 'package:open_player/data/services/favorites_video_hive_service/favorites_video_hive_service.dart';
import 'package:open_player/data/services/file_service/file_service.dart';
import 'package:open_player/data/services/recently_played_videos/recently_played_videos.dart';
import 'package:open_player/logic/audio_player_bloc/audio_player_bloc.dart';
import 'package:open_player/logic/video_player_bloc/video_player_bloc.dart';
import 'package:open_player/logic/videos_bloc/videos_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomVideoTileWidget extends StatelessWidget {
  const CustomVideoTileWidget(
      {super.key,
      required this.filteredVideos,
      required this.videoTitle,
      required this.video,
      required this.index});

  final List<VideoModel> filteredVideos;
  final String videoTitle;
  final VideoModel video;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: VisualDensity.comfortable,
      onTap: () async {
        context.read<AudioPlayerBloc>().add(AudioPlayerStopEvent());
        context.read<VideoPlayerBloc>().add(
            VideoInitializeEvent(videoIndex: index, playlist: filteredVideos));
        GoRouter.of(context).push(
          AppRoutes.videoPlayerRoute,
        );
        await RecentlyPlayedVideosServices().update(video.path);
      },
      title:
          videoTitle.text.fontFamily(AppFonts.poppins).maxFontSize(14).make(),
      leading: const Icon(HugeIcons.strokeRoundedFileVideo),
      trailing: IconButton(
        onPressed: () {
          final isFavorite =
              FavoritesVideoHiveService().getFavoriteStatus(video.path);

          VxBottomSheet.bottomSheetView(context,
              child: Card(
                child: Column(
                  children: [
                    ListTile(
                      onTap: () {
                        FavoritesVideoHiveService().toggleFavorite(video.path);
                        context.pop();
                      },
                      title: Text(
                        isFavorite
                            ? "Remove from Favorites"
                            : "Add to Favorite",
                      ),
                      trailing: Icon(isFavorite
                          ? Icons.favorite
                          : HugeIcons.strokeRoundedFavourite),
                    ),
                    const ListTile(
                      title: Text(
                        "Rename",
                      ),
                      trailing: Icon(Icons.text_snippet),
                    ),
                    ListTile(
                      onTap: () {
                        FileService().deleteFile(video.path).whenComplete(
                          () {
                            context.read<VideosBloc>().add(VideosLoadEvent());
                            context.pop();

                            VxToast.show(context, msg: "Video Deleted");
                          },
                        );
                      },
                      title: Text(
                        "Delete",
                      ),
                      trailing: Icon(Icons.delete),
                    ),
                    ListTile(
                      onTap: () async {
                        await Share.shareXFiles([XFile(video.path)]);
                      },
                      title: Text(
                        "Share",
                      ),
                      trailing: Icon(HugeIcons.strokeRoundedShare01),
                    ),
                  ],
                ),
              ));
        },
        icon: const Icon(HugeIcons.strokeRoundedMoreVerticalCircle01),
      ),
    );
  }
}
