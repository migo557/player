import 'package:flutter/material.dart';
import 'package:open_player/base/theme/app_textstyles.dart';

class AppThemes {
  ///----------Light Mode-------------///
  static final ThemeData lightTheme =
      ThemeData.light(useMaterial3: true).copyWith(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
    tabBarTheme: const TabBarTheme(
        labelStyle: AppTextStyles.tabBarSelectedLabelStyleLightMode,
        unselectedLabelStyle:
            AppTextStyles.tabBarUnselectedLabelStyleLightMode),
  );

  ///----------Dark Mode -----------------///
  static final ThemeData darkTheme =
      ThemeData.dark(useMaterial3: true).copyWith(
    tabBarTheme: const TabBarTheme(
        labelStyle: AppTextStyles.tabBarSelectedLabelStyleDarkMode,
        unselectedLabelStyle: AppTextStyles.tabBarUnselectedLabelStyleDarkMode),
  );
}
