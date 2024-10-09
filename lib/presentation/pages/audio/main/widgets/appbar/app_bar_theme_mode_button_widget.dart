import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarThemeModeButtonWidget extends StatelessWidget {
  const AppBarThemeModeButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 40,
      onPressed: (){}, icon: const Icon(Icons.dark_mode),);
  }
}
