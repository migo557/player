// user_repository.dart
import 'package:open_player/base/db/hive_service.dart';

abstract class UserServices {
  Future<void> updateProfilePicture(String path);
  Future<void> updateUsername(String username);
  Future<void> updateLoginStatus(bool status);
  String? getProfilePicture();
  String getUsername();

  bool getLoginStatus();
}

class UserServiceImpl implements UserServices {
  @override
  Future<void> updateProfilePicture(String path) async {
    await MyHiveBoxes.userBox.put(MyHiveKeys.userProfilePicture, path);
  }

  @override
  Future<void> updateUsername(String username) async {
    await MyHiveBoxes.userBox.put(MyHiveKeys.userUsername, username);
  }

  @override
  Future<void> updateLoginStatus(bool status) async {
    await MyHiveBoxes.userBox.put(MyHiveKeys.userIsLoggedIn, status);
  }

  @override
  String? getProfilePicture() {
    return MyHiveBoxes.userBox.get(MyHiveKeys.userProfilePicture);
  }

  @override
  String getUsername() {
    return MyHiveBoxes.userBox
        .get(MyHiveKeys.userUsername, defaultValue: 'User');
  }

  @override
  bool getLoginStatus() {
    return MyHiveBoxes.userBox
        .get(MyHiveKeys.userIsLoggedIn, defaultValue: false);
  }
}
