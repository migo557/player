import 'package:flutter/material.dart';
import 'package:open_player/base/theme/app_textstyles.dart';

class AppBarProfileNameWidget extends StatelessWidget {
  const AppBarProfileNameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Furqan Uddin",
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: AppTextStyles.profileName1,
    );
  }
}
