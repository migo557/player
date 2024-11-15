import 'package:flutter/material.dart';
import 'package:open_player/base/assets/fonts/styles.dart';

class AppTextStyles {
  static const greeting = TextStyle(
    fontSize: 22,
    fontFamily: AppFonts.arizonia,
    overflow: TextOverflow.ellipsis,
  );

  static const profileName = TextStyle(
      fontSize: 12,
      overflow: TextOverflow.ellipsis,
      fontFamily: AppFonts.nabla);
  static const tabBarSelectedLabelStyleLightMode = TextStyle(
    fontSize: 20,
  );
  static const tabBarSelectedLabelStyleDarkMode = TextStyle(
    fontSize: 20,
  );
  static const tabBarUnselectedLabelStyleLightMode =
      TextStyle(fontFamily: AppFonts.poppins, fontSize: 15);

  static const tabBarUnselectedLabelStyleDarkMode =
      TextStyle(fontFamily: AppFonts.poppins, fontSize: 15);

  static const onBoarding = TextStyle(
    fontSize: 35,
    fontFamily: AppFonts.poppins,
  );
}
