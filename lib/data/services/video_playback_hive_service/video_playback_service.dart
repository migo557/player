import '../../../base/db/hive_service.dart';

class VideoPlaybackHiveService {
  final _box = MyHiveBoxes.videoPlayback;
  String _generateKey(String filePath) {
    return '${filePath.hashCode}_${filePath.split('/').last}';
  }

  update(String path, int value) {
    try {
    final key =  _generateKey(path);
      _box.put(key, value);
    } catch (e) {
      throw Exception(e);
    }
  }

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
