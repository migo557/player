import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:open_player/base/db/hive/hive.dart';
import 'package:open_player/base/theme/colors_palates.dart';
import 'package:open_player/logic/theme_cubit/theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(loadInitialThemeState());

  // Load initial theme state from from Hive
  static ThemeState loadInitialThemeState() {
    final themeBox = MyHiveBoxes.themeBox;
    return ThemeState(
      defaultTheme: themeBox.get(MyHiveKeys.defaultTheme) ?? true,
      useMaterial3: themeBox.get(MyHiveKeys.useMaterial3) ?? true,
      isBlackMode: themeBox.get(MyHiveKeys.isBlackMode) ?? false,
      isDarkMode: themeBox.get(MyHiveKeys.isDarkMode) ?? false,
      flexThemeListIndex: themeBox.get(MyHiveKeys.flexThemeListIndex) ?? 0,
      contrastLevel: themeBox.get(MyHiveKeys.contrastLevel) ?? 0.5,
      visualDensity: VisualDensity.comfortable,
      isDefaultScaffoldColor:
          themeBox.get(MyHiveKeys.isDefaultScaffoldColor) ?? true,
      isDefaultAppBarColor:
          themeBox.get(MyHiveKeys.isDefaultAppBarColor) ?? true,
      isDefaultBottomNavBarBgColor:
          themeBox.get(MyHiveKeys.isDefaultBottomNavBarBgColor) ?? true,
      customScaffoldColor: themeBox.get(MyHiveKeys.customScaffoldColor) ??
          AppColors.colorHexCodesList[0],
      customAppBarColor: themeBox.get(MyHiveKeys.customAppBarColor) ??
          AppColors.colorHexCodesList[0],
      customBottomNavBarBgColor:
          themeBox.get(MyHiveKeys.customBottomNavBarBgColor) ??
              AppColors.colorHexCodesList[0],
      bottomNavBarPositionFromBottom:
          themeBox.get(MyHiveKeys.bottomNavBarPositionFromBottom) ?? 0.05,
      bottomNavBarPositionFromLeft:
          themeBox.get(MyHiveKeys.bottomNavBarPositionFromLeft) ?? 0.1,
      isDefaultBottomNavBarPosition:
          themeBox.get(MyHiveKeys.isDefaultBottomNavBarPosition) ?? true,
      bottomNavBarHeight: themeBox.get(MyHiveKeys.bottomNavBarHeight) ?? 0.045,
      bottomNavBarWidth: themeBox.get(MyHiveKeys.bottomNavBarWidth) ?? 0.8,
      isHoldBottomNavBarCirclePositionButton:
          themeBox.get(MyHiveKeys.isHoldBottomNavBarCirclePositionButton) ??
              false,
    );
  }

  // Toggle theme mode (dark/light)
  void toggleThemeMode() {
    bool themeMode = !state.isDarkMode;
    // Emit new state with toggled theme mode
    emit(state.copyWith(isDarkMode: !state.isDarkMode, isBlackMode: false));
    // Update in Hive
    MyHiveBoxes.themeBox.put(MyHiveKeys.isDarkMode, themeMode);
    MyHiveBoxes.themeBox.put(MyHiveKeys.isBlackMode, false);
  }

  changeFlexIndex(int index) {
    emit(state.copyWith(flexThemeListIndex: index));
  }

  toggleDefaultTheme() {
    bool isDefault = !state.defaultTheme;
    emit(state.copyWith(
      defaultTheme: isDefault,
    ));

    // Update Theme in Hive
    MyHiveBoxes.themeBox.put(MyHiveKeys.defaultTheme, isDefault);
  }

  disableDefaultTheme() {
    emit(state.copyWith(defaultTheme: false));
    // Update in Hive
    MyHiveBoxes.themeBox.put(MyHiveKeys.defaultTheme, false);
  }

  toggleBlackMode() {
    bool isBlackMode =  !state.isBlackMode;
    emit(state.copyWith(isBlackMode: isBlackMode));
    // Update in Hive
    MyHiveBoxes.themeBox.put(MyHiveKeys.isBlackMode, isBlackMode);
  }

  disableBlackMode() {
    emit(state.copyWith(isBlackMode: false));
    // Update in Hive
    MyHiveBoxes.themeBox.put(MyHiveKeys.isBlackMode, false);
  }

  toggleMaterial3() {
    emit(
      state.copyWith(useMaterial3: state.useMaterial3),
    );
    // Update in Hive
    MyHiveBoxes.themeBox.put(MyHiveKeys.useMaterial3, state.useMaterial3);
  }

  changeContrastLevel(double contrast) {
    emit(state.copyWith(contrastLevel: contrast));

    // Update in Hive
    MyHiveBoxes.themeBox.put(MyHiveKeys.contrastLevel, contrast);
  }

  changeVisualDensity(VisualDensity visualDensity) {
    emit(state.copyWith(visualDensity: visualDensity));
  }

  changeScaffoldBgColor(int colorCode) {
    emit(state.copyWith(
        customScaffoldColor: colorCode, isDefaultScaffoldColor: false));

    // Update in Hive
    MyHiveBoxes.themeBox.put(MyHiveKeys.customScaffoldColor, colorCode);
    // Update in Hive
    MyHiveBoxes.themeBox.put(MyHiveKeys.isDefaultScaffoldColor, false);
  }

  changeAppBarColor(int colorCode) {
    emit(state.copyWith(
        customAppBarColor: colorCode, isDefaultAppBarColor: false));

    // Update in Hive
    MyHiveBoxes.themeBox.put(MyHiveKeys.customAppBarColor, colorCode);
    // Update in Hive
    MyHiveBoxes.themeBox.put(MyHiveKeys.isDefaultAppBarColor, false);
  }

  changeBottomNavBarBgColor(int colorCode) {
    emit(
      state.copyWith(
          customBottomNavBarBgColor: colorCode,
          isDefaultBottomNavBarBgColor: false),
    );

    // Update in Hive
    MyHiveBoxes.themeBox.put(MyHiveKeys.customBottomNavBarBgColor, colorCode);
    // Update in Hive
    MyHiveBoxes.themeBox.put(MyHiveKeys.isDefaultBottomNavBarBgColor, false);
  }

  resetToDefaultScaffoldColor() {
    emit(state.copyWith(isDefaultScaffoldColor: true));
    // Update in Hive
    MyHiveBoxes.themeBox.put(MyHiveKeys.isDefaultScaffoldColor, true);
  }

  resetToDefaultAppBarColor() {
    emit(state.copyWith(isDefaultAppBarColor: true));
    // Update in Hive
    MyHiveBoxes.themeBox.put(MyHiveKeys.isDefaultAppBarColor, true);
  }

  resetToDefaultBottomNavBarBgColor() {
    emit(state.copyWith(isDefaultBottomNavBarBgColor: true));
    // Update in Hive
    MyHiveBoxes.themeBox.put(MyHiveKeys.isDefaultBottomNavBarBgColor, true);
  }

  resetToDefaultBottomNavBarPosition() {
    emit(state.copyWith(
      isDefaultBottomNavBarPosition: true,
      bottomNavBarPositionFromBottom: 0.05,
      bottomNavBarPositionFromLeft: 0.1,
    ));

    // Update in Hive
    MyHiveBoxes.themeBox.put(MyHiveKeys.isDefaultBottomNavBarPosition, true);
    MyHiveBoxes.themeBox.put(MyHiveKeys.bottomNavBarPositionFromBottom, 0.05);
    MyHiveBoxes.themeBox.put(MyHiveKeys.bottomNavBarPositionFromLeft, 0.1);
  }

  resetToDefaultBottomNavBarHeightAndWidth() {
    emit(state.copyWith(
      bottomNavBarHeight: 0.045,
      bottomNavBarWidth: 0.08,
    ));
    // Update in Hive
    MyHiveBoxes.themeBox.put(MyHiveKeys.bottomNavBarHeight, 0.045);
    MyHiveBoxes.themeBox.put(MyHiveKeys.bottomNavBarWidth, 0.08);
  }

  changeBottomNavBarPositionTop() {
    double? bottomNavBarPositionFromBottom =
        state.bottomNavBarPositionFromBottom <= 0.95
            ? state.bottomNavBarPositionFromBottom + 0.01
            : 0;
    emit(
      state.copyWith(
          isDefaultBottomNavBarPosition: false,
          bottomNavBarPositionFromBottom: bottomNavBarPositionFromBottom),
    );

    // Update in Hive
    MyHiveBoxes.themeBox.put(MyHiveKeys.isDefaultBottomNavBarPosition, false);
    MyHiveBoxes.themeBox.put(MyHiveKeys.bottomNavBarPositionFromBottom,
        bottomNavBarPositionFromBottom);
  }

  changeBottomNavBarPositionLeft() {
    double? bottomNavBarPositionFromLeft =
        state.bottomNavBarPositionFromLeft >= 0.01
            ? state.bottomNavBarPositionFromLeft - 0.01
            : 0;
    emit(
      state.copyWith(
          isDefaultBottomNavBarPosition: false,
          bottomNavBarPositionFromLeft: bottomNavBarPositionFromLeft),
    );
    // Update in Hive
    MyHiveBoxes.themeBox.put(MyHiveKeys.isDefaultBottomNavBarPosition, false);
    MyHiveBoxes.themeBox.put(
        MyHiveKeys.bottomNavBarPositionFromLeft, bottomNavBarPositionFromLeft);
  }

  changeBottomNavBarPositionRight() {
    double? bottomNavBarPositionFromLeft =
        state.bottomNavBarPositionFromLeft <= 0.95
            ? state.bottomNavBarPositionFromLeft + 0.01
            : 0;
    emit(state.copyWith(
      isDefaultBottomNavBarPosition: false,
      bottomNavBarPositionFromLeft: bottomNavBarPositionFromLeft,
    ));

    // Update in Hive
    MyHiveBoxes.themeBox.put(MyHiveKeys.isDefaultBottomNavBarPosition, false);
    MyHiveBoxes.themeBox.put(
        MyHiveKeys.bottomNavBarPositionFromLeft, bottomNavBarPositionFromLeft);
  }

  changeBottomNavBarPositionBottom() {
    double? bottomNavBarPositionFromBottom =
        state.bottomNavBarPositionFromBottom >= 0.01
            ? state.bottomNavBarPositionFromBottom - 0.01
            : 0;
    emit(
      state.copyWith(
          isDefaultBottomNavBarPosition: false,
          bottomNavBarPositionFromBottom: bottomNavBarPositionFromBottom),
    );
    // Update in Hive
    MyHiveBoxes.themeBox.put(MyHiveKeys.isDefaultBottomNavBarPosition, false);
    MyHiveBoxes.themeBox.put(MyHiveKeys.bottomNavBarPositionFromBottom,
        bottomNavBarPositionFromBottom);
  }

  increaseBottomNavBarWidth() {
    final double width = state.bottomNavBarWidth;
    final double updatedWidth =
        width < 1.0 ? state.bottomNavBarWidth + 0.03 : state.bottomNavBarWidth;
    emit(state.copyWith(bottomNavBarWidth: updatedWidth));

    // Update in Hive
    MyHiveBoxes.themeBox.put(MyHiveKeys.bottomNavBarWidth, updatedWidth);
  }

  decreaseBottomNavBarWidth() {
    final double width = state.bottomNavBarWidth;
    final double updatedWidth =
        width >= 0.1 ? state.bottomNavBarWidth - 0.03 : state.bottomNavBarWidth;
    emit(state.copyWith(bottomNavBarWidth: updatedWidth));

    // Update in Hive
    MyHiveBoxes.themeBox.put(MyHiveKeys.bottomNavBarWidth, updatedWidth);
  }

  increaseBottomNavBarHeight() {
    final double height = state.bottomNavBarHeight;
    double updatedHeight = height <= 0.2
        ? state.bottomNavBarHeight + 0.03
        : state.bottomNavBarHeight;
    emit(state.copyWith(bottomNavBarHeight: updatedHeight));
    // Update in Hive
    MyHiveBoxes.themeBox.put(MyHiveKeys.bottomNavBarHeight, updatedHeight);
  }

  decreaseBottomNavBarHeight() {
    final double height = state.bottomNavBarHeight;
    final double updatedHeight = height > 0.04
        ? state.bottomNavBarHeight - 0.03
        : state.bottomNavBarHeight;
    emit(state.copyWith(bottomNavBarHeight: updatedHeight));
    // Update in Hive
    MyHiveBoxes.themeBox.put(MyHiveKeys.bottomNavBarHeight, updatedHeight);
  }

  enableHoldBottomNavBarCirclePositionButton() {
    bool? isEnabled = state.isHoldBottomNavBarCirclePositionButton;
    if (isEnabled == false) {
      emit(state.copyWith(isHoldBottomNavBarCirclePositionButton: true));
    }
  }

  disableHoldBottomNavBarCirclePositionButton() {
    bool isEnabled = state.isHoldBottomNavBarCirclePositionButton;
    if (isEnabled) {
      emit(state.copyWith(isHoldBottomNavBarCirclePositionButton: false));
    }
  }

  restoreDefaultSetting() {
    emit(
      state.copyWith(
        isDefaultAppBarColor: true,
        isDefaultBottomNavBarBgColor: true,
        isDefaultScaffoldColor: true,
        contrastLevel: 0.9,
        defaultTheme: true,
        useMaterial3: true,
        bottomNavBarPositionFromBottom: 0.05,
        bottomNavBarPositionFromLeft: 0.1,
        bottomNavBarHeight: 0.045,
        bottomNavBarWidth: 0.8,
      ),
    );

    // Updates in Hive
    MyHiveBoxes.themeBox.put(MyHiveKeys.isDefaultAppBarColor, true);
    MyHiveBoxes.themeBox.put(MyHiveKeys.isDefaultBottomNavBarBgColor, true);
    MyHiveBoxes.themeBox.put(MyHiveKeys.isDefaultScaffoldColor, true);
    MyHiveBoxes.themeBox.put(MyHiveKeys.contrastLevel, 0.9);
    MyHiveBoxes.themeBox.put(MyHiveKeys.defaultTheme, true);
    MyHiveBoxes.themeBox.put(MyHiveKeys.useMaterial3, true);
    MyHiveBoxes.themeBox.put(MyHiveKeys.bottomNavBarPositionFromBottom, 0.05);
    MyHiveBoxes.themeBox.put(MyHiveKeys.bottomNavBarPositionFromLeft, 0.1);
    MyHiveBoxes.themeBox.put(MyHiveKeys.bottomNavBarHeight, 0.045);
    MyHiveBoxes.themeBox.put(MyHiveKeys.bottomNavBarWidth, 0.8);
  }
}
