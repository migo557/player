import 'dart:typed_data';

import 'package:open_player/data/models/audio_model.dart';

class AlbumModel {
  final String name;
  final String artist;
  final int songCount;
  final List<AudioModel> songs;
  final Uint8List thumbnail;
  final DateTime? year;
  final String quality;

  AlbumModel({
    required this.name,
    required this.artist,
    required this.songCount,
    required this.songs,
    required this.thumbnail,
    required this.year,
    required this.quality,
  });
}
