import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ThemeState extends Equatable {
  bool isDarkMode;
  bool isBlackMode;
  bool defaultTheme;
  bool useMaterial3;
  bool isDefaultScaffoldColor;
  bool isDefaultAppBarColor;
  bool isDefaultBottomNavBarBgColor;
  bool isDefaultBottomNavBarPosition;
  double contrastLevel;
  VisualDensity visualDensity;
  int customScaffoldColor;
  int customAppBarColor;
  int customBottomNavBarBgColor;
  int flexThemeListIndex;
  double bottomNavBarPositionFromLeft;
  double bottomNavBarPositionFromBottom;
  double bottomNavBarWidth;
  double bottomNavBarHeight;
  bool isHoldBottomNavBarCirclePositionButton;

  ThemeState({
    required this.isBlackMode,
    required this.isDarkMode,
    required this.useMaterial3,
    required this.flexThemeListIndex,
    required this.defaultTheme,
    required this.contrastLevel,
    required this.visualDensity,
    required this.customScaffoldColor,
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

  ThemeState copyWith({
    bool? isDarkMode,
    bool? isBlackMode,
    int? flexThemeListIndex,
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
    double? bottomNavBarPositionFromLeft,
    double? bottomNavBarPositionFromBottom,
    double? bottomNavBarHeight,
    double? bottomNavBarWidth,
    bool? isHoldBottomNavBarCirclePositionButton,
  }) {
    return ThemeState(
      useMaterial3: useMaterial3 ?? this.useMaterial3,
      defaultTheme: defaultTheme ?? this.defaultTheme,
      isBlackMode: isBlackMode ?? this.isBlackMode,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      flexThemeListIndex: flexThemeListIndex??this.flexThemeListIndex,
      contrastLevel: contrastLevel ?? this.contrastLevel,
      visualDensity: visualDensity ?? this.visualDensity,
      customScaffoldColor: customScaffoldColor ?? this.customScaffoldColor,
      isDefaultScaffoldColor:
          isDefaultScaffoldColor ?? this.isDefaultScaffoldColor,
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
      bottomNavBarHeight: bottomNavBarHeight ?? this.bottomNavBarHeight,
      bottomNavBarWidth: bottomNavBarWidth ?? this.bottomNavBarWidth,
      isHoldBottomNavBarCirclePositionButton:
          isHoldBottomNavBarCirclePositionButton ??
              this.isHoldBottomNavBarCirclePositionButton,
    );
  }

 @override
  List<Object?> get props => [
        isBlackMode,
        isDarkMode,
        useMaterial3,
        flexThemeListIndex,
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
        bottomNavBarHeight,
        bottomNavBarWidth,
        isHoldBottomNavBarCirclePositionButton,
      ];
}
