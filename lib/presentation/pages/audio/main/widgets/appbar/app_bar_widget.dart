import 'package:flutter/material.dart';
import 'package:open_player/presentation/pages/audio/main/widgets/appbar/app_bar_greeting_text_widget.dart';
import 'package:open_player/presentation/pages/audio/main/widgets/appbar/app_bar_profile_image_widget.dart';
import 'package:open_player/presentation/pages/audio/main/widgets/appbar/app_bar_profile_name_widget.dart';
import 'package:open_player/presentation/pages/audio/main/widgets/appbar/app_bar_search_button_widget.dart';
import 'package:open_player/presentation/pages/audio/main/widgets/appbar/app_bar_theme_mode_button_widget.dart';

class AudioPageAppBarWidget extends StatelessWidget {
  const AudioPageAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final double mqWidth = MediaQuery.sizeOf(context).width;
    final double mqHeight = MediaQuery.sizeOf(context).height;
    return SliverAppBar(
      elevation: 0,
    
      toolbarHeight: mqHeight * 0.13,
      floating: true,
      actions: [
        Expanded(
          child: Row(
            children: [
              //------- Space -----//
              SizedBox(
                width: mqWidth * 0.02,
              ),
              //------  Profile Image -------//
              const AppBarProfileImageWidget(),

              //------- Space -----//
              SizedBox(
                width: mqWidth * 0.03,
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //------- Greeting Text-----///
                  AppBarGreetingTextWidget(),
                  //------- Profile Name-----///
                  AppBarProfileNameWidget(),
                ],
              ),

              //----- Spacer -----///
              const Spacer(),

              //---- Search Button -----//
              const AppBarSearchButtonWidget(),

              

              //---- ThemeMode Button -----//
              const AppBarThemeModeButtonWidget(),

              //------- Space -----//
              SizedBox(
                width: mqWidth * 0.01,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
