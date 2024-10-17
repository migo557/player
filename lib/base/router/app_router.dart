import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:open_player/presentation/pages/settings/change-theme/ui/change-theme-page.dart';
import 'package:open_player/presentation/pages/settings/language/ui/language_page.dart';

import '../../presentation/pages/initial/ui/initial-page.dart';
import '../../presentation/pages/settings/setting/ui/setting_page.dart';
import 'app_routes.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      
      path: AppRoutes.initialRoute,
      builder: (context, state) => const InitialPage(),
    ),
    GoRoute(
      path: AppRoutes.settingsRoute,
      builder: (context, state) => const SettingPage(),
    ),
    GoRoute(
      path: AppRoutes.changeThemeRoute,
      builder: (context, state) => const ChangeThemePage(),
    ),
    GoRoute(
      name: AppRoutes.languageRoute,
      path: AppRoutes.languageRoute,
      builder: (context, state) => const LanguagePage(),
    ),
  ],
  errorBuilder: (context, state) {
    return Scaffold(
      body: Center(
        child: Text(' ${state.error}'),
      ),
    );
  },
);
