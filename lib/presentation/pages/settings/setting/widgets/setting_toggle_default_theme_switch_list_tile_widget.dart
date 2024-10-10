import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_player/logic/theme_cubit/theme_cubit.dart';

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
            title: const Text("Custom Themes"));
      },
    );
  }
}
