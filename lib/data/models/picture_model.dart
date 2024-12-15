import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'picture_model.g.dart';

@HiveType(typeId: 3)
class PictureModel {
  @HiveField(0)
  final Uint8List bytes;
  @HiveField(1)
  final String mimetype;

  PictureModel({
    required this.bytes,
    required this.mimetype,
  });
}
