import '../../../base/db/hive_service.dart';

class VideoPlaybackHiveService {
  final _box = MyHiveBoxes.videoPlayback;

  update(String path, int value) {
    try {
      _box.put(path, value);
    } catch (e) {
      throw Exception(e);
    }
  }

  int? getValue(String path) {
    try {
      bool isAvailable = _box.containsKey(path);
      if (isAvailable) {
        int value = _box.get(path, defaultValue: 0);
        return value;
      }
      return null;
    } catch (e) {
      throw Exception(e);
    }
  }
}
