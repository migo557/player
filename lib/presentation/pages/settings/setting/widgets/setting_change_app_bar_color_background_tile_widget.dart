import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:open_player/logic/theme_cubit/theme_cubit.dart';
import 'package:open_player/presentation/pages/settings/setting/widgets/setting_custom_color_selection_list_tile_widget.dart';

import '../../../../../logic/theme_cubit/theme_state.dart';

class SettingChangeAppBarColorBackgroundTileWidget extends StatelessWidget {
  const SettingChangeAppBarColorBackgroundTileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return SettingCustomColorSelectionListTileWidget(
     tileLabelEn: "Change AppBar Color",
          tileLabelAr: "تغيير لون شريط التطبيق",
          tileLabelEs: "Cambiar el color de la AppBar",
          tileLabelFr: "Changer la couleur de l'AppBar",
          tileLabelHi: "एप बार का रंग बदलें",
          tileLabelUr: "ایپ بار کا رنگ تبدیل کریں",
          tileLabelZh: "更改应用栏颜色",
          tileLabelPs: "د ایپ بار رنګ بدل کړئ",
          tileLabelKr: "앱 바 색상 변경",
          tileLabelRu: "Изменить цвет AppBar",

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
            context.pop();
          },
          customColor:themeState.customAppBarColor!=null? Color(themeState.customAppBarColor!):null,
        );
      },
    );
  }
}
