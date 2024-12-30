import '../../../base/db/hive_service.dart';

abstract class VideoPlaybackHiveServiceBase {
  update(String path, int value);
  int? getValue(String path);
}

class VideoPlaybackHiveService implements VideoPlaybackHiveServiceBase {
  final _box = MyHiveBoxes.videoPlayback;

  String _generateKey(String filePath) {
    return '${filePath.hashCode}_${filePath.split('/').last}';
  }

  @override
  update(String path, int value) {
    try {
      final key = _generateKey(path);
      _box.put(key, value);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  int? getValue(String path) {
    try {
      final key = _generateKey(path);
      bool isAvailable = _box.containsKey(key);
      if (isAvailable) {
        int value = _box.get(key, defaultValue: 0);
        return value;
      }
      return null;
    } catch (e) {
      throw Exception(e);
    }
  }
}
