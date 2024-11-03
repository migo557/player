import 'package:color_log/color_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:open_player/base/db/hive/hive.dart';
import 'package:open_player/presentation/pages/splash/widgets/on_boarding_view_widget.dart';
import 'package:open_player/presentation/pages/splash/widgets/splash_view_widget.dart';
import '../../../../base/strings/app_strings.dart';
import '../../../../base/router/app_routes.dart';
import '../../../../logic/audio_bloc/audios_bloc.dart';
import '../../../../logic/videos_bloc/videos_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  // State management for splash animation
  late AnimationController _animationController;
  late List<String> _splashMessages;
  int _currentMessageIndex = 0;

  @override
  void initState() {
    super.initState();

    // Initialize splash messages
    _splashMessages = [
      AppStrings.noAds,
      AppStrings.noSubscription,
      AppStrings.noTracking,
      AppStrings.justPureEntertainment,
      AppStrings.appName,
    ];

    // Setup animation controller for smooth transitions
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..addStatusListener(_handleAnimationStatus);

    // Start initialization process
    _initializeApp();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  ///----------------------------- Build Method ---------------------------------------///
  @override
  Widget build(BuildContext context) {
    final isLoggedIn =
        MyHiveBoxes.userBox.get(MyHiveKeys.userIsLoggedIn, defaultValue: false);
    return Scaffold(
      backgroundColor:  _currentMessageIndex==3||_currentMessageIndex==1?Colors.black:null,
      body: Center(
        child: isLoggedIn
            //---Splash View
            ? const SplashViewWidget()
            //----- On Boarding View
            : OnBoardingViewWidget(
                splashMessages: _splashMessages,
                currentMessageIndex: _currentMessageIndex),
      ),
    );
  }

  ///----------------------------- Methods ---------------------------------------///
  ///
  void _handleAnimationStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      // Cycle through splash messages or navigate
      _cycleOrNavigate();
    }
  }

  Future<void> _initializeApp() async {
    try {
      bool isLoggedIn = await MyHiveBoxes.userBox
          .get(MyHiveKeys.userIsLoggedIn, defaultValue: false);

      if (isLoggedIn) {
        _loadMediaContent();
        // Ensure immediate navigation to main page
        Future.delayed(const Duration(seconds: 3)).whenComplete(
          () {
            _navigateToMainPage();
          },
        ); // Optional short delay
      } else {
        // Non-Login flow with message cycling
        _startSplashAnimation();
      }
    } catch (e, stackTrace) {
      clog.error(
          'App Initialization Failed: $e\nStack Trace.....\n$stackTrace');
    }
  }

  void _startSplashAnimation() {
    _animationController.forward();
  }

  void _cycleOrNavigate() {
    setState(() {
      if (_currentMessageIndex < _splashMessages.length - 1) {
        _currentMessageIndex++;
        _animationController.reset();
        _animationController.forward();
      } else {
        _navigateToLanguageSetup();
      }
    });
  }

  void _navigateToMainPage() {
    context.pushReplacement(AppRoutes.mainRoute);
  }

  void _navigateToLanguageSetup() {
    context.pushReplacement(AppRoutes.languageRoute);
  }

  void _loadMediaContent() {
    context.read<AudiosBloc>().add(AudiosLoadEvent());
    context.read<VideosBloc>().add(VideosLoadEvent());
  }
}
