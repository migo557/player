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
    await MyHiveBoxes.user.put(MyHiveKeys.userProfilePicture, path);
  }

  @override
  Future<void> updateUsername(String username) async {
    await MyHiveBoxes.user.put(MyHiveKeys.userUsername, username);
  }

  @override
  Future<void> updateLoginStatus(bool status) async {
    await MyHiveBoxes.user.put(MyHiveKeys.userIsLoggedIn, status);
  }

  @override
  String? getProfilePicture() {
    return MyHiveBoxes.user.get(MyHiveKeys.userProfilePicture);
  }

  @override
  String getUsername() {
    return MyHiveBoxes.user.get(MyHiveKeys.userUsername, defaultValue: 'User');
  }

  @override
  bool getLoginStatus() {
    return MyHiveBoxes.user.get(MyHiveKeys.userIsLoggedIn, defaultValue: false);
  }
}
