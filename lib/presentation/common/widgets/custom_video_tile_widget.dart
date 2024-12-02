import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:open_player/base/assets/fonts/styles.dart';
import 'package:open_player/base/router/router.dart';
import 'package:open_player/data/models/video_model.dart';
import 'package:open_player/data/services/favorites_video_hive_service/favorites_video_hive_service.dart';
import 'package:open_player/data/services/file_service/file_service.dart';
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
      },
      title:
          videoTitle.text.fontFamily(AppFonts.poppins).maxFontSize(14).make(),
      leading: const Icon(HugeIcons.strokeRoundedFileVideo),
      trailing: IconButton(
        onPressed: () {
          VxBottomSheet.bottomSheetView(context,
              child: Card(
                child: Column(
                  children: [
                    _videoAddToFavorite(video.path),
                    //--------- Rename Button
                    _renameVideo(context, video.path, videoTitle),
                    _deleteVideo(context, video.path),
                    _share(video),
                  ],
                ),
              ));
        },
        icon: const Icon(HugeIcons.strokeRoundedMoreVerticalCircle01),
      ),
    );
  }

//----------------------------------------------------//
  ///-----------------  Widgets  --------------------///
  ///-------------------------------------------------///

  ///--------------- A D D  T O  F A V O R I T E
  PopupMenuItem<dynamic> _videoAddToFavorite(path) {
    final isFavorite = FavoritesVideoHiveService().getFavoriteStatus(path);
    return PopupMenuItem(
      onTap: () {
        FavoritesVideoHiveService().toggleFavorite(path);
      },
      child: ListTile(
        title: Text(
          isFavorite ? "Remove from Favorites" : "Add to Favorite",
        ),
        trailing: Icon(
            isFavorite ? Icons.favorite : HugeIcons.strokeRoundedFavourite),
      ),
    );
  }

  ///--------------- R E N A M E
  PopupMenuItem<dynamic> _renameVideo(
      BuildContext context, String path, String title) {
    final oldFileName = title;
    final controller = TextEditingController(text: oldFileName);
    return PopupMenuItem(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => Dialog(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              //-------- Column
              child: [
                Gap(5),
                "Rename".text.bold.xl2.make(),
                VxTextField(
                  controller: controller,
                ),
                Gap(10),

                ///------ Buttons Row
                [
                  ElevatedButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: Text("Cancel"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await FileService()
                          .renameFile(path, controller.text.trim())
                          .whenComplete(
                        () {
                          context.read<VideosBloc>().add(VideosLoadEvent());
                          context.pop();
                        },
                      );
                    },
                    child: Text("Rename"),
                  ),
                ].row(alignment: MainAxisAlignment.spaceBetween),
              ].column(axisSize: MainAxisSize.min),
            ),
          ),
        );
      },
      child: const ListTile(
        title: Text(
          "Rename",
        ),
        trailing: Icon(Icons.text_snippet),
      ),
    );
  }

  ///--------------- D E L E T E
  PopupMenuItem<dynamic> _deleteVideo(
    BuildContext context,
    String path,
  ) {
    return PopupMenuItem(
      onTap: () {
        FileService().deleteFile(path).whenComplete(
          () {
            context.read<VideosBloc>().add(VideosLoadEvent());

            VxToast.show(context, msg: "Video Deleted");
          },
        );
      },
      child: const ListTile(
        title: Text(
          "Delete",
        ),
        trailing: Icon(Icons.delete),
      ),
    );
  }

  ///--------------- Share
  PopupMenuItem<dynamic> _share(VideoModel video) {
    return PopupMenuItem(
      onTap: () async {
        await Share.shareXFiles([XFile(video.path)]);
      },
      child: const ListTile(
        title: Text(
          "Share",
        ),
        trailing: Icon(HugeIcons.strokeRoundedShare01),
      ),
    );
  }
}
