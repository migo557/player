import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_player/base/di/dependency_injection.dart';
import 'package:open_player/logic/audio_page_tab_bar_cubit/audio_page_tab_bar_cubit.dart';
import 'package:open_player/logic/bottom_nav_bar_cubit/bottom_nav_bar_cubit.dart';
import 'package:open_player/logic/greeting/greeting_cubit.dart';
import 'package:open_player/logic/language_cubit/language_cubit.dart';
import 'package:open_player/logic/theme_cubit/theme_cubit.dart';

///?----------------   B L O C   P R O V I D E R S   -------------///
///////////////////////////////////////////////////////////////////
 myBlocProviders() {
  return [
    BlocProvider(
      create: (context) => BottomNavBarCubit(),
    ),
     BlocProvider(
      create: (context) => AudioPageTabBarCubit(),
    ),

      BlocProvider(
      create: (context) => ThemeCubit(),
    ),

         BlocProvider(
      create: (context) => LanguageCubit(),
    ),

          BlocProvider(
      create: (context) => GreetingCubit(languageCubit: locator<LanguageCubit>()),
    ),
  ];
}
