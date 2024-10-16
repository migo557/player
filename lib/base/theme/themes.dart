import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:open_player/base/assets/fonts/app-fonts.dart';

import '../../logic/theme_cubit/theme_state.dart';
import '../../data/models/theme-look-model.dart';

class AppThemes {
  //------ Select/Choose Theme -------------//
  themes(ThemeState themeState) {
    return themeState.defaultTheme
        ? themeState.isDarkMode
            ? _defaultDarkTheme(themeState: themeState)
            : _defaultLightTheme(themeState: themeState)
        : themeState.isDarkMode
            ? _flexDarkTheme(themeState: themeState)
            : _flexLightTheme(themeState: themeState);
  }

  //--- Default Light Theme ---//
  _defaultLightTheme({required ThemeState themeState}) {
    return ThemeData().copyWith(
      scaffoldBackgroundColor: Colors.white,
      visualDensity: themeState.visualDensity,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.pinkAccent,
        primary: Colors.pink,
        contrastLevel: themeState.contrastLevel,
      ),
      tabBarTheme: const TabBarTheme(
        unselectedLabelStyle: TextStyle(fontSize: 10),
        labelStyle: TextStyle(fontSize: 11, fontFamily: AppFonts.poppins),
      ),
    );
  }

  //--- Default Dark Theme ---//
  _defaultDarkTheme({required ThemeState themeState}) {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: themeState.isBlackMode ? Colors.black : null,
      appBarTheme: AppBarTheme(
        backgroundColor: themeState.isBlackMode ? Colors.black : null,
      ),
      visualDensity: themeState.visualDensity,
      colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.pinkAccent,
          primary: Colors.pink,
          brightness: Brightness.dark,
          contrastLevel: themeState.contrastLevel),
      tabBarTheme: const TabBarTheme(
        unselectedLabelStyle: TextStyle(fontSize: 10),
        labelStyle: TextStyle(fontSize: 11, fontFamily: AppFonts.poppins),
      ),
    );
  }

  //------- Flex Dark Theme---------//
  _flexDarkTheme({required ThemeState themeState}) {
    return FlexThemeData.dark(
      useMaterial3: themeState.useMaterial3,
      scheme: flexThemes[themeState.flexThemeListIndex].flexScheme,
      visualDensity: themeState.visualDensity,
      appBarBackground: themeState.isDefaultAppBarColor
          ? themeState.isBlackMode
              ? Colors.black
              : null
          : Color(themeState.customAppBarColor),
    ).copyWith(
      scaffoldBackgroundColor: themeState.isBlackMode
          ? Colors.black
          : themeState.isDefaultScaffoldColor
              ? null
              : Color(themeState.customScaffoldColor),
      tabBarTheme: const TabBarTheme(
        unselectedLabelStyle: TextStyle(fontSize: 10),
        labelStyle: TextStyle(fontSize: 11, fontFamily: AppFonts.poppins),
      ),
    );
  }

  //-------- Flex Light Theme -------------//
  _flexLightTheme({required ThemeState themeState}) {
    return FlexThemeData.light(
      useMaterial3: themeState.useMaterial3,
      scheme: flexThemes[themeState.flexThemeListIndex].flexScheme,
      visualDensity: themeState.visualDensity,
      scaffoldBackground: themeState.isDefaultScaffoldColor
          ? null
          : Color(themeState.customScaffoldColor),
      appBarBackground: themeState.isDefaultAppBarColor
          ? null
          : Color(themeState.customAppBarColor),
    ).copyWith(
      tabBarTheme: const TabBarTheme(
        unselectedLabelStyle: TextStyle(fontSize: 10),
        labelStyle: TextStyle(fontSize: 11, fontFamily: AppFonts.poppins),
      ),
    );
  }

  //---  Flex Themes ---//
  final List<ThemeLookModel> flexThemes = [
    ThemeLookModel(
      title: FlexScheme.amber.name,
      flexScheme: FlexScheme.amber,
      flexColor: FlexColor.amber,
    ),
    ThemeLookModel(
      title: FlexScheme.aquaBlue.name,
      flexScheme: FlexScheme.aquaBlue,
      flexColor: FlexColor.aquaBlue,
    ),
    ThemeLookModel(
      title: FlexScheme.bahamaBlue.name,
      flexScheme: FlexScheme.bahamaBlue,
      flexColor: FlexColor.bahamaBlue,
    ),
    ThemeLookModel(
      title: FlexScheme.barossa.name,
      flexScheme: FlexScheme.barossa,
      flexColor: FlexColor.barossa,
    ),
    ThemeLookModel(
      title: FlexScheme.bigStone.name,
      flexScheme: FlexScheme.bigStone,
      flexColor: FlexColor.bigStone,
    ),
    ThemeLookModel(
        title: FlexScheme.blue.name,
        flexScheme: FlexScheme.blue,
        flexColor: FlexColor.blue),
    ThemeLookModel(
        title: FlexScheme.blueM3.name,
        flexScheme: FlexScheme.blueM3,
        flexColor: FlexColor.blueM3),
    ThemeLookModel(
        title: FlexScheme.blueWhale.name,
        flexScheme: FlexScheme.blueWhale,
        flexColor: FlexColor.blueWhale),
    ThemeLookModel(
        title: FlexScheme.blumineBlue.name,
        flexScheme: FlexScheme.blumineBlue,
        flexColor: FlexColor.blumineBlue),
    ThemeLookModel(
        title: FlexScheme.brandBlue.name,
        flexScheme: FlexScheme.brandBlue,
        flexColor: FlexColor.brandBlue),
    ThemeLookModel(
        title: FlexScheme.cyanM3.name,
        flexScheme: FlexScheme.cyanM3,
        flexColor: FlexColor.cyanM3),
    ThemeLookModel(
        title: FlexScheme.damask.name,
        flexScheme: FlexScheme.damask,
        flexColor: FlexColor.damask),
    ThemeLookModel(
        title: FlexScheme.deepBlue.name,
        flexScheme: FlexScheme.deepBlue,
        flexColor: FlexColor.deepBlue),
    ThemeLookModel(
        title: FlexScheme.deepOrangeM3.name,
        flexScheme: FlexScheme.deepOrangeM3,
        flexColor: FlexColor.deepOrangeM3),
    ThemeLookModel(
        title: FlexScheme.deepPurple.name,
        flexScheme: FlexScheme.deepPurple,
        flexColor: FlexColor.deepPurple),
    ThemeLookModel(
        title: FlexScheme.dellGenoa.name,
        flexScheme: FlexScheme.dellGenoa,
        flexColor: FlexColor.dellGenoa),
    ThemeLookModel(
        title: FlexScheme.ebonyClay.name,
        flexScheme: FlexScheme.ebonyClay,
        flexColor: FlexColor.ebonyClay),
    ThemeLookModel(
        title: FlexScheme.espresso.name,
        flexScheme: FlexScheme.espresso,
        flexColor: FlexColor.espresso),
    ThemeLookModel(
        title: FlexScheme.flutterDash.name,
        flexScheme: FlexScheme.flutterDash,
        flexColor: FlexColor.flutterDash),
    ThemeLookModel(
        title: FlexScheme.gold.name,
        flexScheme: FlexScheme.gold,
        flexColor: FlexColor.gold),
    ThemeLookModel(
        title: FlexScheme.green.name,
        flexScheme: FlexScheme.green,
        flexColor: FlexColor.green),
    ThemeLookModel(
        title: FlexScheme.greenM3.name,
        flexScheme: FlexScheme.greenM3,
        flexColor: FlexColor.greenM3),
    ThemeLookModel(
        title: FlexScheme.greyLaw.name,
        flexScheme: FlexScheme.greyLaw,
        flexColor: FlexColor.greyLaw),
    ThemeLookModel(
        title: FlexScheme.hippieBlue.name,
        flexScheme: FlexScheme.hippieBlue,
        flexColor: FlexColor.hippieBlue),
    ThemeLookModel(
        title: FlexScheme.indigo.name,
        flexScheme: FlexScheme.indigo,
        flexColor: FlexColor.indigo),
    ThemeLookModel(
        title: FlexScheme.indigoM3.name,
        flexScheme: FlexScheme.indigoM3,
        flexColor: FlexColor.indigoM3),
    ThemeLookModel(
        title: FlexScheme.jungle.name,
        flexScheme: FlexScheme.jungle,
        flexColor: FlexColor.jungle),
    ThemeLookModel(
        title: FlexScheme.limeM3.name,
        flexScheme: FlexScheme.limeM3,
        flexColor: FlexColor.limeM3),
    ThemeLookModel(
        title: FlexScheme.mallardGreen.name,
        flexScheme: FlexScheme.mallardGreen,
        flexColor: FlexColor.mallardGreen),
    ThemeLookModel(
        title: FlexScheme.mandyRed.name,
        flexScheme: FlexScheme.mandyRed,
        flexColor: FlexColor.mandyRed),
    ThemeLookModel(
        title: FlexScheme.mango.name,
        flexScheme: FlexScheme.mango,
        flexColor: FlexColor.mango),
    ThemeLookModel(
        title: FlexScheme.material.name,
        flexScheme: FlexScheme.material,
        flexColor: FlexColor.material),
    ThemeLookModel(
        title: FlexScheme.materialBaseline.name,
        flexScheme: FlexScheme.materialBaseline,
        flexColor: FlexColor.materialBaseline),
    ThemeLookModel(
        title: FlexScheme.materialHc.name,
        flexScheme: FlexScheme.materialHc,
        flexColor: FlexColor.materialHc),
    ThemeLookModel(
        title: FlexScheme.money.name,
        flexScheme: FlexScheme.money,
        flexColor: FlexColor.money),
    ThemeLookModel(
        title: FlexScheme.orangeM3.name,
        flexScheme: FlexScheme.orangeM3,
        flexColor: FlexColor.orangeM3),
    ThemeLookModel(
        title: FlexScheme.outerSpace.name,
        flexScheme: FlexScheme.outerSpace,
        flexColor: FlexColor.outerSpace),
    ThemeLookModel(
        title: FlexScheme.pinkM3.name,
        flexScheme: FlexScheme.pinkM3,
        flexColor: FlexColor.pinkM3),
    ThemeLookModel(
        title: FlexScheme.purpleBrown.name,
        flexScheme: FlexScheme.purpleBrown,
        flexColor: FlexColor.purpleBrown),
    ThemeLookModel(
      title: FlexScheme.purpleM3.name,
      flexScheme: FlexScheme.purpleM3,
      flexColor: FlexColor.purpleM3,
    ),
    ThemeLookModel(
        title: FlexScheme.red.name,
        flexScheme: FlexScheme.red,
        flexColor: FlexColor.red),
    ThemeLookModel(
        title: FlexScheme.redM3.name,
        flexScheme: FlexScheme.redM3,
        flexColor: FlexColor.redM3),
    ThemeLookModel(
        title: FlexScheme.redWine.name,
        flexScheme: FlexScheme.redWine,
        flexColor: FlexColor.redWine),
    ThemeLookModel(
        title: FlexScheme.rosewood.name,
        flexScheme: FlexScheme.rosewood,
        flexColor: FlexColor.rosewood),
    ThemeLookModel(
        title: FlexScheme.sakura.name,
        flexScheme: FlexScheme.sakura,
        flexColor: FlexColor.sakura),
    ThemeLookModel(
        title: FlexScheme.sanJuanBlue.name,
        flexScheme: FlexScheme.sanJuanBlue,
        flexColor: FlexColor.sanJuanBlue),
    ThemeLookModel(
        title: FlexScheme.shark.name,
        flexScheme: FlexScheme.shark,
        flexColor: FlexColor.shark),
    ThemeLookModel(
        title: FlexScheme.tealM3.name,
        flexScheme: FlexScheme.tealM3,
        flexColor: FlexColor.tealM3),
    ThemeLookModel(
        title: FlexScheme.verdunHemlock.name,
        flexScheme: FlexScheme.verdunHemlock,
        flexColor: FlexColor.verdunHemlock),
    ThemeLookModel(
        title: FlexScheme.vesuviusBurn.name,
        flexScheme: FlexScheme.vesuviusBurn,
        flexColor: FlexColor.vesuviusBurn),
    ThemeLookModel(
        title: FlexScheme.wasabi.name,
        flexScheme: FlexScheme.wasabi,
        flexColor: FlexColor.wasabi),
    ThemeLookModel(
        title: FlexScheme.yellowM3.name,
        flexScheme: FlexScheme.yellowM3,
        flexColor: FlexColor.yellowM3),
  ];
}
