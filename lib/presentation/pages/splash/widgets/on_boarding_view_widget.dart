import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:open_player/base/strings/app_strings.dart';
import 'package:open_player/base/theme/app_textstyles.dart';

class OnBoardingViewWidget extends StatelessWidget {
  const OnBoardingViewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedTextKit(isRepeatingAnimation: false, animatedTexts: [
        RotateAnimatedText(AppStrings.noAds,
            textStyle: AppTextStyles.onBoarding),
        RotateAnimatedText(AppStrings.noSubscription,
            textStyle: AppTextStyles.onBoarding),
        RotateAnimatedText(AppStrings.noTracking,
            textStyle: AppTextStyles.onBoarding),
        FadeAnimatedText("Open Player",
            textStyle: AppTextStyles.onBoarding, duration: Duration(seconds: 3))
      ]),
    );
  }
}
