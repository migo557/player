import 'package:open_player/base/db/hive_service.dart';

class FavoritesAudioHiveService {
  final _box = MyHiveBoxes.favoriteAudios;


  _addToFavorite(int audioId) async {
    await _box.put(audioId, true);
  }

  _removeFromFavorite(int audioId) async {
    await _box.put(audioId, false);
  }

  _checkIsContain(int audioId) {
    return _box.containsKey(audioId);
  }

  bool getFavoriteStatus(int audioId) {
    bool v = _box.get(audioId, defaultValue: false);
    return v;
  }

  toggleFavorite(int audioId) {
    if (_checkIsContain(audioId)) {
      if (getFavoriteStatus(audioId)) {
        _removeFromFavorite(audioId);
      } else {
        _addToFavorite(audioId);
      }
    } else {
      _addToFavorite(audioId);
    }
  }
}
