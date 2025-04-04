import 'package:color_log/color_log.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:open_player/base/assets/fonts/styles.dart';
import 'package:open_player/base/db/hive_service.dart';
import 'package:open_player/base/router/router.dart';
import 'package:open_player/data/models/video_model.dart';
import 'package:open_player/data/services/favorites_video_hive_service/favorites_video_hive_service.dart';
import 'package:open_player/data/services/file_service/file_service.dart';
import 'package:open_player/logic/audio_player_bloc/audio_player_bloc.dart';
import 'package:open_player/logic/video_player_bloc/video_player_bloc.dart';
import 'package:open_player/logic/videos_bloc/videos_bloc.dart';
import 'package:open_player/utils/extensions.dart';
import 'package:share_plus/share_plus.dart';
import 'package:velocity_x/velocity_x.dart';

class ElegantVideoTileWidget extends StatelessWidget {
  final List<VideoModel> filteredVideos;
  final String videoTitle;
  final VideoModel video;
  final int index;

  const ElegantVideoTileWidget({
    super.key,
    required this.filteredVideos,
    required this.videoTitle,
    required this.video,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.themeCubit.state.isDarkMode;
    return GestureDetector(
      onTap: () => _playVideo(context),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.black54 : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: isDarkMode ? Colors.white12 : Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Video Thumbnail
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Stack(
                children: [
                  video.thumbnail == null
                      ? Icon(
                          HugeIcons.strokeRoundedVideoReplay,
                          color: Theme.of(context).primaryColor,
                          size: 24,
                        )
                      : Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: MemoryImage(video.thumbnail!),
                          )),
                        ),
                  CircleAvatar(
                    backgroundColor: isDarkMode ? Colors.white : Colors.black,
                    radius: 6,
                    child: Text(
                      (index + 1).toString(),
                      style: TextStyle(
                          fontSize: 8,
                          color: isDarkMode ? Colors.black : Colors.white),
                    ),
                  ).positioned(bottom: 0, right: 0)
                ],
              ),
            ),

            // Title
            Expanded(
              child: Text(
                videoTitle,
                style: TextStyle(
                  fontFamily: AppFonts.poppins,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: isDarkMode ? null : Colors.black87,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            // More Options
            IconButton(
              icon: Icon(
                CupertinoIcons.ellipsis,
                color: isDarkMode ? null : Colors.grey.shade600,
              ),
              onPressed: () => _showVideoOptions(context),
            ),
          ],
        ),
      ),
    );
  }

  void _playVideo(BuildContext context) {
    try {
      context.read<AudioPlayerBloc>().add(AudioPlayerStopEvent());
      context.read<VideoPlayerBloc>().add(
            VideoInitializeEvent(videoIndex: index, playlist: filteredVideos),
          );
      GoRouter.of(context).push(AppRoutes.videoPlayerRoute);

      //---- Saving last played video in hive
      MyHiveBoxes.videoPlayback
          .put(MyHiveKeys.lastPlayedVideo, filteredVideos[index]);
    } catch (e) {
      clog.error(e.toString());
    }
  }

  void _showVideoOptions(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text(
          'Video Options',
          style: TextStyle(
            fontFamily: AppFonts.poppins,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: <CupertinoActionSheetAction>[
          // Favorite Option
          _buildActionSheetAction(
            context,
            text: _getFavoriteText(),
            icon: _getFavoriteIcon(),
            onPressed: () => _toggleFavorite(),
          ),

          // Rename Option
          _buildActionSheetAction(
            context,
            text: 'Rename',
            icon: CupertinoIcons.pencil,
            onPressed: () => _renameVideo(context),
          ),

          // Hide/Unhide Option
          _buildActionSheetAction(
            context,
            text: FileService().isFileHidden(video.path) ? 'Unhide' : 'Hide',
            icon: FileService().isFileHidden(video.path)
                ? CupertinoIcons.eye
                : CupertinoIcons.eye_slash,
            onPressed: () => _toggleHideVideo(context),
          ),

          // Delete Option
          _buildActionSheetAction(
            context,
            text: 'Delete',
            icon: CupertinoIcons.delete,
            onPressed: () => _deleteVideo(context),
            isDestructiveAction: true,
          ),

          // Share Option
          _buildActionSheetAction(
            context,
            text: 'Share',
            icon: CupertinoIcons.share,
            onPressed: () => _shareVideo(),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Cancel',
            style: TextStyle(
              fontFamily: AppFonts.poppins,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
    );
  }

  CupertinoActionSheetAction _buildActionSheetAction(
    BuildContext context, {
    required String text,
    required IconData icon,
    required VoidCallback onPressed,
    bool isDestructiveAction = false,
  }) {
    return CupertinoActionSheetAction(
      onPressed: () {
        Navigator.pop(context);
        onPressed();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isDestructiveAction ? Colors.red : null,
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              fontFamily: AppFonts.poppins,
              color: isDestructiveAction ? Colors.red : null,
            ),
          ),
        ],
      ),
    );
  }

  String _getFavoriteText() {
    final isFavorite =
        FavoritesVideoHiveService().getFavoriteStatus(video.path);
    return isFavorite ? 'Remove from Favorites' : 'Add to Favorites';
  }

  IconData _getFavoriteIcon() {
    final isFavorite =
        FavoritesVideoHiveService().getFavoriteStatus(video.path);
    return isFavorite ? CupertinoIcons.heart_fill : CupertinoIcons.heart;
  }

  void _toggleFavorite() {
    FavoritesVideoHiveService().toggleFavorite(video.path);
  }

  void _renameVideo(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        final controller = TextEditingController(text: videoTitle);
        return CupertinoAlertDialog(
          title: Text(
            'Rename Video',
            style: TextStyle(fontFamily: AppFonts.poppins),
          ),
          content: CupertinoTextField(
            controller: controller,
            placeholder: 'Enter new name',
            style: TextStyle(fontFamily: AppFonts.poppins),
          ),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(fontFamily: AppFonts.poppins),
              ),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () {
                FileService()
                    .renameFile(video.path, controller.text.trim(), context)
                    .whenComplete(() {
                  context.read<VideosBloc>().add(VideosLoadEvent());
                  Navigator.pop(context);
                });
              },
              child: Text(
                'Rename',
                style: TextStyle(fontFamily: AppFonts.poppins),
              ),
            ),
          ],
        );
      },
    );
  }

  void _toggleHideVideo(BuildContext context) {
    FileService().toggleHideFile(video.path).whenComplete(() {
      context.read<VideosBloc>().add(VideosLoadEvent());
    });
  }

  void _deleteVideo(BuildContext context) {
    FileService().deleteFile(video.path).whenComplete(() {
      context.read<VideosBloc>().add(VideosLoadEvent());
      // You might want to add a toast or snackbar here
    });
  }

  void _shareVideo() async {
    await Share.shareXFiles([XFile(video.path)]);
  }
}
