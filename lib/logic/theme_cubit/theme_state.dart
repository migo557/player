part of 'theme_cubit.dart';

class ThemeState extends Equatable {
  ThemeState({
    required this.isBlackMode,
    required this.isDarkMode,
    required this.useMaterial3,
    required this.flexScheme,
    required this.flexIndex,
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

  bool isDarkMode;
  bool isBlackMode;
  bool defaultTheme;
  bool useMaterial3;
  bool isDefaultScaffoldColor;
  bool isDefaultAppBarColor;
  bool isDefaultBottomNavBarBgColor;
  bool isDefaultBottomNavBarPosition;

  double contrastLevel;
  FlexScheme flexScheme;
  VisualDensity visualDensity;
  int customScaffoldColor;
  int customAppBarColor;
  int customBottomNavBarBgColor;
  int flexIndex;
  double bottomNavBarPositionFromLeft;
  double bottomNavBarPositionFromBottom;
  double bottomNavBarWidth;
  double bottomNavBarHeight;
  bool isHoldBottomNavBarCirclePositionButton;

  ThemeState copyWith({
    isDarkMode,
    isBlackMode,
    flexScheme,
    flexIndex,
    defaultTheme,
    useMaterial3,
    contrastLevel,
    visualDensity,
    customScaffoldColor,
    customAppBarColor,
    customBottomNavBarBgColor,
    isDefaultScaffoldColor,
    isDefaultAppBarColor,
    isDefaultBottomNavBarBgColor,
    isDefaultBottomNavBarPosition,
    bottomNavBarPositionFromLeft,
    bottomNavBarPositionFromBottom,
    bottomNavBarHeight,
    bottomNavBarWidth,
    isHoldBottomNavBarCirclePositionButton,
  }) {
    return ThemeState(
        useMaterial3: useMaterial3 ?? this.useMaterial3,
        defaultTheme: defaultTheme ?? this.defaultTheme,
        isBlackMode: isBlackMode ?? this.isBlackMode,
        isDarkMode: isDarkMode ?? this.isDarkMode,
        flexScheme: flexScheme ?? this.flexScheme,
        flexIndex: flexIndex ?? this.flexIndex,
        contrastLevel: contrastLevel ?? this.contrastLevel,
        visualDensity: visualDensity ?? this.visualDensity,
        customScaffoldColor: customScaffoldColor ?? this.customScaffoldColor,
        isDefaultScaffoldColor:
            isDefaultScaffoldColor ?? this.isDefaultScaffoldColor,
        customAppBarColor: customAppBarColor ?? this.customAppBarColor,
        isDefaultAppBarColor: isDefaultAppBarColor ?? this.isDefaultAppBarColor,
        isDefaultBottomNavBarBgColor:
            isDefaultBottomNavBarBgColor ?? this.isDefaultAppBarColor,
        customBottomNavBarBgColor:
            customBottomNavBarBgColor ?? this.customBottomNavBarBgColor,
        bottomNavBarPositionFromBottom: bottomNavBarPositionFromBottom ??
            this.bottomNavBarPositionFromBottom,
        bottomNavBarPositionFromLeft:
            bottomNavBarPositionFromLeft ?? this.bottomNavBarPositionFromLeft,
        isDefaultBottomNavBarPosition:
            isDefaultBottomNavBarPosition ?? this.isDefaultBottomNavBarPosition,
        bottomNavBarHeight: bottomNavBarHeight ?? this.bottomNavBarHeight,
        bottomNavBarWidth: bottomNavBarWidth ?? this.bottomNavBarWidth,
        isHoldBottomNavBarCirclePositionButton: isHoldBottomNavBarCirclePositionButton??this.isHoldBottomNavBarCirclePositionButton,
        );
  }

  @override
  List<Object> get props => [
        isBlackMode,
        flexScheme,
        flexIndex,
        isDarkMode,
        defaultTheme,
        useMaterial3,
        contrastLevel,
        visualDensity,
        customScaffoldColor,
        isDefaultScaffoldColor,
        isDefaultAppBarColor,
        isDefaultBottomNavBarBgColor,
        customAppBarColor,
        customBottomNavBarBgColor,
        bottomNavBarPositionFromBottom,
        bottomNavBarPositionFromLeft,
        isDefaultBottomNavBarPosition,
        bottomNavBarHeight,
        bottomNavBarWidth,
        isHoldBottomNavBarCirclePositionButton
      ];
}
