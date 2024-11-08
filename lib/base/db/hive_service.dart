import 'dart:io';
import 'package:color_log/color_log.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class MyHiveDB {
  static Future<void> initializeHive() async {
    try {
      clog.info('Initializing Hive');
      //! Ensure Hive is initialized before using it
      final Directory appDocumentDirectory =
          await path_provider.getApplicationDocumentsDirectory();
      Hive.init(appDocumentDirectory.path);

      await Future.wait([
        //! Open the library box
        Hive.openBox('theme'),
        //! Open the language box
        Hive.openBox('language'),

        //! Open the language box
        Hive.openBox('user'),
      ]).then(
        (value) {
          MyHiveBoxes.themeBox = value[0];
          MyHiveBoxes.languageBox = value[1];
          MyHiveBoxes.userBox = value[2];
        },
      );

      clog.info('Hive initialized');
    } catch (e) {
      clog.error(
        'Hive initialization error: $e',
      );
    }
  }
}

///!----------------    MyHive Boxes
class MyHiveBoxes {
  static late Box themeBox;
  static late Box languageBox;
  static late Box userBox;
}

///!---------------      MyHive Keys
class MyHiveKeys {
  static const String defaultLanguage = "app_locale";
  static const String primaryColor = "theme_ primary_Color";
  static const String userProfilePicture = "hive_user_profile_pic";
  static const String userUsername = "hive_username";
  static const String userIsLoggedIn = "hive_user_login_status";
  static const String bottomNavBarRotation = "bottomNavBarTransform";
  static const String bottomNavBarIconRotation = "bottomNavBarIconTransform";

  static const String isDarkMode = "dm";
  static const String isBlackMode = "bm";
  static const String defaultTheme = "dt";
  static const String useMaterial3 = "m3";
  static const String isDefaultScaffoldColor = "dsc";

  static const String isDefaultAppBarColor = "dac";
  static const String isDefaultBottomNavBarBgColor = "dbnbc";
  static const String isDefaultBottomNavBarPosition = "dbnbp";
  static const String isDefaultBottomNavBarRotation = "dbnbT";
  static const String isDefaultBottomNavBarIconRotation = "dbnbIT";


  static const String contrastLevel = "cl";
  static const String customScaffoldColor = "csc";
  static const String customAppBarColor = "cabc";
  static const String customBottomNavBarBgColor = "cbnbbc";
  static const String primaryColorListIndex = "ftli";
  static const String bottomNavBarPositionFromLeft = "bnbpfl";
  static const String bottomNavBarPositionFromBottom = "bnbpfb";
  static const String bottomNavBarWidth = "bnbw";
  static const String bottomNavBarHeight = "bnbh";
  static const String isHoldBottomNavBarCirclePositionButton = "hbnbcpb";
}
