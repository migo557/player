part of 'theme_cubit.dart';

class ThemeState extends Equatable {
  ThemeState({
    required this.isBlackMode,
    required this.isDarkMode,
    required this.useMaterial3,
    required this.flexScheme,
    required this.flexIndex,
    required this.defaultTheme,
  });

  bool isDarkMode;
  bool isBlackMode;
  bool defaultTheme;
  bool useMaterial3;
  FlexScheme flexScheme;

  int flexIndex;

  ThemeState copyWith(
      {isDarkMode, isBlackMode, flexScheme, flexIndex, defaultTheme, useMaterial3}) {
    return ThemeState(
      useMaterial3: useMaterial3?? this.useMaterial3,
      defaultTheme: defaultTheme ?? this.defaultTheme,
      isBlackMode: isBlackMode ?? this.isBlackMode,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      flexScheme: flexScheme ?? this.flexScheme,
      flexIndex: flexIndex ?? this.flexIndex,
    );
  }

  @override
  List<Object> get props =>
      [isBlackMode, flexScheme, flexIndex, isDarkMode, defaultTheme, useMaterial3];
}
