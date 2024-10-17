import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:open_player/logic/theme_cubit/theme_cubit.dart';
import 'package:open_player/presentation/common/texty.dart';

import '../../../../../logic/theme_cubit/theme_state.dart';

class SettingToggleDefaultThemeSwitchListTileWidget extends StatelessWidget {
  const SettingToggleDefaultThemeSwitchListTileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return SwitchListTile(
            value: !state.defaultTheme,
            onChanged: (value) {
              context.read<ThemeCubit>().toggleDefaultTheme();
            },
            title: Row(
              children: [
                HugeIcon(icon: HugeIcons.strokeRoundedColors, color: Theme.of(context).iconTheme.color!),
                const Gap(10),
                const Texty(
                  en: "Custom Themes",
                  ar: "ثيمات مخصصة",
                  es: "Temas personalizados",
                  fr: "Thèmes personnalisés",
                  hi: "कस्टम थीम",
                  ur: "حسب ضرورت تھیم",
                  zh: "自定义主题",
                  ps: "خپل جوړ شوي موضوعات",
                  kr: "사용자 정의 테마",
                  ru: "Пользовательские темы"

                  ),
              ],
            ),
            
            );
      },
    );
  }
}
