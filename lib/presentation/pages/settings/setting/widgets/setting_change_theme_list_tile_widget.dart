import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_player/presentation/pages/settings/change-theme/ui/change-theme-page.dart';

import '../../../../../logic/theme_cubit/theme_cubit.dart';
import '../../../../../logic/theme_cubit/theme_state.dart';
import '../../../../common/texty.dart';

class SettingChangeThemeSwitchListTileWidget extends StatelessWidget {
  const SettingChangeThemeSwitchListTileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Visibility(
          visible: !state.defaultTheme,
          child: ListTile(
            leading: const Icon(Icons.color_lens),
            title: const Texty(
                en: "Change Theme",
                ar: "تغيير الثيم",
                es: "Cambiar tema",
                fr: "Changer le thème",
                hi: "थीम बदलें",
                ur: "تھیم تبدیل کریں",
                zh: "更改主题",
                ps: "موضوع بدل کړئ",
                kr: "테마 변경",
                ru: "Изменить тему"),
            trailing: CircleAvatar(
              radius: 15,
              backgroundColor: Theme.of(context).primaryColor,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChangeThemePage(),
                  ));
            },
          ),
        );
      },
    );
  }
}
