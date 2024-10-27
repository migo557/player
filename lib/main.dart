import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_kit/media_kit.dart';
import 'package:open_player/base/db/hive/hive.dart';
import 'package:open_player/base/theme/themes.dart';
import 'package:open_player/base/di/dependency_injection.dart';
import 'package:open_player/base/router/app_router.dart';
import 'package:open_player/data/bloc_providers/bloc_providers.dart';
import 'package:open_player/logic/theme_cubit/theme_cubit.dart';
import 'package:open_player/logic/theme_cubit/theme_state.dart';

// late MyObjectBoxDB objectbox;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeLocator();
  // Necessary initialization for package:media_kit.
  MediaKit.ensureInitialized();

  // Create ObjectBox instance
  // objectbox = await MyObjectBoxDB.create();

  // Initialize ObjectBoxes
  // MyObjectBoxes.init(objectbox);

  // Initialize Hive database and register custom adapters
  await MyHiveDB.initializeHive();

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
      providers: myBlocProviders(),
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
