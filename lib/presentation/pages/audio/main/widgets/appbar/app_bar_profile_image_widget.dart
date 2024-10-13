import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:open_player/base/assets/images/app-images.dart';

class AppBarProfileImageWidget extends StatelessWidget {
  const AppBarProfileImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        log("Profile Avatar is clicked");
      },
      child: const CircleAvatar(
        minRadius: 20,
        maxRadius: 28,
        backgroundImage: AssetImage(AppImages.defaultProfile),
      ),
    );
  }
}
