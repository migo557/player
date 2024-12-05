// video_repository.dart
import 'dart:io';
import 'package:color_log/color_log.dart';
import 'package:open_player/data/providers/videos/video_provider.dart';
import 'package:video_compress/video_compress.dart';
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
    final uint8list = await VideoCompress.getByteThumbnail(videoPath,
        quality: 50, // default(100)
        position: -1 // default(-1)
        );


    return VideoModel(
      title: path.basenameWithoutExtension(videoPath),
      ext: path.extension(videoPath),
      path: videoPath,
      fileSize: File(videoPath).statSync().size,
      lastAccessed: File(videoPath).lastAccessedSync(),
      lastModified: File(videoPath).lastModifiedSync(),
      thumbnail: uint8list,
    );
  }
}
