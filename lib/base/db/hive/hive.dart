import 'dart:developer';
import 'dart:io';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class MyHiveDB {
  static Future<void> initializeHive() async {
    try {
      log('Initializing Hive');
      //! Ensure Hive is initialized before using it
      final Directory appDocumentDirectory =
          await path_provider.getApplicationDocumentsDirectory();
      Hive.init(appDocumentDirectory.path);

      await Future.wait([
        //! Open the library box
        Hive.openBox('theme'),
      ]).then(
        (value) {
          MyHiveBoxes.themeBox = value[0];
        },
      );

      log('Hive initialized');
    } catch (e, stackTrace) {
      log('Hive initialization error: $e', stackTrace: stackTrace);
    }
  }
}

///!----------------    MyHive Boxes
class MyHiveBoxes {
  static late Box themeBox;
}

///!---------------      MyHive Keys
class MyHiveKeys {
  static const String profilePicHiveKey = "hive_profile_pic";
  static const String profileUsernameHiveKey = "hive_username";
  static const String isDarkMode = "dm";
  static const String isBlackMode = "bm";
  static const String defaultTheme = "dt";
  static const String useMaterial3 = "m3";
  static const String isDefaultScaffoldColor = "dsc";
  static const String isDefaultAppBarColor = "dac";
  static const String isDefaultBottomNavBarBgColor = "dbnbc";
  static const String isDefaultBottomNavBarPosition = "dbnbp";
  static const String contrastLevel = "cl";
  static const String customScaffoldColor = "csc";
  static const String customAppBarColor = "cabc";
  static const String customBottomNavBarBgColor = "cbnbbc";
  static const String flexThemeListIndex = "ftli";
  static const String bottomNavBarPositionFromLeft = "bnbpfl";
  static const String bottomNavBarPositionFromBottom = "bnbpfb";
  static const String bottomNavBarWidth = "bnbw";
  static const String bottomNavBarHeight = "bnbh";
  static const String isHoldBottomNavBarCirclePositionButton = "hbnbcpb";
}
