import 'package:open_player/base/db/hive_service.dart';

class FavoritesVideoHiveService {
  final _box = MyHiveBoxes.favoriteVideos;

  String _generateKey(String filePath) {
    return '${filePath.hashCode}_${filePath.split('/').last}';
  }

  _addToFavorite(String filePath) async {
    final key = _generateKey(filePath);
    await _box.put(key, true);
  }

  _removeFromFavorite(String filePath) async {
    final key = _generateKey(filePath);
    await _box.put(key, false);
  }

  _checkIsContain(String filePath) {
    final key = _generateKey(filePath);
    return _box.containsKey(key);
  }

 bool getFavoriteStatus(String filePath)  {
    final key = _generateKey(filePath);
    bool v =  _box.get(key, defaultValue: false);
    return v;
  }

  toggleFavorite(String filePath) async{
    if (_checkIsContain(filePath)) {
      if (getFavoriteStatus(filePath)) {
        _removeFromFavorite(filePath);
      } else {
        _addToFavorite(filePath);
      }
    } else {
      _addToFavorite(filePath);
    }
  }
}
