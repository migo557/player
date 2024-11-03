import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_player/logic/theme_cubit/theme_cubit.dart';
import 'package:open_player/presentation/pages/settings/setting/widgets/setting_custom_color_selection_list_tile_widget.dart';

import '../../../../../logic/theme_cubit/theme_state.dart';

class SettingChangeBottomNavBarBgColorTileWidget extends StatelessWidget {
  const SettingChangeBottomNavBarBgColorTileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return SettingCustomColorSelectionListTileWidget(
          tileLabelEn: "Change Bottom Navigation-Bar Background Color",

          defaultThemeColor: Colors.transparent,
          isDefaultThemeColor: themeState.isDefaultBottomNavBarBgColor,
          selectColorOnTap: ({required colorCode}) {
            context.read<ThemeCubit>().changeBottomNavBarBgColor(colorCode);
          },
          resetToDefaultThemeColorButton: () {
            context.read<ThemeCubit>().resetToDefaultBottomNavBarBgColor();
            Navigator.pop(context);
          },
          customColor: themeState.customBottomNavBarBgColor != null? Color(themeState.customBottomNavBarBgColor!):null,
        );
      },
    );
  }
}
