import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:open_player/base/strings/app_strings.dart';
import 'package:open_player/presentation/common/version_info_text_widget.dart';
import 'package:open_player/presentation/pages/splash/widgets/splash_build_title_text_widget.dart';

class SplashViewWidget extends StatelessWidget {
  const SplashViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: FadeIn(
            child: const SplashBuildTitleTextWidget(text: AppStrings.appName),
          ),
        ),
        const Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: VersionInfoTextWidget(),
          ),
        ),
      ],
    );
  }
}
