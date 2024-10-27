// user_repository.dart
import 'package:open_player/base/db/hive/hive.dart';

class UserRepository {
  Future<void> updateProfilePicture(String path) async {
    await MyHiveBoxes.userBox.put(MyHiveKeys.userProfilePicture, path);
  }

  Future<void> updateUsername(String username) async {
    await MyHiveBoxes.userBox.put(MyHiveKeys.userUsername, username);
  }

  Future<void> updateLoginStatus(bool status) async {
    await MyHiveBoxes.userBox.put(MyHiveKeys.userIsLoggedIn, status);
  }

  String? getProfilePicture() {
    return  MyHiveBoxes.userBox.get(MyHiveKeys.userProfilePicture);
  }

  String getUsername() {
    return MyHiveBoxes.userBox
        .get(MyHiveKeys.userUsername, defaultValue: 'User');
  }

  bool getLoginStatus() {
    return MyHiveBoxes.userBox.get(MyHiveKeys.userIsLoggedIn, defaultValue: false);
  }
}
