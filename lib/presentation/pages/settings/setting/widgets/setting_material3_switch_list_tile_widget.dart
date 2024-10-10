import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_player/logic/theme_cubit/theme_cubit.dart';

class SettingMaterial3SwitchListTileWidget extends StatelessWidget {
  const SettingMaterial3SwitchListTileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return Visibility(
              visible: !state.defaultTheme,
              child: SwitchListTile(
      value: state.useMaterial3,
      onChanged: (value) {
        context.read<ThemeCubit>().toggleMaterial3();
      },
      title: const Text("Material3 ")),
            );
          },
        );
  }
}
