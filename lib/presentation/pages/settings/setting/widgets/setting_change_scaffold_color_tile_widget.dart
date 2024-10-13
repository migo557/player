import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_player/logic/theme_cubit/theme_cubit.dart';
import 'package:open_player/presentation/pages/settings/setting/widgets/setting_custom_color_selection_list_tile_widget.dart';

class SettingChangeScaffoldColorTileWidget extends StatelessWidget {
  const SettingChangeScaffoldColorTileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return SettingCustomColorSelectionListTileWidget(
          tileLabel: "Change Scaffold Color",
          defaultThemeColor:
              Colors.transparent,
          isDefaultThemeColor:
              themeState.isDefaultScaffoldColor,
          resetToDefaultThemeColorButton: () {
            context
                .read<ThemeCubit>()
                .resetToDefaultScaffoldColor();
            Navigator.pop(context);
          },
          selectColorOnTap: ({required colorCode}) {
            context
                .read<ThemeCubit>()
                .changeScaffoldBgColor(colorCode);
          },
          customColor: Color(themeState.customScaffoldColor),
        );
      },
    );
  }
}
