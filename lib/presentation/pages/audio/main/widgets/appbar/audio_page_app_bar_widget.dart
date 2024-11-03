import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:open_player/base/router/app_router.dart';
import 'package:open_player/base/router/app_routes.dart';
import 'package:open_player/logic/audio_bloc/audios_bloc.dart';
import 'package:open_player/presentation/common/nothing_widget.dart';
import 'package:open_player/presentation/pages/audio/main/widgets/appbar/app_bar_greeting_text_widget.dart';
import 'package:open_player/presentation/pages/audio/main/widgets/appbar/app_bar_profile_name_widget.dart';

import '../../../../../../logic/audio_player_bloc/audio_player_bloc.dart';
import 'app_bar_profile_image_widget.dart';
import 'app_bar_search_button_widget.dart';
import '../../../../../common/custom_theme_mode_button_widget.dart';

class AudioPageAppBarWidget extends StatelessWidget {
  const AudioPageAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final double mqWidth = MediaQuery.sizeOf(context).width;
    final double mqHeight = MediaQuery.sizeOf(context).height;
    return BlocSelector<AudioPlayerBloc, AudioPlayerState,
        AudioPlayerSuccessState?>(
      selector: (state) {
        return state is AudioPlayerSuccessState ? state : null;
      },
      builder: (context, state) {
        return SliverAppBar(
          elevation: 0,
          toolbarHeight: mqHeight * 0.15,
          floating: true,
          primary: state != null ? false : true,
          actions: [
            Expanded(
              child: Column(
                children: [
                  //------------------ Search Section
                  AudioPageAppBarSearchBarWidget(),
                  Gap(
                    mqHeight * 0.01,
                  ),

                  //-------------------- Top Section
                  Row(
                    children: [
                      //------- Space -----//
                      Gap(
                        mqWidth * 0.02,
                      ),
                      //------  Profile Image -------//
                      const AppBarProfileImageWidget(),

                      //------- Space -----//
                      Gap(
                        mqWidth * 0.03,
                      ),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //------- Greeting Text-----///
                            AppBarGreetingTextWidget(),
                            //------- Profile Name-----///
                            AppBarProfileNameWidget(),
                          ],
                        ),
                      ),

                      //---- Search Button -----//
                      if (state is AudioPlayerSuccessState)
                        const AudioPageAppBarSearchButtonWidget(),

                      //---- ThemeMode Button -----//
                      const CustomThemeModeButtonWidget(),

                      //------- Space -----//
                      Gap(
                        mqWidth * 0.01,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class AudioPageAppBarSearchBarWidget extends StatelessWidget {
  const AudioPageAppBarSearchBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double mqWidth = MediaQuery.sizeOf(context).width;
    final double mqHeight = MediaQuery.sizeOf(context).height;
    return BlocSelector<AudioPlayerBloc, AudioPlayerState,
        AudioPlayerSuccessState?>(
      selector: (state) => state is AudioPlayerSuccessState ? state : null,
      builder: (context, state) {
        if (state == null) {
          return GestureDetector(
            onTap: () {
              context.push(AppRoutes.searchAudiosRoute);
            },
            child: Padding(
              padding: EdgeInsets.only(
                left: mqWidth * 0.01,
                right: mqWidth * 0.01,
              ),
              child: Card(
                child: Container(
                  height: mqHeight * 0.05,
                  width: mqWidth,
                  decoration: BoxDecoration(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.search),
                        Text(
                          "  Search songs",
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          return nothing;
        }
      },
    );
  }
}
