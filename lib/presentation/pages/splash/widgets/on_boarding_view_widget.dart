import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:open_player/base/strings/app_strings.dart';
import 'package:open_player/presentation/pages/splash/widgets/splash_build_title_text_widget.dart';

import '../../../../base/assets/fonts/app_fonts.dart';

class OnBoardingViewWidget extends StatelessWidget {
  const OnBoardingViewWidget({
    super.key,
    required List<String> splashMessages,
    required int currentMessageIndex,
  }) : _splashMessages = splashMessages, _currentMessageIndex = currentMessageIndex;

  final List<String> _splashMessages;
  final int _currentMessageIndex;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeIn(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SplashBuildTitleTextWidget(
                  text: _splashMessages[_currentMessageIndex],textAlign: TextAlign.center, style:_currentMessageIndex==1||_currentMessageIndex==3? const TextStyle(fontFamily: AppFonts.poppins, fontSize: 35, color: Colors.white):null,),
            ),
                
                
          ),
          FadeIn(
            delay: const Duration(milliseconds: 7200),
            child: const Text(
              AppStrings.appTagline,
              style: TextStyle(fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }
}


