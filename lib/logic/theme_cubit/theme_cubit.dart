import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit()
      : super(ThemeState(
          defaultTheme: true,
          useMaterial3: true,
          isBlackMode: false,
          isDarkMode: false,
          flexScheme: FlexScheme.amber,
          flexIndex: 0,
        ));

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
}
