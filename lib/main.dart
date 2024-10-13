import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_player/base/theme/themes.dart';
import 'package:open_player/presentation/pages/initial/ui/initial-page.dart';
import 'base/di/dependency_injection.dart';
import 'data/bloc_providers/bloc_providers.dart';
import 'logic/theme_cubit/theme_cubit.dart';

void main() async {
  // Ensure that widget binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependency injection
  await initializeLocator(); // This should initialize all dependencies

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
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: locator<AppThemes>().themes(themeState),
            title: "Open Player",
            home: const InitialPage(),
          );
        },
      ),
    );
  }
}
