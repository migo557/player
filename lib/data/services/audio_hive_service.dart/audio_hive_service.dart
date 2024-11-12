import 'package:open_player/base/db/hive_service.dart';

class AudioHiveService {
  final _box = MyHiveBoxes.favoriteAudios;

  _addToFavorite(String filePath) async {
    await _box.put(filePath, true);
  }

  _removeFromFavorite(String filePath) async {
    await _box.put(filePath, false);
  }

  _checkIsContain(String filePath) => _box.containsKey(filePath);

  bool checkIsFaoriteStatus(String filePath) {
    bool v = _box.get(filePath, defaultValue: false);
    return v;
  }

  toggleFavorite(String filePath) {
    if (_checkIsContain(filePath)) {
      if (checkIsFaoriteStatus(filePath)) {
        _removeFromFavorite(filePath);
      } else {
        _addToFavorite(filePath);
      }
    } else {
      _addToFavorite(filePath);
    }
  }
}
