import 'dart:io';
import 'package:color_log/color_log.dart';
import 'package:open_player/data/providers/videos/video_provider.dart';
import '../../../base/services/permissions/app_permission_service.dart';
import 'package:path/path.dart' as path;
import '../../models/video_model.dart';

/// Abstract base class defining the core functionality for video operations.
///
/// This class serves as a contract for implementing video-related operations,
/// ensuring consistent video file handling across the application.
abstract class VideoRepositoryBase {
  /// Retrieves all video files from the device storage.
  /// Returns a list of [VideoModel] objects representing each video.
  Future<List<VideoModel>> getVideoFiles();

  /// Retrieves detailed information about a specific video file.
  /// [videoPath] The path to the video file.
  Future<VideoModel> getVideoInfo(String videoPath);
}

/// Implementation of [VideoRepositoryBase] that handles video file operations.
///
/// This repository is responsible for:
/// - Discovering video files in device storage
/// - Extracting video metadata and information
/// - Managing storage permissions
/// - Creating standardized [VideoModel] objects
/// - Error handling and logging
class VideoRepository implements VideoRepositoryBase {
  /// Provider that handles low-level video file operations
  final VideoProvider videoProvider;

  /// Creates a new instance of [VideoRepository].
  ///
  /// [videoProvider] A required instance of [VideoProvider] for file operations.
  VideoRepository(this.videoProvider);

  /// Fetches all video files from device storage.
  ///
  /// This method:
  /// - Checks and requests storage permissions if needed
  /// - Scans storage for video files
  /// - Creates [VideoModel] objects for each video
  /// - Handles errors gracefully
  ///
  /// Returns:
  /// - List of [VideoModel] objects if successful
  /// - Empty list if permissions are denied or an error occurs
  @override
  Future<List<VideoModel>> getVideoFiles() async {
    try {
      // Check storage permissions
      final bool hasPermission = await AppPermissionService.storagePermission();

      if (!hasPermission) {
        clog.error('Storage permission not granted');
        clog.warning('Attempting to request storage permission again...');

        // Retry permission request
        await AppPermissionService.storagePermission().then(
          (value) {
            clog.error('Storage permission denied on second attempt');
          },
        );
        return [];
      }

      // Fetch video paths and create models
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

  /// Extracts information about a specific video file.
  ///
  /// [videoPath] The absolute path to the video file.
  ///
  /// This method:
  /// - Extracts basic file information
  /// - Creates a [VideoModel] with available metadata
  /// - Handles file system operations safely
  ///
  /// Returns:
  /// A [VideoModel] containing:
  /// - Basic file information (name, extension, path)
  /// - File system metadata (size, dates)
  /// - Optional thumbnail (currently disabled)
  ///
  /// Note: Thumbnail generation is currently disabled but can be
  /// implemented using the commented code below for future enhancement.
  @override
  Future<VideoModel> getVideoInfo(String videoPath) async {
    try {
      final File videoFile = File(videoPath);

      // Create video model with available information
      return VideoModel(
        title: path.basenameWithoutExtension(videoPath),
        ext: path.extension(videoPath),
        path: videoPath,
        fileSize: videoFile.statSync().size,
        lastAccessed: videoFile.lastAccessedSync(),
        lastModified: videoFile.lastModifiedSync(),
        thumbnail: null, // Thumbnail generation currently disabled
      );
    } catch (e) {
      clog.error('Error getting video info for $videoPath: $e');
      // Return a minimal model if processing fails
      return VideoModel(
        title: path.basenameWithoutExtension(videoPath),
        ext: path.extension(videoPath),
        path: videoPath,
        fileSize: 0,
        lastAccessed: DateTime.now(),
        lastModified: DateTime.now(),
        thumbnail: null,
      );
    }
  }
}

/// Utility class for generating video thumbnails in an isolate.
/// 
/// Note: This functionality is currently disabled but preserved for future implementation.
/// To enable thumbnail generation:
/// 1. Uncomment the code
/// 2. Add VideoCompress package to pubspec.yaml
/// 3. Initialize thumbnail generation in getVideoInfo method
/// 
// class _VideoThumbnailIsolate {
//   /// Generates a thumbnail for a video file in a separate isolate.
//   /// 
//   /// [videoPath] The path to the video file.
//   /// 
//   /// Returns:
//   /// - Uint8List containing the thumbnail data if successful
//   /// - null if thumbnail generation fails
//   static Future<Uint8List?> generateThumbnail(String videoPath) async {
//     final receivePort = ReceivePort();
//
//     try {
//       await Isolate.spawn(
//           _thumbnailGeneratorIsolate,
//           ThumbnailRequest(
//               sendPort: receivePort.sendPort, videoPath: videoPath));
//
//       final result = await receivePort.first;
//       return result as Uint8List?;
//     } catch (e) {
//       clog.error('Thumbnail generation error: $e');
//       return null;
//     }
//   }
//
//   /// Isolate worker function for thumbnail generation.
//   /// 
//   /// This runs in a separate isolate to avoid blocking the main thread
//   /// during thumbnail generation.
//   static void _thumbnailGeneratorIsolate(ThumbnailRequest request) async {
//     try {
//       final thumbnail = await VideoCompress.getByteThumbnail(
//         request.videoPath,
//         quality: 30,
//       );
//
//       request.sendPort.send(thumbnail);
//     } catch (e) {
//       request.sendPort.send(null);
//     }
//   }
// }

/// Data class for passing information to the thumbnail generation isolate.
/// 
/// This class bundles the necessary data for thumbnail generation:
/// - [sendPort] Port for communicating back to the main isolate
/// - [videoPath] Path to the video file for thumbnail generation
// class ThumbnailRequest {
//   final SendPort sendPort;
//   final String videoPath;
//
//   ThumbnailRequest({required this.sendPort, required this.videoPath});
// }