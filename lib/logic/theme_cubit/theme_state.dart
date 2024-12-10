import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../base/db/hive_service.dart';

class ThemeState extends Equatable {
 final bool isDarkMode;
final  bool isBlackMode;
final  bool defaultTheme;
 final bool useMaterial3;
final  bool isDefaultScaffoldColor;
 final bool isDefaultAppBarColor;
 final bool isDefaultBottomNavBarBgColor;
 final bool isDefaultBottomNavBarPosition;
 final bool isDefaultBottomNavBarRotation;
 final bool isDefaultBottomNavBarIconRotation;

 final double contrastLevel;
 final VisualDensity visualDensity;
 final int? customScaffoldColor;
 final int? customAppBarColor;
 final int? customBottomNavBarBgColor;
 final int primaryColorListIndex;
 final int primaryColor;
 final double bottomNavBarPositionFromLeft;
 final double bottomNavBarPositionFromBottom;
  final double bottomNavBarWidth;
  final double bottomNavBarHeight;
 final  double bottomNavBarRotation;
 final double bottomNavBarIconRotation;

 final bool isHoldBottomNavBarCirclePositionButton;

  const ThemeState({
    required this.isBlackMode,
    required this.isDarkMode,
    required this.useMaterial3,
    required this.primaryColorListIndex,
    required this.primaryColor,
    required this.defaultTheme,
    required this.contrastLevel,
    required this.visualDensity,
    required this.customScaffoldColor,
    required this.bottomNavBarRotation,
    required this.bottomNavBarIconRotation,
    required this.isDefaultBottomNavBarRotation,
    required this.isDefaultBottomNavBarIconRotation,
    required this.isDefaultScaffoldColor,
    required this.isDefaultAppBarColor,
    required this.isDefaultBottomNavBarBgColor,
    required this.isDefaultBottomNavBarPosition,
    required this.customAppBarColor,
    required this.customBottomNavBarBgColor,
    required this.bottomNavBarPositionFromBottom,
    required this.bottomNavBarPositionFromLeft,
    required this.bottomNavBarHeight,
    required this.bottomNavBarWidth,
    required this.isHoldBottomNavBarCirclePositionButton,
  });

  static get themeBox => MyHiveBoxes.theme;
  factory ThemeState.initial() => ThemeState(
        defaultTheme: themeBox.get(MyHiveKeys.defaultTheme) ?? true,
        primaryColor: themeBox.get(MyHiveKeys.primaryColor) ?? 0xFFF43F5E, // Rose,
        useMaterial3: themeBox.get(MyHiveKeys.useMaterial3) ?? true,
        isBlackMode: themeBox.get(MyHiveKeys.isBlackMode) ?? false,
        isDarkMode: themeBox.get(MyHiveKeys.isDarkMode) ?? false,
        primaryColorListIndex:
            themeBox.get(MyHiveKeys.primaryColorListIndex) ?? 0,
        contrastLevel: themeBox.get(MyHiveKeys.contrastLevel) ?? 0.5,
        visualDensity: VisualDensity.comfortable,
        isDefaultScaffoldColor:
            themeBox.get(MyHiveKeys.isDefaultScaffoldColor) ?? true,
        isDefaultAppBarColor:
            themeBox.get(MyHiveKeys.isDefaultAppBarColor) ?? true,
        isDefaultBottomNavBarBgColor:
            themeBox.get(MyHiveKeys.isDefaultBottomNavBarBgColor) ?? true,
        customScaffoldColor: themeBox.get(MyHiveKeys.customScaffoldColor),
        customAppBarColor: themeBox.get(MyHiveKeys.customAppBarColor),
        customBottomNavBarBgColor:
            themeBox.get(MyHiveKeys.customBottomNavBarBgColor),
        bottomNavBarPositionFromBottom:
            themeBox.get(MyHiveKeys.bottomNavBarPositionFromBottom) ?? 0.05,
        bottomNavBarPositionFromLeft:
            themeBox.get(MyHiveKeys.bottomNavBarPositionFromLeft) ?? 0.1,
        isDefaultBottomNavBarPosition:
            themeBox.get(MyHiveKeys.isDefaultBottomNavBarPosition) ?? true,
        bottomNavBarHeight: themeBox.get(MyHiveKeys.bottomNavBarHeight) ?? 0.05,
        bottomNavBarWidth: themeBox.get(MyHiveKeys.bottomNavBarWidth) ?? 0.8,
        isHoldBottomNavBarCirclePositionButton:
            themeBox.get(MyHiveKeys.isHoldBottomNavBarCirclePositionButton) ??
                false,
        bottomNavBarRotation:
            themeBox.get(MyHiveKeys.bottomNavBarRotation) ?? 0,
        bottomNavBarIconRotation:
            themeBox.get(MyHiveKeys.bottomNavBarIconRotation) ?? 0,
        isDefaultBottomNavBarRotation:
            themeBox.get(MyHiveKeys.isDefaultBottomNavBarRotation) ?? true,
        isDefaultBottomNavBarIconRotation:
            themeBox.get(MyHiveKeys.isDefaultBottomNavBarIconRotation) ?? true,
      );

  ThemeState copyWith({
    bool? isDarkMode,
    bool? isBlackMode,
    int? primaryColorListIndex,
    bool? defaultTheme,
    bool? useMaterial3,
    double? contrastLevel,
    VisualDensity? visualDensity,
    int? customScaffoldColor,
    int? customAppBarColor,
    int? customBottomNavBarBgColor,
    bool? isDefaultScaffoldColor,
    bool? isDefaultAppBarColor,
    bool? isDefaultBottomNavBarBgColor,
    bool? isDefaultBottomNavBarPosition,
    bool? isDefaultBottomNavBarRotation,
    bool? isDefaultBottomNavBarIconRotation,
    double? bottomNavBarPositionFromLeft,
    double? bottomNavBarPositionFromBottom,
    double? bottomNavBarHeight,
    double? bottomNavBarWidth,
    bool? isHoldBottomNavBarCirclePositionButton,
    int? primaryColor,
    double? bottomNavBarRotation,
    double? bottomNavBarIconRotation,
  }) {
    return ThemeState(
      primaryColor: primaryColor ?? this.primaryColor,
      useMaterial3: useMaterial3 ?? this.useMaterial3,
      defaultTheme: defaultTheme ?? this.defaultTheme,
      isBlackMode: isBlackMode ?? this.isBlackMode,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      primaryColorListIndex:
          primaryColorListIndex ?? this.primaryColorListIndex,
      contrastLevel: contrastLevel ?? this.contrastLevel,
      visualDensity: visualDensity ?? this.visualDensity,
      customScaffoldColor: customScaffoldColor ?? this.customScaffoldColor,
      isDefaultScaffoldColor:
          isDefaultScaffoldColor ?? this.isDefaultScaffoldColor,
      isDefaultBottomNavBarRotation:
          isDefaultBottomNavBarRotation ?? this.isDefaultBottomNavBarRotation,
      isDefaultBottomNavBarIconRotation: isDefaultBottomNavBarIconRotation ??
          this.isDefaultBottomNavBarIconRotation,
      customAppBarColor: customAppBarColor ?? this.customAppBarColor,
      isDefaultAppBarColor: isDefaultAppBarColor ?? this.isDefaultAppBarColor,
      isDefaultBottomNavBarBgColor:
          isDefaultBottomNavBarBgColor ?? this.isDefaultBottomNavBarBgColor,
      customBottomNavBarBgColor:
          customBottomNavBarBgColor ?? this.customBottomNavBarBgColor,
      bottomNavBarPositionFromBottom:
          bottomNavBarPositionFromBottom ?? this.bottomNavBarPositionFromBottom,
      bottomNavBarPositionFromLeft:
          bottomNavBarPositionFromLeft ?? this.bottomNavBarPositionFromLeft,
      isDefaultBottomNavBarPosition:
          isDefaultBottomNavBarPosition ?? this.isDefaultBottomNavBarPosition,
      bottomNavBarRotation: bottomNavBarRotation ?? this.bottomNavBarRotation,
      bottomNavBarIconRotation:
          bottomNavBarIconRotation ?? this.bottomNavBarIconRotation,
      bottomNavBarHeight: bottomNavBarHeight ?? this.bottomNavBarHeight,
      bottomNavBarWidth: bottomNavBarWidth ?? this.bottomNavBarWidth,
      isHoldBottomNavBarCirclePositionButton:
          isHoldBottomNavBarCirclePositionButton ??
              this.isHoldBottomNavBarCirclePositionButton,
    );
  }

  @override
  List<Object?> get props => [
        primaryColor,
        isBlackMode,
        isDarkMode,
        useMaterial3,
        primaryColorListIndex,
        defaultTheme,
        contrastLevel,
        visualDensity,
        customScaffoldColor,
        isDefaultScaffoldColor,
        customAppBarColor,
        isDefaultAppBarColor,
        customBottomNavBarBgColor,
        isDefaultBottomNavBarBgColor,
        bottomNavBarPositionFromBottom,
        bottomNavBarPositionFromLeft,
        isDefaultBottomNavBarPosition,
        isDefaultBottomNavBarRotation,
        isDefaultBottomNavBarIconRotation,
        bottomNavBarHeight,
        bottomNavBarWidth,
        isHoldBottomNavBarCirclePositionButton,
        bottomNavBarRotation,
        bottomNavBarIconRotation,
      ];
}
