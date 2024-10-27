import 'package:flutter/material.dart';
import 'package:open_player/logic/audio_page_tab_bar_cubit/audio_page_tab_bar_cubit.dart';

import '../../../../../logic/bottom_nav_bar_cubit/bottom_nav_bar_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../logic/theme_cubit/theme_cubit.dart';
import '../../../../../logic/theme_cubit/theme_state.dart';

class BottomNavBarButtonWidget extends StatelessWidget {
  const BottomNavBarButtonWidget(
      {super.key,
      required this.icon,
      required this.isSelected,
      required this.pageIndex});
  final bool isSelected;
  final int pageIndex;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return Expanded(
          child: Transform.rotate(
            angle: themeState.bottomNavBarIconRotation,
            child: IconButton(
              isSelected: !themeState.isDefaultBottomNavBarRotation? isSelected:null,
              enableFeedback: true,
              style: ButtonStyle(
                backgroundColor:themeState.isDefaultBottomNavBarRotation?  WidgetStatePropertyAll( isSelected
                    ? themeState.isDarkMode ? Color(themeState.primaryColor):Theme.of(context).primaryColor : Theme.of(context).tabBarTheme.unselectedLabelColor
                    ):null,
              ),
              iconSize: 24,
              onPressed: () {
                context.read<BottomNavBarCubit>().changeIndex(index: pageIndex);
            
                if (pageIndex != 0) {
                  context.read<AudioPageTabBarCubit>().changeIndex(tabIndex: 0);
                }
              },
              icon: Icon(icon),
            ),
          ),
        );
      },
    );
  }
}
