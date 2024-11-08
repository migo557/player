import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:open_player/base/assets/images/app_images.dart';

class AudioPlayerBackgroundBlurImageWidget extends StatelessWidget {
  const AudioPlayerBackgroundBlurImageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.defaultProfile),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
