import 'package:flutter/material.dart';
import 'package:open_player/base/assets/fonts/app_fonts.dart';

class AppTextStyles {
  static const greeting1 =
      TextStyle(fontSize: 23, fontFamily: AppFonts.poppins);
  static const profileName1 = TextStyle(
    fontSize: 16,
    overflow: TextOverflow.ellipsis,
  );
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
}
