import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:open_player/base/db/hive_service.dart';
import 'package:open_player/logic/audio_bloc/audios_bloc.dart';
import 'package:open_player/logic/videos_bloc/videos_bloc.dart';
import 'package:open_player/presentation/pages/splash/widgets/on_boarding_view_widget.dart';
import 'package:open_player/presentation/pages/splash/widgets/splash_view_widget.dart';

import '../../../../base/router/router.dart';

class SplashPage extends HookWidget {
  const SplashPage({super.key});

  ///----------------------------- Build Method ---------------------------------------///
  @override
  Widget build(BuildContext context) {
    final isLoggedIn =
        MyHiveBoxes.user.get(MyHiveKeys.userIsLoggedIn, defaultValue: false);

    useEffect(
      () {
        navigateToNextPage(isLoggedIn, context);
        fetchMedia(context, isLoggedIn);
        return;
      },
    );
    return Scaffold(
      body: isLoggedIn ? SplashViewWidget() : OnBoardingViewWidget(),
    );
  }

  void navigateToNextPage(bool isLogin, BuildContext context) {
    if (isLogin) {
      Future.delayed(Duration(seconds: 4)).whenComplete(
        () {
          context.pushReplacement(AppRoutes.mainRoute);
        },
      );
    } else {
      Future.delayed(Duration(seconds: 10)).whenComplete(
        () {
          context.pushReplacement(AppRoutes.languageRoute);
        },
      );
    }
  }

  fetchMedia(BuildContext context, bool isLoggedIn) {
    if (isLoggedIn) {
      context.read<AudiosBloc>().add(AudiosLoadEvent());
      context.read<VideosBloc>().add(VideosLoadEvent());
    }
  }
}
