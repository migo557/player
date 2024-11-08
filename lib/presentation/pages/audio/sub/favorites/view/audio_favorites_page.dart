import 'package:flutter/material.dart';

class AudioFavoritePage extends StatelessWidget {
  const AudioFavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
        child: Center(
      child: Text("Favorite"),
    ));
  }
}
