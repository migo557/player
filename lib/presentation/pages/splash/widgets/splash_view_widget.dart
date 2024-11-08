import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:open_player/base/assets/fonts/styles.dart';

class SplashViewWidget extends StatelessWidget {
  const SplashViewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child:
            //---Splash View
            Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedTextKit(
          isRepeatingAnimation: false,
          animatedTexts: [
            TyperAnimatedText(
              "Open",
              speed: Duration(milliseconds: 400),
              textStyle: TextStyle(fontSize: 35, fontFamily: AppFonts.poppins),
            ),
          ],
        ),
        AnimatedTextKit(
          isRepeatingAnimation: false,
          animatedTexts: [
            TyperAnimatedText(
              "Player",
              speed: Duration(milliseconds: 300),
              textStyle: TextStyle(fontSize: 35, fontFamily: AppFonts.arizonia),
            )
          ],
        ),
      ],
    )

        //----- On Boarding View
        );
  }
}
