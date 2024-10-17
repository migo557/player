import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:open_player/logic/theme_cubit/theme_cubit.dart';
import 'package:open_player/presentation/common/texty.dart';

import '../../../../../logic/theme_cubit/theme_state.dart';

class SettingDarkModeButtonWidget extends StatelessWidget {
  const SettingDarkModeButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return SwitchListTile(
          value: state.isDarkMode ?? false,
          onChanged: (value) {
            context.read<ThemeCubit>().toggleThemeMode();
          },
          title: const Row(
            children: [
              Icon(Icons.dark_mode),
              Gap(10),
              Texty(
                  en: "Dark Mode",
                  ar: "الوضع المظلم",
                  es: "Modo oscuro",
                  fr: "Mode sombre",
                  hi: "डार्क मोड",
                  ur: "ڈارک موڈ",
                  zh: "深色模式",
                  ps: "تاریک موډ",
                  kr: "어두운 모드",
                  ru: "Темный режим"),
            ],
          ),
        );
      },
    );
  }
}
