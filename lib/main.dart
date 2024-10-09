import 'package:flutter/material.dart';
import 'package:open_player/base/theme/themes.dart';
import 'package:open_player/presentation/pages/initial/ui/initial-page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      title: 'Open Player',
      home: const InitialPage(),
    );
  }
}
