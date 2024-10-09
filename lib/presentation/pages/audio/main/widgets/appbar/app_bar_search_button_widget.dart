import 'package:flutter/material.dart';

class AppBarSearchButtonWidget extends StatelessWidget {
  const AppBarSearchButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(iconSize: 40, onPressed: () {}, icon: const Icon(Icons.search),);
  }
}
