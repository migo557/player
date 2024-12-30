// video_repository.dart
import 'dart:io';
import 'package:color_log/color_log.dart';
import 'package:open_player/data/providers/videos/video_provider.dart';
import '../../../base/services/permissions/app_permission_service.dart';
import 'package:path/path.dart' as path;
import '../../models/video_model.dart';

abstract class VideoRepositoryBase {
  Future<List<VideoModel>> getVideoFiles();
  Future<VideoModel> getVideoInfo(String videoPath);
}

class VideoRepository implements VideoRepositoryBase {
  final VideoProvider videoProvider;

  VideoRepository(this.videoProvider);

  @override
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

  @override
  Future<VideoModel> getVideoInfo(String videoPath) async {
    //------- Get Thumbnail from Video -------------------//
    // final uint8list = await _VideoThumbnailIsolate.generateThumbnail(videoPath);

    return VideoModel(
      title: path.basenameWithoutExtension(videoPath),
      ext: path.extension(videoPath),
      path: videoPath,
      fileSize: File(videoPath).statSync().size,
      lastAccessed: File(videoPath).lastAccessedSync(),
      lastModified: File(videoPath).lastModifiedSync(),
      thumbnail: null,
    );
  }
}

//------ Get Video Thubnail In Isolation

// class _VideoThumbnailIsolate {
//   static Future<Uint8List?> generateThumbnail(String videoPath) async {
//     // Create a receive port to get results from the isolate
//     final receivePort = ReceivePort();

//     try {
//       // Spawn the isolate
//       await Isolate.spawn(
//           _thumbnailGeneratorIsolate,
//           ThumbnailRequest(
//               sendPort: receivePort.sendPort, videoPath: videoPath));

//       // Wait for the result from the isolate
//       final result = await receivePort.first;

//       // Return the thumbnail or null
//       return result as Uint8List?;
//     } catch (e) {
//       clog.error('Thumbnail generation error: $e');
//       return null;
//     }
//   }

//   // Static method to run in the isolate
//   static void _thumbnailGeneratorIsolate(ThumbnailRequest request) async {
//     try {
//       // Generate thumbnail
//       final thumbnail = await VideoCompress.getByteThumbnail(
//         request.videoPath,
//         quality: 30, // Adjust quality as needed
//       );

//       // Send the result back to the main isolate
//       request.sendPort.send(thumbnail);
//     } catch (e) {
//       // Send null if thumbnail generation fails
//       request.sendPort.send(null);
//     }
//   }
// }

// Helper class to pass data to the isolate
// class ThumbnailRequest {
//   final SendPort sendPort;
//   final String videoPath;

//   ThumbnailRequest({required this.sendPort, required this.videoPath});
// }
