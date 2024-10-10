import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_player/presentation/pages/initial/widgets/bottom-navbar/bottom_nav_bar_button_widget.dart';

import '../../../../../logic/bottom_nav_bar_cubit/bottom_nav_bar_cubit.dart';
import '../../../../../logic/theme_cubit/theme_cubit.dart';

class CustomBottomNavBarWidget extends StatelessWidget {
  const CustomBottomNavBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double mqWidth = MediaQuery.sizeOf(context).width;
    final double mqHeight = MediaQuery.sizeOf(context).height;

    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
          builder: (context, state) {
            int index = state.index;
            return Positioned(
              //------Margin Bottom is  5% of Screen Height  --------//
              bottom: mqHeight * 0.05,
              //------Margin Left is  10% of Screen Width  --------//
              left: mqWidth * 0.1,
              //------Margin Right is  10% of Screen Width  --------//
              right: mqWidth * 0.1,
              child: Container(
                  //---Height is 5% of Screen Height -----///
                  height: mqHeight * 0.04,
                  //---Width is 80% of Screen Width -----///
                  width: mqWidth * 0.8,
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow:  [
                        BoxShadow(
                          color: themeState.isDarkMode?Colors.white54:Colors.black45,
                          blurRadius: 3,
                        ),
                      ]),

                  //---------------- Buttons ---------------//
                  child: Row(
                    children: [
                      //--- Audio Button ---//
                      BottomNavBarButtonWidget(
                        icon: Icons.music_note,
                        isSelected: index == 0,
                        pageIndex: 0,
                      ),

                      //--- Video Button ---//
                      BottomNavBarButtonWidget(
                        icon: Icons.video_collection,
                        isSelected: index == 1,
                        pageIndex: 1,
                      ),

                      //--- Settings Button ---//
                      BottomNavBarButtonWidget(
                          icon: Icons.settings,
                          isSelected: index == 2,
                          pageIndex: 2),
                    ],
                  )),
            );
          },
        );
      },
    );
  }
}
