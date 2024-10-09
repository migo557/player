
import 'package:flutter/material.dart';

import 'app_routes.dart';

class AppRouter {
  static generateRoute(RouteSettings settings) async{
    switch (settings.name) {
      case AppRoutes.splashRoute:
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
      // return MaterialPageRoute(builder: (_) => const SplashPage());
      case AppRoutes.onBoardingRoute:
      // return MaterialPageRoute(builder: (_) => const OnBoardingPage());
      case AppRoutes.initialRoute:
      // return MaterialPageRoute(builder: (_) => const InitialPage());

      case AppRoutes.settingsRoute:
      // return MaterialPageRoute(builder: (_) => const SettingsPage());
      case AppRoutes.aboutRoute:
      // return MaterialPageRoute(builder: (_) => const AboutPage());
      case AppRoutes.userProfileRoute:
      // return MaterialPageRoute(builder: (_) => const ProfilePage());
      case AppRoutes.privacyPolicyRoute:
      // return MaterialPageRoute(builder: (_) => const PrivacyPolicyPage());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }

}
