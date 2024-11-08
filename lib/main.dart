import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_player/base/db/hive_service.dart';
import 'package:open_player/base/theme/themes_data.dart';
import 'package:open_player/base/di/injection.dart';
import 'package:open_player/base/router/router.dart';
import 'package:open_player/bloc_providers.dart';
import 'package:open_player/logic/theme_cubit/theme_cubit.dart';
import 'package:open_player/logic/theme_cubit/theme_state.dart';
import 'base/services/notification/notification_services.dart';

// late MyObjectBoxDB objectbox;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeLocator();

  // Create ObjectBox instance
  // objectbox = await MyObjectBoxDB.create();

  // Initialize ObjectBoxes
  // MyObjectBoxes.init(objectbox);

  // Initialize Hive database and register custom adapters
  await MyHiveDB.initializeHive();

  // Set up notification services
  await NotificationService().initNotification();

  // Set up JustAudioBackground services
  await NotificationService().initJustAUdioBackgroundNotification();

  // Set preferred screen orientations
  // clog.info('Setting preferred orientations');
  // await SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]);
  // clog.checkSuccess(true, 'Preferred orientations set to Potrait Up Only');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: blocProviders(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp.router(
            routerConfig: router,
            themeAnimationCurve: Easing.standardAccelerate,
            themeAnimationDuration: const Duration(milliseconds: 1000),
            debugShowCheckedModeBanner: false,
            theme: locator<AppThemes>().themes(themeState),
            title: "Open Player",
          );
        },
      ),
    );
  }
}
