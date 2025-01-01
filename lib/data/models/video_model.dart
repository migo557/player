import 'package:flutter/services.dart';
import 'package:hive/hive.dart';


part 'video_model.g.dart';

@HiveType(typeId: 4)
class VideoModel {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String ext;
  @HiveField(2)
  final String path;
  @HiveField(3)
  final int fileSize;
  @HiveField(4)
  final Uint8List? thumbnail;
  @HiveField(5)
  final DateTime lastAccessed;
  @HiveField(6)
  final DateTime lastModified;

  VideoModel(
      {required this.title,
      required this.ext,
      required this.path,
      required this.fileSize,
      required this.thumbnail,
      required this.lastAccessed,
      required this.lastModified});
}
