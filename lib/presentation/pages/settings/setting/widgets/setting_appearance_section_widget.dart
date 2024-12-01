import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_player/presentation/pages/settings/setting/widgets/setting_black_mode_switch_list_tile_widget.dart';
import 'package:open_player/presentation/pages/settings/setting/widgets/setting_change_theme_list_tile_widget.dart';
import 'package:open_player/presentation/pages/settings/setting/widgets/setting_dark_mode_button_widget.dart';
import 'package:open_player/presentation/pages/settings/setting/widgets/setting_restore_to_default_setting_widget.dart';
import 'package:open_player/presentation/pages/settings/setting/widgets/setting_toggle_default_theme_switch_list_tile_widget.dart';
import 'package:open_player/presentation/pages/settings/setting/widgets/setting_visual_customization_widget.dart';
import 'package:velocity_x/velocity_x.dart';


class SettingAppearanceSectionWidget extends StatelessWidget {
  const SettingAppearanceSectionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: true,
      title: [
        "APPEARANCE".text.size(20).make(),
        Icon(
          CupertinoIcons.color_filter,
          color: Theme.of(context).primaryColor,
        )
      ].row(),
      children: const [
        //!-------------------- Restore To Default Setting----------------///
        SettingRestoreToDefaultSettingWidget(),

        //!-------------------Theme Mode Switch Tile-----------------------------///
        SettingThemeModeSwitchButtonWidget(),

        ///!-------------------Default/Custom Theme Switch Tile-----------------------------///
        SettingToggleDefaultThemeSwitchListTileWidget(),

        //!-------------------Change Theme Switch Tile-----------------------------///
        SettingChangeThemeSwitchListTileWidget(),

        //!-------------------Black Mode Switch Tile-----------------------------///
        SettingBlackModeSwitchListTileWidget(),

        //!-------------------Visual Customization-----------------------------///
        SettingVisualCustomizationWidget()
      ],
    );
  }
}
