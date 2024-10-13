import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:open_player/base/theme/colors_palates.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit()
      : super(
          ThemeState(
              defaultTheme: true,
              useMaterial3: true,
              isBlackMode: false,
              isDarkMode: false,
              flexScheme: FlexScheme.amber,
              flexIndex: 0,
              contrastLevel: 0.5,
              visualDensity: VisualDensity.comfortable,
              isDefaultScaffoldColor: true,
              isDefaultAppBarColor: true,
              isDefaultBottomNavBarBgColor: true,
              customScaffoldColor: AppColors.colorHexCodesList[0],
              customAppBarColor: AppColors.colorHexCodesList[0],
              customBottomNavBarBgColor: AppColors.colorHexCodesList[0],
              bottomNavBarPositionFromBottom: 0.05,
              bottomNavBarPositionFromLeft: 0.1,
              isDefaultBottomNavBarPosition: true,
              bottomNavBarHeight: 0.045,
              bottomNavBarWidth: 0.8,
              isHoldBottomNavBarCirclePositionButton: false),
        );

  toggleThemeMode() {
    bool themeMode = state.isDarkMode;
    emit(state.copyWith(
        isDarkMode: themeMode ? false : true, isBlackMode: false));
  }

  changeFlexScheme({required flexScheme}) {
    disableDefaultTheme();
    emit(state.copyWith(flexScheme: flexScheme));
  }

  changeFlexIndex(int index) {
    emit(state.copyWith(flexIndex: index));
  }

  toggleDefaultTheme() {
    emit(state.copyWith(
      defaultTheme: !state.defaultTheme,
    ));
  }

  disableDefaultTheme() {
    emit(state.copyWith(defaultTheme: false));
  }

  toggleBlackMode() {
    emit(state.copyWith(isBlackMode: !state.isBlackMode));
  }

  disableBlackMode() {
    emit(state.copyWith(isBlackMode: false));
  }

  toggleMaterial3() {
    emit(
      state.copyWith(useMaterial3: !state.useMaterial3),
    );
  }

  changeContrastLevel(double contrast) {
    emit(state.copyWith(contrastLevel: contrast));
  }

  changeVisualDensity(VisualDensity visualDensity) {
    emit(state.copyWith(visualDensity: visualDensity));
  }

  changeScaffoldBgColor(int colorCode) {
    emit(state.copyWith(
        customScaffoldColor: colorCode, isDefaultScaffoldColor: false));
  }

  changeAppBarColor(int colorCode) {
    emit(state.copyWith(
        customAppBarColor: colorCode, isDefaultAppBarColor: false));
  }

  changeBottomNavBarBgColor(int colorCode) {
    emit(
      state.copyWith(
          customBottomNavBarBgColor: colorCode,
          isDefaultBottomNavBarBgColor: false),
    );
  }

  resetToDefaultScaffoldColor() {
    emit(state.copyWith(isDefaultScaffoldColor: true));
  }

  resetToDefaultAppBarColor() {
    emit(state.copyWith(isDefaultAppBarColor: true));
  }

  resetToDefaultBottomNavBarBgColor() {
    emit(state.copyWith(isDefaultBottomNavBarBgColor: true));
  }

  resetToDefaultBottomNavBarPosition() {
    emit(state.copyWith(
      isDefaultBottomNavBarPosition: true,
      bottomNavBarPositionFromBottom: 0.05,
      bottomNavBarPositionFromLeft: 0.1,
    ));
  }

  resetToDefaultBottomNavBarHeightAndWidth() {
    emit(state.copyWith(
      bottomNavBarHeight: 0.045,
      bottomNavBarWidth: 0.08,
    ));
  }

  changeBottomNavBarPositionTop() {
    emit(
      state.copyWith(
          isDefaultBottomNavBarPosition: false,
          bottomNavBarPositionFromBottom:
              state.bottomNavBarPositionFromBottom <= 0.95
                  ? state.bottomNavBarPositionFromBottom + 0.01
                  : 0),
    );
  }

  changeBottomNavBarPositionLeft() {
    emit(
      state.copyWith(
          isDefaultBottomNavBarPosition: false,
          bottomNavBarPositionFromLeft:
              state.bottomNavBarPositionFromLeft >= 0.01
                  ? state.bottomNavBarPositionFromLeft - 0.01
                  : 0),
    );
  }

  changeBottomNavBarPositionRight() {
    emit(
      state.copyWith(
          isDefaultBottomNavBarPosition: false,
          bottomNavBarPositionFromLeft:
              state.bottomNavBarPositionFromLeft <= 0.95
                  ? state.bottomNavBarPositionFromLeft + 0.01
                  : 0),
    );
  }

  changeBottomNavBarPositionBottom() {
    emit(
      state.copyWith(
          isDefaultBottomNavBarPosition: false,
          bottomNavBarPositionFromBottom:
              state.bottomNavBarPositionFromBottom >= 0.01
                  ? state.bottomNavBarPositionFromBottom - 0.01
                  : 0),
    );
  }

  increaseBottomNavBarWidth() {
    final double width = state.bottomNavBarWidth;
    emit(state.copyWith(
        bottomNavBarWidth: width < 1.0
            ? state.bottomNavBarWidth + 0.03
            : state.bottomNavBarWidth));
  }

  decreaseBottomNavBarWidth() {
    final double width = state.bottomNavBarWidth;
    emit(state.copyWith(
        bottomNavBarWidth: width >= 0.1
            ? state.bottomNavBarWidth - 0.03
            : state.bottomNavBarWidth));
  }

  increaseBottomNavBarHeight() {
    final double height = state.bottomNavBarHeight;
    emit(state.copyWith(
        bottomNavBarHeight: height <= 0.2
            ? state.bottomNavBarHeight + 0.03
            : state.bottomNavBarHeight));
  }

  decreaseBottomNavBarHeight() {
    final double height = state.bottomNavBarHeight;
    emit(state.copyWith(
        bottomNavBarHeight: height > 0.04
            ? state.bottomNavBarHeight - 0.03
            : state.bottomNavBarHeight));
  }

  enableHoldBottomNavBarCirclePositionButton() {
    bool isEnabled = state.isHoldBottomNavBarCirclePositionButton;
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
  }
}
