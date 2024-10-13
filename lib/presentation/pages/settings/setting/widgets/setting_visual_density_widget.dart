import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:open_player/logic/theme_cubit/theme_cubit.dart';
import 'package:open_player/presentation/pages/settings/setting/widgets/setting_visual_density_list_tile_button_widget.dart';

class SettingVisualDensityWidget extends StatelessWidget {
  const SettingVisualDensityWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return const ExpansionTile(
          leading: Icon(HugeIcons.strokeRoundedListSetting),
          title: Text("Visual Density"),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SettingVisualDensityListTileButtonWidget(
                  label: "Standard",
                  visualDensity: VisualDensity.standard,
                ),
                SettingVisualDensityListTileButtonWidget(
                  label: "Comfortable",
                  visualDensity: VisualDensity.comfortable,
                ),
                SettingVisualDensityListTileButtonWidget(
                  label: "Compact",
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
