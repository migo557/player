import 'package:flutter/material.dart';
import 'package:open_player/base/assets/fonts/app-fonts.dart';
import 'package:open_player/presentation/pages/settings/setting/widgets/setting_bottom_navigation_bar_customization_widget.dart';
import 'package:open_player/presentation/pages/settings/setting/widgets/setting_change_app_bar_color_background_tile_widget.dart';
import 'package:open_player/presentation/pages/settings/setting/widgets/setting_change_bottom_nav_bar_bg_color_tile_widget.dart';
import 'package:open_player/presentation/pages/settings/setting/widgets/setting_change_scaffold_color_tile_widget.dart';
import 'package:open_player/presentation/pages/settings/setting/widgets/setting_contrast_level_widget.dart';

import '../../../../common/texty.dart';

class SettingVisualCustomizationWidget extends StatelessWidget {
  const SettingVisualCustomizationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ExpansionTile(title: Text("Customization"), children: [
      ExpansionTile(
        title: Texty(
          en: "Visual Customization",
          ar: "التخصيص البصري",
          es: "Personalización visual",
          fr: "Personnalisation visuelle",
          hi: "दृश्य अनुकूलन",
          kr: "시각적 사용자 정의",
          ps: "بصری تنظیم",
          ru: "Визуальная настройка",
          ur: "بصری تخصیص",
          zh: "视觉自定义",
          style: TextStyle(
              fontSize: 13,
              fontFamily: AppFonts.poppins,
              fontWeight: FontWeight.bold),
        ),
        children: [
          //--------- Contrast Level
          SettingContrastLevelWidget(),

          //--------- Change Scaffold Color
          SettingChangeScaffoldColorTileWidget(),

          //--------- Change App Bar Color
          SettingChangeAppBarColorBackgroundTileWidget(),
        ],
      ),

      //----------- Bottom Navigation Bar
      SettingBottomNavigationBarCustomizationWidget(),
    ]);
  }
}
