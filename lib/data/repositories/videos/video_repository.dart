// video_repository.dart
import 'dart:io';
import 'package:color_log/color_log.dart';
import 'package:open_player/data/providers/videos/video_provider.dart';
import '../../../base/services/permissions/app_permission_service.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;

import '../../models/video_model.dart';

class VideoRepository {
  final VideoProvider videoProvider;

  VideoRepository(this.videoProvider);

  Future<List<VideoModel>> getVideoFiles() async {
    try {
      final bool hasPermission = await AppPermissionService.storagePermission();

      if (!hasPermission) {
        clog.error('Storage permission not granted');
        clog.warning(' Let;s Accessing it Storage permission again...');
        await AppPermissionService.storagePermission().then(
          (value) {
            clog.error(' Again Storage permission not granted');
          },
        );
        return [];
      }

      final List<String> videosPath =
          await videoProvider.fetchAllVideoFilePaths();

      final List<VideoModel> videos =
          await Future.wait(videosPath.map((videoPath) async {
        return await getVideoInfo(videoPath);
      }));

      clog.info('Found ${videos.length} videos');
      return videos;
    } catch (e) {
      clog.error('Error fetching video files: $e');
      return [];
    }
  }

  Future<VideoModel> getVideoInfo(String videoPath) async {

    //------- Get Thumbnail from Video -------------------//
    //  final Uint8List uint8list = await VideoThumbnail.thumbnailData(
    //   video: videoPath,
    //   quality: 25,
    // );


    return VideoModel(
      title: path.basenameWithoutExtension(videoPath),
      ext: path.extension(videoPath),
      path: videoPath,
      fileSize: File(videoPath).statSync().size,
      thumbnail: null,
    );
  }
}
