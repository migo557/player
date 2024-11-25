import 'package:flutter/material.dart';
import 'package:open_player/data/models/audio_model.dart';

class ArtistModel {
  final String name;
  final int songCount;
  final int albumCount;
  final FileImage? picture;
  final List<AudioModel> songs;

  const ArtistModel(
      {required this.name,
      required this.songCount,
      required this.albumCount,
      required this.songs,
      this.picture});
}
