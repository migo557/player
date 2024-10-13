import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_player/logic/theme_cubit/theme_cubit.dart';
import 'package:open_player/presentation/pages/settings/setting/widgets/setting_custom_color_selection_list_tile_widget.dart';

class SettingChangeAppBarColorBackgroundTileWidget extends StatelessWidget {
  const SettingChangeAppBarColorBackgroundTileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return SettingCustomColorSelectionListTileWidget(
          tileLabel: "Change AppBar Color",
          defaultThemeColor: Colors.white,
          isDefaultThemeColor:
              themeState.isDefaultAppBarColor,
              selectColorOnTap: ({required colorCode}) {
            context
                .read<ThemeCubit>()
                .changeAppBarColor(colorCode);
          },
          resetToDefaultThemeColorButton: () {
            context
                .read<ThemeCubit>()
                .resetToDefaultAppBarColor();
            Navigator.pop(context);
          },
          customColor: Color(themeState.customAppBarColor),
        );
      },
    );
  }
}
