import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_player/logic/theme_cubit/theme_cubit.dart';
import 'package:open_player/presentation/pages/settings/setting/widgets/setting_custom_color_selection_list_tile_widget.dart';

import '../../../../../logic/theme_cubit/theme_state.dart';

class SettingChangeScaffoldColorTileWidget extends StatelessWidget {
  const SettingChangeScaffoldColorTileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return SettingCustomColorSelectionListTileWidget(
          tileLabelEn: "Change Scaffold Color",
          tileLabelAr: "تغيير لون السقالة",
          tileLabelEs: "Cambiar el color del scaffold",
          tileLabelFr: "Changer la couleur du scaffold",
          tileLabelHi: "स्कैफोल्ड का रंग बदलें",
          tileLabelUr: "سکافولڈ کا رنگ تبدیل کریں",
          tileLabelZh: "更改脚手架颜色",
          tileLabelPs: "د سکارفولډ رنګ بدل کړئ",
          tileLabelKr: "스캐폴드 색상 변경",
          tileLabelRu: "Изменить цвет каркаса",
          defaultThemeColor: Colors.transparent,
          isDefaultThemeColor: themeState.isDefaultScaffoldColor,
          resetToDefaultThemeColorButton: () {
            context.read<ThemeCubit>().resetToDefaultScaffoldColor();
            Navigator.pop(context);
          },
          selectColorOnTap: ({required colorCode}) {
            context.read<ThemeCubit>().changeScaffoldBgColor(colorCode);
          },
          customColor: Color(themeState.customScaffoldColor),
        );
      },
    );
  }
}
