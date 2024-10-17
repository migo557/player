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
          tileLabelAr: "تغيير لون خلفية شريط التنقل السفلي",
          tileLabelEs:
              "Cambiar el color de fondo de la barra de navegación inferior",
          tileLabelFr:
              "Changer la couleur d'arrière-plan de la barre de navigation inférieure",
          tileLabelHi: "नीचे नेविगेशन बार की पृष्ठभूमि का रंग बदलें",
          tileLabelUr: "نیچے نیویگیشن بار کا پس منظر رنگ تبدیل کریں",
          tileLabelZh: "更改底部导航栏背景颜色",
          tileLabelPs: "د لاندې نیویگیشن بار شالید رنګ بدل کړئ",
          tileLabelKr: "하단 탐색 바 배경 색상 변경",
          tileLabelRu: "Изменить цвет фона нижней навигационной панели",
          defaultThemeColor: Colors.transparent,
          isDefaultThemeColor: themeState.isDefaultBottomNavBarBgColor,
          selectColorOnTap: ({required colorCode}) {
            context.read<ThemeCubit>().changeBottomNavBarBgColor(colorCode);
          },
          resetToDefaultThemeColorButton: () {
            context.read<ThemeCubit>().resetToDefaultBottomNavBarBgColor();
            Navigator.pop(context);
          },
          customColor: Color(themeState.customBottomNavBarBgColor),
        );
      },
    );
  }
}
