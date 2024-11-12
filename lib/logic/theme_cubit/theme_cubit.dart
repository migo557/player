import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:open_player/base/db/hive_service.dart';
import 'package:open_player/logic/theme_cubit/theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState.initial());

  // Toggle theme mode (dark/light)
  void toggleThemeMode() {
    bool themeMode = !state.isDarkMode;
    // Emit new state with toggled theme mode
    emit(state.copyWith(isDarkMode: !state.isDarkMode, isBlackMode: false));
    // Update in Hive
    MyHiveBoxes.theme.put(MyHiveKeys.isDarkMode, themeMode);
    MyHiveBoxes.theme.put(MyHiveKeys.isBlackMode, false);
  }

  changeprimaryColor(int color) {
    emit(state.copyWith(primaryColor: color));

    MyHiveBoxes.theme.put(MyHiveKeys.primaryColor, color);
  }

  changeprimaryColorListIndex(int index) {
    emit(state.copyWith(primaryColorListIndex: index));

    MyHiveBoxes.theme.put(MyHiveKeys.primaryColorListIndex, index);
  }

  toggleDefaultTheme() {
    bool isDefault = !state.defaultTheme;
    emit(state.copyWith(
      defaultTheme: isDefault,
    ));
    // Update Theme in Hive
    MyHiveBoxes.theme.put(MyHiveKeys.defaultTheme, isDefault);
  }

  disableDefaultTheme() {
    emit(state.copyWith(defaultTheme: false));
    // Update in Hive
    MyHiveBoxes.theme.put(MyHiveKeys.defaultTheme, false);
  }

  toggleBlackMode() {
    bool isBlackMode = !state.isBlackMode;
    emit(state.copyWith(isBlackMode: isBlackMode));
    // Update in Hive
    MyHiveBoxes.theme.put(MyHiveKeys.isBlackMode, isBlackMode);
  }

  disableBlackMode() {
    emit(state.copyWith(isBlackMode: false));
    // Update in Hive
    MyHiveBoxes.theme.put(MyHiveKeys.isBlackMode, false);
  }

  toggleMaterial3() {
    bool isMaterial3 = !state.useMaterial3;
    emit(
      state.copyWith(useMaterial3: isMaterial3),
    );
    // Update in Hive
    MyHiveBoxes.theme.put(MyHiveKeys.useMaterial3, isMaterial3);
  }

  changeContrastLevel(double contrast) {
    emit(state.copyWith(contrastLevel: contrast));

    // Update in Hive
    MyHiveBoxes.theme.put(MyHiveKeys.contrastLevel, contrast);
  }

  changeVisualDensity(VisualDensity visualDensity) {
    emit(state.copyWith(visualDensity: visualDensity));
  }

  changeScaffoldBgColor(int colorCode) async {
    emit(state.copyWith(
        customScaffoldColor: colorCode, isDefaultScaffoldColor: false));

    // Update in Hive
    await MyHiveBoxes.theme.put(MyHiveKeys.customScaffoldColor, colorCode);
    // Update in Hive
    await MyHiveBoxes.theme.put(MyHiveKeys.isDefaultScaffoldColor, false);
  }

  changeAppBarColor(int colorCode) {
    emit(state.copyWith(
        customAppBarColor: colorCode, isDefaultAppBarColor: false));

    // Update in Hive
    MyHiveBoxes.theme.put(MyHiveKeys.customAppBarColor, colorCode);
    // Update in Hive
    MyHiveBoxes.theme.put(MyHiveKeys.isDefaultAppBarColor, false);
  }

  changeBottomNavBarBgColor(int colorCode) {
    emit(
      state.copyWith(
          customBottomNavBarBgColor: colorCode,
          isDefaultBottomNavBarBgColor: false),
    );

    // Update in Hive
    MyHiveBoxes.theme.put(MyHiveKeys.customBottomNavBarBgColor, colorCode);
    // Update in Hive
    MyHiveBoxes.theme.put(MyHiveKeys.isDefaultBottomNavBarBgColor, false);
  }

  resetToDefaultScaffoldColor() {
    emit(state.copyWith(isDefaultScaffoldColor: true));
    // Update in Hive
    MyHiveBoxes.theme.put(MyHiveKeys.isDefaultScaffoldColor, true);
  }

  resetToDefaultAppBarColor() {
    emit(state.copyWith(isDefaultAppBarColor: true));
    // Update in Hive
    MyHiveBoxes.theme.put(MyHiveKeys.isDefaultAppBarColor, true);
  }

  resetToDefaultBottomNavBarBgColor() {
    emit(state.copyWith(isDefaultBottomNavBarBgColor: true));
    // Update in Hive
    MyHiveBoxes.theme.put(MyHiveKeys.isDefaultBottomNavBarBgColor, true);
  }

  resetToDefaultBottomNavBarPosition() {
    emit(state.copyWith(
      isDefaultBottomNavBarPosition: true,
      bottomNavBarPositionFromBottom: 0.05,
      bottomNavBarPositionFromLeft: 0.1,
    ));

    // Update in Hive
    MyHiveBoxes.theme.put(MyHiveKeys.isDefaultBottomNavBarPosition, true);
    MyHiveBoxes.theme.put(MyHiveKeys.bottomNavBarPositionFromBottom, 0.05);
    MyHiveBoxes.theme.put(MyHiveKeys.bottomNavBarPositionFromLeft, 0.1);
  }

  resetToDefaultBottomNavBarHeightAndWidth() {
    emit(state.copyWith(
      bottomNavBarHeight: 0.045,
      bottomNavBarWidth: 0.08,
    ));
    // Update in Hive
    MyHiveBoxes.theme.put(MyHiveKeys.bottomNavBarHeight, 0.045);
    MyHiveBoxes.theme.put(MyHiveKeys.bottomNavBarWidth, 0.08);
  }

  resetToDefaultBottomNavBarRotation() {
    emit(state.copyWith(
      bottomNavBarRotation: 0,
      bottomNavBarIconRotation: 0,
      isDefaultBottomNavBarIconRotation: true,
      isDefaultBottomNavBarRotation: true,
    ));
    // Update in Hive
    MyHiveBoxes.theme.put(MyHiveKeys.bottomNavBarRotation, null);
    MyHiveBoxes.theme.put(MyHiveKeys.bottomNavBarIconRotation, null);

    MyHiveBoxes.theme.put(MyHiveKeys.isDefaultBottomNavBarRotation, true);
    MyHiveBoxes.theme.put(MyHiveKeys.isDefaultBottomNavBarIconRotation, true);
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
    MyHiveBoxes.theme.put(MyHiveKeys.isDefaultBottomNavBarPosition, false);
    MyHiveBoxes.theme.put(MyHiveKeys.bottomNavBarPositionFromBottom,
        bottomNavBarPositionFromBottom);
  }

  changeBottomNavBarPositionLeft() {
    double? bottomNavBarPositionFromLeft =
        state.bottomNavBarPositionFromLeft - 0.01;
    emit(
      state.copyWith(
          isDefaultBottomNavBarPosition: false,
          bottomNavBarPositionFromLeft: bottomNavBarPositionFromLeft),
    );
    // Update in Hive
    MyHiveBoxes.theme.put(MyHiveKeys.isDefaultBottomNavBarPosition, false);
    MyHiveBoxes.theme.put(
        MyHiveKeys.bottomNavBarPositionFromLeft, bottomNavBarPositionFromLeft);
  }

  changeBottomNavBarPositionRight() {
    double? bottomNavBarPositionFromLeft =
        state.bottomNavBarPositionFromLeft + 0.01;
    emit(state.copyWith(
      isDefaultBottomNavBarPosition: false,
      bottomNavBarPositionFromLeft: bottomNavBarPositionFromLeft,
    ));

    // Update in Hive
    MyHiveBoxes.theme.put(MyHiveKeys.isDefaultBottomNavBarPosition, false);
    MyHiveBoxes.theme.put(
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
    MyHiveBoxes.theme.put(MyHiveKeys.isDefaultBottomNavBarPosition, false);
    MyHiveBoxes.theme.put(MyHiveKeys.bottomNavBarPositionFromBottom,
        bottomNavBarPositionFromBottom);
  }

  increaseBottomNavBarWidth() {
    final double width = state.bottomNavBarWidth;
    final double updatedWidth =
        width < 2.0 ? state.bottomNavBarWidth + 0.03 : state.bottomNavBarWidth;
    emit(state.copyWith(bottomNavBarWidth: updatedWidth));

    // Update in Hive
    MyHiveBoxes.theme.put(MyHiveKeys.bottomNavBarWidth, updatedWidth);
  }

// Update Rotation
  updateBottomNavigationBarRotationToRight() {
    double newValueOfNav = state.bottomNavBarRotation + 0.01;
    double newValueofNavIcon = state.bottomNavBarIconRotation - 0.01;

    emit(state.copyWith(
        bottomNavBarRotation: newValueOfNav,
        bottomNavBarIconRotation: newValueofNavIcon,
        isDefaultBottomNavBarRotation: false,
        isDefaultBottomNavBarIconRotation: false));

    // Update in Hive
    MyHiveBoxes.theme.put(MyHiveKeys.bottomNavBarRotation, newValueOfNav);
    MyHiveBoxes.theme
        .put(MyHiveKeys.bottomNavBarIconRotation, newValueofNavIcon);

    MyHiveBoxes.theme.put(MyHiveKeys.isDefaultBottomNavBarRotation, false);
    MyHiveBoxes.theme.put(MyHiveKeys.isDefaultBottomNavBarIconRotation, false);
  }

  // Update Rotation
  updateBottomNavigationBarRotationToLeft() {
    double newValueOfNav = state.bottomNavBarRotation - 0.01;
    double newValueOfIcon = state.bottomNavBarIconRotation + 0.01;

    emit(state.copyWith(
        bottomNavBarRotation: newValueOfNav,
        bottomNavBarIconRotation: newValueOfIcon,
        isDefaultBottomNavBarRotation: false,
        isDefaultBottomNavBarIconRotation: false));

    // Update in Hive
    MyHiveBoxes.theme.put(MyHiveKeys.bottomNavBarRotation, newValueOfNav);
    MyHiveBoxes.theme.put(MyHiveKeys.bottomNavBarIconRotation, newValueOfIcon);

    MyHiveBoxes.theme.put(MyHiveKeys.isDefaultBottomNavBarRotation, false);
    MyHiveBoxes.theme.put(MyHiveKeys.isDefaultBottomNavBarIconRotation, false);
  }

  decreaseBottomNavBarWidth() {
    final double width = state.bottomNavBarWidth;
    final double updatedWidth =
        width >= 0.1 ? state.bottomNavBarWidth - 0.03 : state.bottomNavBarWidth;
    emit(state.copyWith(bottomNavBarWidth: updatedWidth));

    // Update in Hive
    MyHiveBoxes.theme.put(MyHiveKeys.bottomNavBarWidth, updatedWidth);
  }

  increaseBottomNavBarHeight() {
    final double height = state.bottomNavBarHeight;
    double updatedHeight = height <= 0.2
        ? state.bottomNavBarHeight + 0.03
        : state.bottomNavBarHeight;
    emit(state.copyWith(bottomNavBarHeight: updatedHeight));
    // Update in Hive
    MyHiveBoxes.theme.put(MyHiveKeys.bottomNavBarHeight, updatedHeight);
  }

  decreaseBottomNavBarHeight() {
    final double height = state.bottomNavBarHeight;
    final double updatedHeight = height > 0.04
        ? state.bottomNavBarHeight - 0.03
        : state.bottomNavBarHeight;
    emit(state.copyWith(bottomNavBarHeight: updatedHeight));
    // Update in Hive
    MyHiveBoxes.theme.put(MyHiveKeys.bottomNavBarHeight, updatedHeight);
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
        bottomNavBarIconRotation: 0,
        bottomNavBarRotation: 0,
      ),
    );

    // Updates in Hive
    MyHiveBoxes.theme.put(MyHiveKeys.isDefaultAppBarColor, true);
    MyHiveBoxes.theme.put(MyHiveKeys.isDefaultBottomNavBarBgColor, true);
    MyHiveBoxes.theme.put(MyHiveKeys.isDefaultScaffoldColor, true);
    MyHiveBoxes.theme.put(MyHiveKeys.contrastLevel, 0.9);
    MyHiveBoxes.theme.put(MyHiveKeys.defaultTheme, true);
    MyHiveBoxes.theme.put(MyHiveKeys.useMaterial3, true);
    MyHiveBoxes.theme.put(MyHiveKeys.bottomNavBarPositionFromBottom, 0.05);
    MyHiveBoxes.theme.put(MyHiveKeys.bottomNavBarPositionFromLeft, 0.1);
    MyHiveBoxes.theme.put(MyHiveKeys.bottomNavBarHeight, 0.045);
    MyHiveBoxes.theme.put(MyHiveKeys.bottomNavBarWidth, 0.8);
  }
}
