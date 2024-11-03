import 'package:flutter/material.dart';
import 'package:open_player/base/assets/fonts/app_fonts.dart';

class SplashBuildTitleTextWidget extends StatelessWidget {
  const SplashBuildTitleTextWidget({super.key, required this.text, this.style, this.textAlign});

  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style:
          style ?? const TextStyle(fontFamily: AppFonts.poppins, fontSize: 35),
    );
  }
}
