import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:open_player/logic/theme_cubit/theme_cubit.dart';

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
            title:  const Row(
            children: [
              Icon(Icons.dark_mode),
                  Gap(10),
                Text("Dark Mode"),
              ],
            ),);
      },
    );
  }
}
