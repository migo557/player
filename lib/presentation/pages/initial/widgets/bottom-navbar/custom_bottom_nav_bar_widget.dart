import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
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
              //------Default Margin Bottom is  5% of Screen Height  --------//
              bottom: mqHeight * themeState.bottomNavBarPositionFromBottom,
              //------Default Margin Left is  10% of Screen Width  --------//
              left: mqWidth * themeState.bottomNavBarPositionFromLeft,
              //------Default Margin Right is  10% of Screen Width  --------//
              right: themeState.isDefaultBottomNavBarPosition
                  ? mqWidth * themeState.bottomNavBarPositionFromLeft
                  : null,
              // top: mqHeight* themeState.bottomNavBarPositionFromTop,
              child: Container(
                  //---Default Height is 5% of Screen Height -----///
                  height: mqHeight * themeState.bottomNavBarHeight,
                  //---Default Width is 80% of Screen Width -----///
                  width: mqWidth * themeState.bottomNavBarWidth,
                  decoration: BoxDecoration(
                      color: themeState.isDefaultBottomNavBarBgColor
                          ? Theme.of(context).scaffoldBackgroundColor
                          : Color(themeState.customBottomNavBarBgColor),
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: themeState.isDarkMode
                              ? Colors.white54
                              : Colors.black45,
                          blurRadius: 3,
                        ),
                      ]),

                  //---------------- Buttons ---------------//
                  child: Row(
                    children: [
                      //--- Audio Button ---//
                      BottomNavBarButtonWidget(
                        icon: HugeIcons.strokeRoundedMusicNote02,
                        isSelected: index == 0,
                        pageIndex: 0,
                      ),

                      //--- Video Button ---//
                      BottomNavBarButtonWidget(
                        icon: HugeIcons.strokeRoundedFolderVideo,
                        isSelected: index == 1,
                        pageIndex: 1,
                      ),

                      //--- Settings Button ---//
                      BottomNavBarButtonWidget(
                          icon: HugeIcons.strokeRoundedSettings05,
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
