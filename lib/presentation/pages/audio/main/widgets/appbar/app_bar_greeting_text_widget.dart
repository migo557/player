import 'package:flutter/material.dart';
import 'package:open_player/base/theme/app_textstyles.dart';

class AppBarGreetingTextWidget extends StatelessWidget {
  const AppBarGreetingTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Good Morning",
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: AppTextStyles.greeting1,
    );
  }
}
